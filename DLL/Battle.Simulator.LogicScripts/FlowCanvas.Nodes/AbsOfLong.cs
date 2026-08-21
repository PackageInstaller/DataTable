using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Abs(long)", 0)]
[Category("Common/Math")]
[Description("取 value 绝对值")]
[Color("c0c0c0")]
public class AbsOfLong : PureFunctionNode<long, long>
{
	public override long Invoke(long value)
	{
		if (value >= 0)
		{
			return value;
		}
		return -value;
	}
}
