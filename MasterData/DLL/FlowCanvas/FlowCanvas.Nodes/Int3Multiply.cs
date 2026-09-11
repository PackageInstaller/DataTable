using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3/int")]
[Name("×", 0)]
[Description("Int3 Multiply integer")]
public class Int3Multiply : PureFunctionNode<Int3, Int3, int>
{
	public override Int3 Invoke(Int3 a, int b)
	{
		return a * b;
	}
}
