using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("IntClamp", 0)]
[Category("Logic/Control")]
[Description("限制范围在min和max之间")]
public class IntClamp : PureFunctionNode<int, int, int, int>
{
	public override int Invoke(int value, int min, int max)
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
