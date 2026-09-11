using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Integers")]
[Name(">", 0)]
[Description("Integer Greater Than")]
public class IntegerGreaterThan : PureFunctionNode<bool, int, int>
{
	public override bool Invoke(int a, int b)
	{
		return a > b;
	}
}
