using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("在范围内Pure", 0)]
[Category("Common/Control")]
[Description("在指定范围内")]
public class InRangePure : PureFunctionNode<bool, int, int, int>
{
	public override bool Invoke(int value, int min, int max)
	{
		if (value >= min)
		{
			return value <= max;
		}
		return false;
	}
}
