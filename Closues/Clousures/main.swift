//
//  main.swift
//  Clousures
//
//  Created by Yubin on 2017/1/17.
//  Copyright © 2017年 X. All rights reserved.
//

import Foundation

print("Hello, World!")

// MARK:- 一:闭包表达式
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

// MARK:- 1:闭包类似匿名函数
/*---------------------------------------------------------------------------------
 | 1: 闭包类似匿名函数
 | 2: 当一个函数的参数是闭包时,可以传入一个函数名,函数的参数和返回值类型要和闭包的参数和返回值类型相同
 ---------------------------------------------------------------------------------*/
func backword(s1:String,s2:String) ->Bool
{
    return s1 > s2
}

let names2 = names.sorted(by: backword)
print("2:\(names2)")

// MARK:2:闭包表达式
/*---------------------------------------------------------------------------------
 | { (parameters) -> returnType in
 |
 |    <#statements#>
 | }
 --------------------------------------------------------------------------------*/

// MARK:3:标准闭包表达式
/*---------------------------------------------------------------------------------
 | 1: 标准的闭包表达式
 | 2: 参数有圆括号括起来
 | 3: 参数类型可类型推断,也可显式标注
 | 4: 返回值类型要显示声明
 ---------------------------------------------------------------------------------*/
let names3 = names.sorted(by: { (s1:String,s2:String) -> Bool in return s1 > s2})
print("3:\(names3)")

// MARK:4:根据上下文推断类型 
/*---------------------------------------------------------------------------------
 | 1: 参数的类型以及返回值的类型都由编译器推断
 | 2: 省略参数的圆括号时,参数的类型一定不能显式类型标注,而要由编译器隐式推断,否则报编译时错误
 | 3: 当返回值的类型可以由编译器推断出来时,返回值得类型可写可不写
 ---------------------------------------------------------------------------------*/
let names4 = names.sorted(by: {s1,s2 -> Bool in return s1 > s2})
print("4:\(names4)")

// MARK:5:单表达式闭包隐式返回
/*---------------------------------------------------------------------------------
 | 1: 闭包体中只有一行表达式
 | 2: 表达式的返回类型可以推断出来
 | 3: <#return#> 关键字可以省略
 ---------------------------------------------------------------------------------*/
let names5 = names.sorted(by: {s1,s2 in  s1 > s2})
print("5:\(names5)")

// MARK:6:参数名称缩写
/*---------------------------------------------------------------------------------
 | 1: 内联闭包可以提供了参数名缩写功能,直接可以通过 $0 $1 $2 来顺序调用闭包的参数
 | 2: 如果在闭包表达式中使用了参数名称缩写,则可以在定义闭包时省略参数列表,不省略时会报错
 | 3: 参数名称缩写的类型会通过函数类型进行推断
 | 4: <#in#> 关键字也可以省略
 ---------------------------------------------------------------------------------*/
let names6 = names.sorted(by: {$0 > $1})
print("6:\(names6)")

// MARK:7:运算符方法
/*---------------------------------------------------------------------------------
 | 1: String 类型定义了关于大于号（>）的字符串实现 (> 相当于一个方法,用来比较两个字符创的大小)
 | 2: (>)作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值.而这正好与 sorted(by:) 方法的参数需要的函数类型相符合
 | 3: 因此,可以简单地传递一个大于号，Swift 可以自动推断出你想使用大于号的字符串函数实现
 ---------------------------------------------------------------------------------*/
let names7 = names.sorted(by: >)
print("7:\(names7)")


// MARK:- 二:尾随闭包

// MARK:- 1:尾随闭包使用
/*---------------------------------------------------------------------------------
 | 1: 函数要将闭包参数写在参数列表的最后面才能使用尾随闭包
 | 2: 尾随闭包是写在函数圆括号后面的闭包表达式
 | 3: 使用尾随闭包时不用写出它的参数表示
 | 4: 如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉
 ---------------------------------------------------------------------------------*/
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
}

// 以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure(closure: {
    // 闭包主体部分
})

// 以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    // 闭包主体部分
}

// MARK:2:(一:6)使用尾随闭包可以写成下面的样式
/*---------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------*/
let names22 = names.sorted(){$0 > $1}
print("22:\(names22)")

// MARK: - 三:值捕获

// MARK:- 1:嵌套函数的值捕获
/*---------------------------------------------------------------------------------
 | 1: 嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
 | 2: 下面的函数返回值是 () -> Int 类型,返回值是一个函数而不是普通的值
 | 3: 返回的函数不接收参数,每次调用返回一个Int数值
 | 4: 单独考虑嵌套函数 incrementer()，会发现它有些不同寻常
 | 5: <#incrementer()#> 函数并没有任何参数，但是在函数体内访问了 runningTotal 和 amount 变量
 | 6: 这是因为它从外围函数捕获了 <#runningTotal#> 和 <#amount#> 变量的 **引用**。
 | 7: 捕获引用保证了 <#runningTotal#> 和 <#amount#> 变量在调用完 <#makeIncrementer#> 后不会消失，并且保证了在下一次执行 `incrementer` 函数时，`runningTotal` 依旧存在。
 |
 ---------------------------------------------------------------------------------*/
func makeIncrementer(forAmount amount:Int) -> ()->Int
{
    var runningTotal = 0
    func incrementer() -> Int
    {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementer
}

var inc = makeIncrementer(forAmount: 2)
print(inc())
print(inc())
print(inc())
print(inc())
print(inc())


// MARK:- 四:闭包是引用类型
// MARK:- 1:闭包和函数都是引用类型
/*---------------------------------------------------------------------------------
 | 1: 函数和闭包都是引用类型。
 | 2: 无论你将函数或闭包赋值给一个常量还是变量，你实际上都是将常量或变量的值设置为对应函数或闭包的引用
 | 3: 上面的例子中，指向闭包的引用 <#inc#> 是一个常量，而并非闭包内容本身。
 | NB: 当闭包作为类的实例属性时,要注意循环引用(因为闭包是引用类型,类实例也是引用类型,两者相互引用会造成循环引用)
 ---------------------------------------------------------------------------------*/

// MARK:- 五:逃逸闭包
/*---------------------------------------------------------------------------------
 | 1: 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸
 | 2: 当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。
 | 3: 一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中
 | e.g: 举个例子，很多启动异步操作的函数接受一个闭包参数作为 completion handler。
 |      这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。
 |      在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调用。
 ---------------------------------------------------------------------------------*/
// MARK:- 1:逃逸闭包例子
/*---------------------------------------------------------------------------------
 | 1: <#someFunctionWithEscapingClosure(_:)#> 函数接受一个闭包作为参数，该闭包被添加到一个函数外定义的数组中
 | 2: 如果你不将这个参数标记为 @escaping，就会得到一个编译错误。
 ---------------------------------------------------------------------------------*/
var comletionHandlers:[()->Void] =  []
func someFunctionWithEscapingClosure(comletionHandler: @escaping ()->Void)
{
    comletionHandlers.append(comletionHandler)
}


// MARK:- 2:逃逸闭包必须显示引用<#self#>
/*---------------------------------------------------------------------------------
 | 1: 将一个闭包标记为 <#@escaping#> 意味着你必须在闭包中显式地引用 <#self#>
 | 2: 比如说，在下面的代码中，传递到 <#someFunctionWithEscapingClosure(_:)#> 中的闭包是一个逃逸闭包，这意味着它需要显式地引用 <#self#>。
 | 3: 相对的，传递到 <#someFunctionWithNonescapingClosure(_:)#> 中的闭包是一个非逃逸闭包，这意味着它可以隐式引用 <#self#>。
 ---------------------------------------------------------------------------------*/
func someFunctionWithNonescapingClosure(closure: ()->Void)
{
    closure()
}

class SomeClass {
    var x = 10;
    func doSomething(){
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 100 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

// MARK:- 六:自动闭包
/*---------------------------------------------------------------------------------
 |   1: 自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。
 | * 2: 这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。
 |   3: 这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
 |   4: 自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。
 |   5: 延迟求值对于那些有副作用（<#Side Effect#>）和高计算成本的代码来说是很有益处的，因为它使得你能控制代码的执行时机。
 |
 ---------------------------------------------------------------------------------*/
// MARK: - 1:下面的代码展示了闭包如何延时求值。
/*---------------------------------------------------------------------------------
 | 1: 尽管在闭包的代码中，customersInLine 的第一个元素被移除了，不过在闭包被调用之前，这个元素是不会被移除的。
 | 2: 如果这个闭包永远不被调用，那么在闭包里面的表达式将永远不会执行，那意味着列表中的元素永远不会被移除。
 | NB: <#customerProvider#> 的类型不是 <#String#>，而是 <#() -> String#>，一个没有参数且返回值为 <#String#> 的函数。
 ---------------------------------------------------------------------------------*/
var customersInLine = ["Chris","Alex","Ewa","Barry","Daniella"]
print(customersInLine.count)
// 打印出 "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// 打印出"5"

print("Now serving \(customerProvider())!")
// 打印出"Now serving Chris!"
print(customersInLine.count)
// 打印出"4"

// MARK:2:闭包作为参数传递给函数时，能获得同样的延时求值行为
/*---------------------------------------------------------------------------------
 | 1: <#serve(customer:)#> 函数接受一个返回顾客名字的显式的闭包。
 |
 |
 ---------------------------------------------------------------------------------*/
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// 打印出 "Now serving Alex!"

// MARK:3:自动闭包作为函数的参数
/*---------------------------------------------------------------------------------
 | 1: 下面这个版本的 <#serve(customer:#>) 完成了相同的操作，不过它并没有接受一个显式的闭包，而是通过将参数标记为 @autoclosure 来接收一个自动闭包。
 | 2: 现在你可以将该函数当作接受 String 类型参数（而非闭包）的函数来调用。
 | 3: customerProvider 参数将自动转化为一个闭包，因为该参数被标记了 @autoclosure 特性。
 | NB: 过度使用 autoclosures 会让你的代码变得难以理解。上下文和函数名应该能够清晰地表明求值是被延迟执行的。
 ---------------------------------------------------------------------------------*/
// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure ()->String)
{
    print("Now serving \(customerProvider())")
}
serve(customer: customersInLine.remove(at: 0))
// 打印出"Now serving Ewa"

// MARK:- 七:逃逸自动闭包
/*---------------------------------------------------------------------------------
 | 1: 如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性。
 | 2: 在下面的代码中，collectCustomerProviders(_:) 函数并没有调用传入的 customerProvider 闭包，而是将闭包追加到了 customerProviders 数组中。
 | 3: 这个数组定义在函数作用域范围外，这意味着数组内的闭包能够在函数返回之后被调用
 | 4: 因此，customerProvider 参数必须允许“逃逸”出函数作用域。
 ---------------------------------------------------------------------------------*/
// customersInLine i= ["Barry", "Daniella"]
var customerProviders:[()->String] = []
func collectCustomerProviders(_ customerProvider:@autoclosure @escaping ()->String)
{
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collect \(customerProviders.count) closures.");
// 打印"Collect 2 closures."
for customerProvider in customerProviders
{
    print("Now serving \(customerProvider())!")
}
// 打印 "Now serving Barry!"
// 打印 "Now serving Daniella!"








