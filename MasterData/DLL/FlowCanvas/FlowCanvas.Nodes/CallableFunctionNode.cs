namespace FlowCanvas.Nodes;

public abstract class CallableFunctionNode<TResult> : CallableFunctionNodeBase
{
	private TResult result;

	public abstract TResult Invoke();

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		FlowOutput o = node.AddFlowOutput(" ");
		node.AddValueOutput("Value", () => result);
		node.AddFlowInput(" ", delegate(Flow f)
		{
			result = Invoke();
			o.Call(f);
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		result = default(TResult);
	}
}
public abstract class CallableFunctionNode<TResult, T1> : CallableFunctionNodeBase
{
	private TResult result;

	public abstract TResult Invoke(T1 a);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		FlowOutput o = node.AddFlowOutput(" ");
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		node.AddValueOutput("Value", () => result);
		node.AddFlowInput(" ", delegate(Flow f)
		{
			result = Invoke(p1.value);
			o.Call(f);
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		result = default(TResult);
	}
}
public abstract class CallableFunctionNode<TResult, T1, T2> : CallableFunctionNodeBase
{
	private TResult result;

	public abstract TResult Invoke(T1 a, T2 b);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		FlowOutput o = node.AddFlowOutput(" ");
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		node.AddValueOutput("Value", () => result);
		node.AddFlowInput(" ", delegate(Flow f)
		{
			result = Invoke(p1.value, p2.value);
			o.Call(f);
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		result = default(TResult);
	}
}
public abstract class CallableFunctionNode<TResult, T1, T2, T3> : CallableFunctionNodeBase
{
	private TResult result;

	public abstract TResult Invoke(T1 a, T2 b, T3 c);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		FlowOutput o = node.AddFlowOutput(" ");
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		node.AddValueOutput("Value", () => result);
		node.AddFlowInput(" ", delegate(Flow f)
		{
			result = Invoke(p1.value, p2.value, p3.value);
			o.Call(f);
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		result = default(TResult);
	}
}
public abstract class CallableFunctionNode<TResult, T1, T2, T3, T4> : CallableFunctionNodeBase
{
	private TResult result;

	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		FlowOutput o = node.AddFlowOutput(" ");
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		node.AddValueOutput("Value", () => result);
		node.AddFlowInput(" ", delegate(Flow f)
		{
			result = Invoke(p1.value, p2.value, p3.value, p4.value);
			o.Call(f);
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		result = default(TResult);
	}
}
public abstract class CallableFunctionNode<TResult, T1, T2, T3, T4, T5> : CallableFunctionNodeBase
{
	private TResult result;

	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d, T5 e);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		FlowOutput o = node.AddFlowOutput(" ");
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		ValueInput<T5> p5 = node.AddValueInput<T5>(base.parameters[4].Name);
		node.AddValueOutput("Value", () => result);
		node.AddFlowInput(" ", delegate(Flow f)
		{
			result = Invoke(p1.value, p2.value, p3.value, p4.value, p5.value);
			o.Call(f);
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		result = default(TResult);
	}
}
public abstract class CallableFunctionNode<TResult, T1, T2, T3, T4, T5, T6> : CallableFunctionNodeBase
{
	private TResult result;

	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		FlowOutput o = node.AddFlowOutput(" ");
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		ValueInput<T5> p5 = node.AddValueInput<T5>(base.parameters[4].Name);
		ValueInput<T6> p6 = node.AddValueInput<T6>(base.parameters[5].Name);
		node.AddValueOutput("Value", () => result);
		node.AddFlowInput(" ", delegate(Flow f)
		{
			result = Invoke(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value);
			o.Call(f);
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		result = default(TResult);
	}
}
public abstract class CallableFunctionNode<TResult, T1, T2, T3, T4, T5, T6, T7> : CallableFunctionNodeBase
{
	private TResult result;

	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		FlowOutput o = node.AddFlowOutput(" ");
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		ValueInput<T5> p5 = node.AddValueInput<T5>(base.parameters[4].Name);
		ValueInput<T6> p6 = node.AddValueInput<T6>(base.parameters[5].Name);
		ValueInput<T7> p7 = node.AddValueInput<T7>(base.parameters[6].Name);
		node.AddValueOutput("Value", () => result);
		node.AddFlowInput(" ", delegate(Flow f)
		{
			result = Invoke(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value, p7.value);
			o.Call(f);
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		result = default(TResult);
	}
}
public abstract class CallableFunctionNode<TResult, T1, T2, T3, T4, T5, T6, T7, T8> : CallableFunctionNodeBase
{
	private TResult result;

	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g, T8 h);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		FlowOutput o = node.AddFlowOutput(" ");
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		ValueInput<T5> p5 = node.AddValueInput<T5>(base.parameters[4].Name);
		ValueInput<T6> p6 = node.AddValueInput<T6>(base.parameters[5].Name);
		ValueInput<T7> p7 = node.AddValueInput<T7>(base.parameters[6].Name);
		ValueInput<T8> p8 = node.AddValueInput<T8>(base.parameters[7].Name);
		node.AddValueOutput("Value", () => result);
		node.AddFlowInput(" ", delegate(Flow f)
		{
			result = Invoke(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value, p7.value, p8.value);
			o.Call(f);
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		result = default(TResult);
	}
}
public abstract class CallableFunctionNode<TResult, T1, T2, T3, T4, T5, T6, T7, T8, T9> : CallableFunctionNodeBase
{
	private TResult result;

	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g, T8 h, T9 i);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		FlowOutput o = node.AddFlowOutput(" ");
		ValueInput<T1> p1 = node.AddValueInput<T1>(base.parameters[0].Name);
		ValueInput<T2> p2 = node.AddValueInput<T2>(base.parameters[1].Name);
		ValueInput<T3> p3 = node.AddValueInput<T3>(base.parameters[2].Name);
		ValueInput<T4> p4 = node.AddValueInput<T4>(base.parameters[3].Name);
		ValueInput<T5> p5 = node.AddValueInput<T5>(base.parameters[4].Name);
		ValueInput<T6> p6 = node.AddValueInput<T6>(base.parameters[5].Name);
		ValueInput<T7> p7 = node.AddValueInput<T7>(base.parameters[6].Name);
		ValueInput<T8> p8 = node.AddValueInput<T8>(base.parameters[7].Name);
		ValueInput<T9> p9 = node.AddValueInput<T9>(base.parameters[8].Name);
		node.AddValueOutput("Value", () => result);
		node.AddFlowInput(" ", delegate(Flow f)
		{
			result = Invoke(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value, p7.value, p8.value, p9.value);
			o.Call(f);
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		result = default(TResult);
	}
}
public abstract class CallableFunctionNode<TResult, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> : CallableFunctionNodeBase
{
	private TResult result;

	public abstract TResult Invoke(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g, T8 h, T9 i, T10 j);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		FlowOutput o = node.AddFlowOutput(" ");
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
		node.AddValueOutput("Value", () => result);
		node.AddFlowInput(" ", delegate(Flow f)
		{
			result = Invoke(p1.value, p2.value, p3.value, p4.value, p5.value, p6.value, p7.value, p8.value, p9.value, p10.value);
			o.Call(f);
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		result = default(TResult);
	}
}
