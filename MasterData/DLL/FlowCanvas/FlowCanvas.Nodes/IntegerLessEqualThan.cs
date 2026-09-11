using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Integers")]
[Name("≤", 0)]
[Description("Integer Less Or Equal Than")]
public class IntegerLessEqualThan : PureFunctionNode<bool, int, int>
{
	public override bool Invoke(int a, int b)
	{
		return a <= b;
	}
}
