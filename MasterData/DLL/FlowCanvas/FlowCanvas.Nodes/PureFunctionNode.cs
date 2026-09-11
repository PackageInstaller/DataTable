namespace FlowCanvas.Nodes;

public abstract class PureFunctionNode<TResult> : PureFunctionNodeBase
{
	public abstract TResult Invoke();

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		node.AddValueOutput("Value", () => Invoke());
	}
}
public abstract class PureFunctionNode<TResult, T1> : PureFunctionNodeBase
{
	public abstract TResult Invoke(T1 a);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		node.AddValueOutput("Value", () => Invoke(p1.value));
	}
}
public abstract class PureFunctionNode<TResult, T1, T2> : PureFunctionNodeBase
{
	public abstract TResult Invoke(T1 a, T2 b);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		node.AddValueOutput("Value", () => Invoke(p1.value, p2.value));
	}
}
public abstract class PureFunctionNode<TResult, T1, T2, T3> : PureFunctionNodeBase
{
	public abstract TResult Invoke(T1 a, T2 b, T3 c);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		node.AddValueOutput("Value", () => Invoke(p1.value, p2.value, p3.value));
	}
}
public abstract class PureFunctionNode<TResult, T1, T2, T3, T4> : PureFunctionNodeBase
{
	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		node.AddValueOutput("Value", () => Invoke(p1.value, p2.value, p3.value, p4.value));
	}
}
public abstract class PureFunctionNode<TResult, T1, T2, T3, T4, T5> : PureFunctionNodeBase
{
	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d, T5 e);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		ValueInput<T5> p5 = node.AddValueInput<T5>(base.parameters[4].Name);
		node.AddValueOutput("Value", () => Invoke(p1.value, p2.value, p3.value, p4.value, p5.value));
	}
}
public abstract class PureFunctionNode<TResult, T1, T2, T3, T4, T5, T6> : PureFunctionNodeBase
{
	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		ValueInput<T5> p5 = node.AddValueInput<T5>(base.parameters[4].Name);
		ValueInput<T6> p6 = node.AddValueInput<T6>(base.parameters[5].Name);
		node.AddValueOutput("Value", () => Invoke(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value));
	}
}
public abstract class PureFunctionNode<TResult, T1, T2, T3, T4, T5, T6, T7> : PureFunctionNodeBase
{
	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		ValueInput<T5> p5 = node.AddValueInput<T5>(base.parameters[4].Name);
		ValueInput<T6> p6 = node.AddValueInput<T6>(base.parameters[5].Name);
		ValueInput<T7> p7 = node.AddValueInput<T7>(base.parameters[6].Name);
		node.AddValueOutput("Value", () => Invoke(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value, p7.value));
	}
}
public abstract class PureFunctionNode<TResult, T1, T2, T3, T4, T5, T6, T7, T8> : PureFunctionNodeBase
{
	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g, T8 h);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		ValueInput<T5> p5 = node.AddValueInput<T5>(base.parameters[4].Name);
		ValueInput<T6> p6 = node.AddValueInput<T6>(base.parameters[5].Name);
		ValueInput<T7> p7 = node.AddValueInput<T7>(base.parameters[6].Name);
		ValueInput<T8> p8 = node.AddValueInput<T8>(base.parameters[7].Name);
		node.AddValueOutput("Value", () => Invoke(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value, p7.value, p8.value));
	}
}
public abstract class PureFunctionNode<TResult, T1, T2, T3, T4, T5, T6, T7, T8, T9> : PureFunctionNodeBase
{
	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g, T8 h, T9 i);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		ValueInput<T5> p5 = node.AddValueInput<T5>(base.parameters[4].Name);
		ValueInput<T6> p6 = node.AddValueInput<T6>(base.parameters[5].Name);
		ValueInput<T7> p7 = node.AddValueInput<T7>(base.parameters[6].Name);
		ValueInput<T8> p8 = node.AddValueInput<T8>(base.parameters[7].Name);
		ValueInput<T9> p9 = node.AddValueInput<T9>(base.parameters[8].Name);
		node.AddValueOutput("Value", () => Invoke(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value, p7.value, p8.value, p9.value));
	}
}
public abstract class PureFunctionNode<TResult, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> : PureFunctionNodeBase
{
	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g, T8 h, T9 i, T10 j);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		ValueInput<T5> p5 = node.AddValueInput<T5>(base.parameters[4].Name);
		ValueInput<T6> p6 = node.AddValueInput<T6>(base.parameters[5].Name);
		ValueInput<T7> p7 = node.AddValueInput<T7>(base.parameters[6].Name);
		ValueInput<T8> p8 = node.AddValueInput<T8>(base.parameters[7].Name);
		ValueInput<T9> p9 = node.AddValueInput<T9>(base.parameters[8].Name);
		ValueInput<T10> p10 = node.AddValueInput<T10>(base.parameters[9].Name);
		node.AddValueOutput("Value", () => Invoke(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value, p7.value, p8.value, p9.value, p10.value));
	}
}
