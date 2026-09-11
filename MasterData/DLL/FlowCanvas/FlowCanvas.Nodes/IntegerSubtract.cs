using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Integers")]
[Name("-", 0)]
[Description("Integer Subtract")]
public class IntegerSubtract : PureFunctionNode<int, int, int>
{
	public override int Invoke(int a, int b)
	{
		return a - b;
	}
}
