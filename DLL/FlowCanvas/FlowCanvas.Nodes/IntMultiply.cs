using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int")]
[Name("×", 0)]
[Description("Int Multiply")]
public class IntMultiply : PureFunctionNode<Int, Int, Int>
{
	public override Int Invoke(Int a, Int b)
	{
		return a * b;
	}
}
