using System.Reflection;
using ParadoxNotion;

namespace FlowCanvas.Nodes.Legacy;

public sealed class ReflectedActionNode : ReflectedMethodNode
{
	private ActionCall call;

	private void Call()
	{
		call();
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<ActionCall>(null);
		FlowOutput o = node.AddFlowOutput(" ");
		node.AddFlowInput(" ", delegate(Flow f)
		{
			Call();
			o.Call(f);
		});
	}
}
public sealed class ReflectedActionNode<T1> : ReflectedMethodNode
{
	private ActionCall<T1> call;

	private T1 instance;

	private void Call(T1 a)
	{
		instance = a;
		call(a);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<ActionCall<T1>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
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
}
public sealed class ReflectedActionNode<T1, T2> : ReflectedMethodNode
{
	private ActionCall<T1, T2> call;

	private T1 instance;

	private void Call(T1 a, T2 b)
	{
		instance = a;
		call(a, b);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<ActionCall<T1, T2>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
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
}
public sealed class ReflectedActionNode<T1, T2, T3> : ReflectedMethodNode
{
	private ActionCall<T1, T2, T3> call;

	private T1 instance;

	private void Call(T1 a, T2 b, T3 c)
	{
		instance = a;
		call(a, b, c);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<ActionCall<T1, T2, T3>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		ValueInput<T3> p3 = node.AddValueInput<T3>(GetName(method, 2));
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
}
public sealed class ReflectedActionNode<T1, T2, T3, T4> : ReflectedMethodNode
{
	private ActionCall<T1, T2, T3, T4> call;

	private T1 instance;

	private void Call(T1 a, T2 b, T3 c, T4 d)
	{
		instance = a;
		call(a, b, c, d);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<ActionCall<T1, T2, T3, T4>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		ValueInput<T3> p3 = node.AddValueInput<T3>(GetName(method, 2));
		ValueInput<T4> p4 = node.AddValueInput<T4>(GetName(method, 3));
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
}
public sealed class ReflectedActionNode<T1, T2, T3, T4, T5> : ReflectedMethodNode
{
	private ActionCall<T1, T2, T3, T4, T5> call;

	private T1 instance;

	private void Call(T1 a, T2 b, T3 c, T4 d, T5 e)
	{
		instance = a;
		call(a, b, c, d, e);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<ActionCall<T1, T2, T3, T4, T5>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		ValueInput<T3> p3 = node.AddValueInput<T3>(GetName(method, 2));
		ValueInput<T4> p4 = node.AddValueInput<T4>(GetName(method, 3));
		ValueInput<T5> p5 = node.AddValueInput<T5>(GetName(method, 4));
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
}
public sealed class ReflectedActionNode<T1, T2, T3, T4, T5, T6> : ReflectedMethodNode
{
	private ActionCall<T1, T2, T3, T4, T5, T6> call;

	private T1 instance;

	private void Call(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f)
	{
		instance = a;
		call(a, b, c, d, e, f);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<ActionCall<T1, T2, T3, T4, T5, T6>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		ValueInput<T3> p3 = node.AddValueInput<T3>(GetName(method, 2));
		ValueInput<T4> p4 = node.AddValueInput<T4>(GetName(method, 3));
		ValueInput<T5> p5 = node.AddValueInput<T5>(GetName(method, 4));
		ValueInput<T6> p6 = node.AddValueInput<T6>(GetName(method, 5));
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
}
public sealed class ReflectedActionNode<T1, T2, T3, T4, T5, T6, T7> : ReflectedMethodNode
{
	private ActionCall<T1, T2, T3, T4, T5, T6, T7> call;

	private T1 instance;

	private void Call(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g)
	{
		instance = a;
		call(a, b, c, d, e, f, g);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<ActionCall<T1, T2, T3, T4, T5, T6, T7>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		ValueInput<T3> p3 = node.AddValueInput<T3>(GetName(method, 2));
		ValueInput<T4> p4 = node.AddValueInput<T4>(GetName(method, 3));
		ValueInput<T5> p5 = node.AddValueInput<T5>(GetName(method, 4));
		ValueInput<T6> p6 = node.AddValueInput<T6>(GetName(method, 5));
		ValueInput<T7> p7 = node.AddValueInput<T7>(GetName(method, 6));
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
}
public sealed class ReflectedActionNode<T1, T2, T3, T4, T5, T6, T7, T8> : ReflectedMethodNode
{
	private ActionCall<T1, T2, T3, T4, T5, T6, T7, T8> call;

	private T1 instance;

	private void Call(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g, T8 h)
	{
		instance = a;
		call(a, b, c, d, e, f, g, h);
	}

	public override void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options)
	{
		call = method.RTCreateDelegate<ActionCall<T1, T2, T3, T4, T5, T6, T7, T8>>(null);
		ValueInput<T1> p1 = node.AddValueInput<T1>(GetName(method, 0));
		ValueInput<T2> p2 = node.AddValueInput<T2>(GetName(method, 1));
		ValueInput<T3> p3 = node.AddValueInput<T3>(GetName(method, 2));
		ValueInput<T4> p4 = node.AddValueInput<T4>(GetName(method, 3));
		ValueInput<T5> p5 = node.AddValueInput<T5>(GetName(method, 4));
		ValueInput<T6> p6 = node.AddValueInput<T6>(GetName(method, 5));
		ValueInput<T7> p7 = node.AddValueInput<T7>(GetName(method, 6));
		ValueInput<T8> p8 = node.AddValueInput<T8>(GetName(method, 7));
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
}
