using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("+", 0)]
[Description("Int3 Add")]
public class Int3Add : PureFunctionNode<Int3, Int3, Int3>
{
	public override Int3 Invoke(Int3 a, Int3 b)
	{
		return a + b;
	}
}
