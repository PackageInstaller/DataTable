using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Abs(integer)", 0)]
[Category("Common/Math")]
[Description("取 value 绝对值")]
[Color("c0c0c0")]
public class AbsOfInteger : PureFunctionNode<int, int>
{
	public override int Invoke(int value)
	{
		if (value >= 0)
		{
			return value;
		}
		return -value;
	}
}
