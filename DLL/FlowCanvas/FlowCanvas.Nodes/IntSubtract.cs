using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int")]
[Name("-", 0)]
[Description("Int Subtract")]
public class IntSubtract : PureFunctionNode<Int, Int, Int>
{
	public override Int Invoke(Int a, Int b)
	{
		return a - b;
	}
}
