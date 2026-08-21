using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("LongClamp", 0)]
[Category("Logic/Control")]
[Description("限制范围在min和max之间")]
[Color("c0c0c0")]
public class LongClamp : PureFunctionNode<long, long, long, long>
{
	public override long Invoke(long value, long min, long max)
	{
		if (value < min)
		{
			return min;
		}
		if (value > max)
		{
			return max;
		}
		return value;
	}
}
