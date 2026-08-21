using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Integers")]
[Name("≠", 0)]
[Description("Integer Not Equal To")]
public class IntegerNotEqual : PureFunctionNode<bool, int, int>
{
	public override bool Invoke(int a, int b)
	{
		return a != b;
	}
}
