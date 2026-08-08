using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("÷", 0)]
[Description("Int3 Divide")]
public class Int3Divide : PureFunctionNode<Int3, Int3, float>
{
	public override Int3 Invoke(Int3 a, float b)
	{
		return a / b;
	}
}
