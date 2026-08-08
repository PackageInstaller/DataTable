using System.Reflection;
using ParadoxNotion;

namespace FlowCanvas.Nodes.Legacy;

public sealed class ReflectedFunctionNode<TResult> : ReflectedMethodNode
{
	private FunctionCall<TResult> call;

	private TResult returnValue;

	private TResult Call()
	{
		return returnValue = call();
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<FunctionCall<TResult>>(null);
		if (options.callable)
		{
			FlowOutput o = node.AddFlowOutput(" ");
			node.AddFlowInput(" ", delegate(Flow f)
			{
				Call();
				o.Call(f);
			});
		}
		node.AddValueOutput("Value", () => (!options.callable) ? Call() : returnValue);
	}
}
public sealed class ReflectedFunctionNode<T1, TResult> : ReflectedMethodNode
{
	private FunctionCall<T1, TResult> call;

	private TResult returnValue;

	private T1 instance;

	private TResult Call(T1 a)
	{
		instance = a;
		return returnValue = call(a);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<FunctionCall<T1, TResult>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		if (options.callable)
		{
			FlowOutput o = node.AddFlowOutput(" ");
			node.AddFlowInput(" ", delegate(Flow f)
			{
				Call(p1.value);
				o.Call(f);
			});
			if (!method.IsStatic)
			{
				node.AddValueOutput(GetName(method, 0), () => instance);
			}
		}
		node.AddValueOutput("Value", () => (!options.callable) ? Call(p1.value) : returnValue);
	}
}
public sealed class ReflectedFunctionNode<T1, T2, TResult> : ReflectedMethodNode
{
	private FunctionCall<T1, T2, TResult> call;

	private TResult returnValue;

	private T1 instance;

	private TResult Call(T1 a, T2 b)
	{
		instance = a;
		return returnValue = call(a, b);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<FunctionCall<T1, T2, TResult>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		if (options.callable)
		{
			FlowOutput o = node.AddFlowOutput(" ");
			node.AddFlowInput(" ", delegate(Flow f)
			{
				Call(p1.value, p2.value);
				o.Call(f);
			});
			if (!method.IsStatic)
			{
				node.AddValueOutput(GetName(method, 0), () => instance);
			}
		}
		node.AddValueOutput("Value", () => (!options.callable) ? Call(p1.value, p2.value) : returnValue);
	}
}
public sealed class ReflectedFunctionNode<T1, T2, T3, TResult> : ReflectedMethodNode
{
	private FunctionCall<T1, T2, T3, TResult> call;

	private TResult returnValue;

	private T1 instance;

	private TResult Call(T1 a, T2 b, T3 c)
	{
		instance = a;
		return returnValue = call(a, b, c);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<FunctionCall<T1, T2, T3, TResult>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		ValueInput<T3> p3 = node.AddValueInput<T3>(GetName(method, 2));
		if (options.callable)
		{
			FlowOutput o = node.AddFlowOutput(" ");
			node.AddFlowInput(" ", delegate(Flow f)
			{
				Call(p1.value, p2.value, p3.value);
				o.Call(f);
			});
			if (!method.IsStatic)
			{
				node.AddValueOutput(GetName(method, 0), () => instance);
			}
		}
		node.AddValueOutput("Value", () => (!options.callable) ? Call(p1.value, p2.value, p3.value) : returnValue);
	}
}
public sealed class ReflectedFunctionNode<T1, T2, T3, T4, TResult> : ReflectedMethodNode
{
	private FunctionCall<T1, T2, T3, T4, TResult> call;

	private TResult returnValue;

	private T1 instance;

	private TResult Call(T1 a, T2 b, T3 c, T4 d)
	{
		instance = a;
		return returnValue = call(a, b, c, d);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<FunctionCall<T1, T2, T3, T4, TResult>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		ValueInput<T3> p3 = node.AddValueInput<T3>(GetName(method, 2));
		ValueInput<T4> p4 = node.AddValueInput<T4>(GetName(method, 3));
		if (options.callable)
		{
			FlowOutput o = node.AddFlowOutput(" ");
			node.AddFlowInput(" ", delegate(Flow f)
			{
				Call(p1.value, p2.value, p3.value, p4.value);
				o.Call(f);
			});
			if (!method.IsStatic)
			{
				node.AddValueOutput(GetName(method, 0), () => instance);
			}
		}
		node.AddValueOutput("Value", () => (!options.callable) ? Call(p1.value, p2.value, p3.value, p4.value) : returnValue);
	}
}
public sealed class ReflectedFunctionNode<T1, T2, T3, T4, T5, TResult> : ReflectedMethodNode
{
	private FunctionCall<T1, T2, T3, T4, T5, TResult> call;

	private TResult returnValue;

	private T1 instance;

	private TResult Call(T1 a, T2 b, T3 c, T4 d, T5 e)
	{
		instance = a;
		return returnValue = call(a, b, c, d, e);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<FunctionCall<T1, T2, T3, T4, T5, TResult>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		ValueInput<T3> p3 = node.AddValueInput<T3>(GetName(method, 2));
		ValueInput<T4> p4 = node.AddValueInput<T4>(GetName(method, 3));
		ValueInput<T5> p5 = node.AddValueInput<T5>(GetName(method, 4));
		if (options.callable)
		{
			FlowOutput o = node.AddFlowOutput(" ");
			node.AddFlowInput(" ", delegate(Flow f)
			{
				Call(p1.value, p2.value, p3.value, p4.value, p5.value);
				o.Call(f);
			});
			if (!method.IsStatic)
			{
				node.AddValueOutput(GetName(method, 0), () => instance);
			}
		}
		node.AddValueOutput("Value", () => (!options.callable) ? Call(p1.value, p2.value, p3.value, p4.value, p5.value) : returnValue);
	}
}
public sealed class ReflectedFunctionNode<T1, T2, T3, T4, T5, T6, TResult> : ReflectedMethodNode
{
	private FunctionCall<T1, T2, T3, T4, T5, T6, TResult> call;

	private TResult returnValue;

	private T1 instance;

	private TResult Call(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f)
	{
		instance = a;
		return returnValue = call(a, b, c, d, e, f);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<FunctionCall<T1, T2, T3, T4, T5, T6, TResult>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		ValueInput<T3> p3 = node.AddValueInput<T3>(GetName(method, 2));
		ValueInput<T4> p4 = node.AddValueInput<T4>(GetName(method, 3));
		ValueInput<T5> p5 = node.AddValueInput<T5>(GetName(method, 4));
		ValueInput<T6> p6 = node.AddValueInput<T6>(GetName(method, 5));
		if (options.callable)
		{
			FlowOutput o = node.AddFlowOutput(" ");
			node.AddFlowInput(" ", delegate(Flow f)
			{
				Call(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value);
				o.Call(f);
			});
			if (!method.IsStatic)
			{
				node.AddValueOutput(GetName(method, 0), () => instance);
			}
		}
		node.AddValueOutput("Value", () => (!options.callable) ? Call(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value) : returnValue);
	}
}
public sealed class ReflectedFunctionNode<T1, T2, T3, T4, T5, T6, T7, TResult> : ReflectedMethodNode
{
	private FunctionCall<T1, T2, T3, T4, T5, T6, T7, TResult> call;

	private TResult returnValue;

	private T1 instance;

	private TResult Call(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g)
	{
		instance = a;
		return returnValue = call(a, b, c, d, e, f, g);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<FunctionCall<T1, T2, T3, T4, T5, T6, T7, TResult>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		ValueInput<T3> p3 = node.AddValueInput<T3>(GetName(method, 2));
		ValueInput<T4> p4 = node.AddValueInput<T4>(GetName(method, 3));
		ValueInput<T5> p5 = node.AddValueInput<T5>(GetName(method, 4));
		ValueInput<T6> p6 = node.AddValueInput<T6>(GetName(method, 5));
		ValueInput<T7> p7 = node.AddValueInput<T7>(GetName(method, 6));
		if (options.callable)
		{
			FlowOutput o = node.AddFlowOutput(" ");
			node.AddFlowInput(" ", delegate(Flow f)
			{
				Call(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value, p7.value);
				o.Call(f);
			});
			if (!method.IsStatic)
			{
				node.AddValueOutput(GetName(method, 0), () => instance);
			}
		}
		node.AddValueOutput("Value", () => (!options.callable) ? Call(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value, p7.value) : returnValue);
	}
}
public sealed class ReflectedFunctionNode<T1, T2, T3, T4, T5, T6, T7, T8, TResult> : ReflectedMethodNode
{
	private FunctionCall<T1, T2, T3, T4, T5, T6, T7, T8, TResult> call;

	private TResult returnValue;

	private T1 instance;

	private TResult Call(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g, T8 h)
	{
		instance = a;
		return returnValue = call(a, b, c, d, e, f, g, h);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<FunctionCall<T1, T2, T3, T4, T5, T6, T7, T8, TResult>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		ValueInput<T3> p3 = node.AddValueInput<T3>(GetName(method, 2));
		ValueInput<T4> p4 = node.AddValueInput<T4>(GetName(method, 3));
		ValueInput<T5> p5 = node.AddValueInput<T5>(GetName(method, 4));
		ValueInput<T6> p6 = node.AddValueInput<T6>(GetName(method, 5));
		ValueInput<T7> p7 = node.AddValueInput<T7>(GetName(method, 6));
		ValueInput<T8> p8 = node.AddValueInput<T8>(GetName(method, 7));
		if (options.callable)
		{
			FlowOutput o = node.AddFlowOutput(" ");
			node.AddFlowInput(" ", delegate(Flow f)
			{
				Call(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value, p7.value, p8.value);
				o.Call(f);
			});
			if (!method.IsStatic)
			{
				node.AddValueOutput(GetName(method, 0), () => instance);
			}
		}
		node.AddValueOutput("Value", () => (!options.callable) ? Call(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value, p7.value, p8.value) : returnValue);
	}
}
