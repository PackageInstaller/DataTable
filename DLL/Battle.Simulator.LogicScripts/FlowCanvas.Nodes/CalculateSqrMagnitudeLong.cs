using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计算距离(平方值)", 0)]
[Category("Logic/Math")]
[Description("a - b 距离的平方值")]
public class CalculateSqrMagnitudeLong : CallableFunctionNode<long, Int3, Int3>
{
	public override long Invoke(Int3 a, Int3 b)
	{
		return (a - b).sqrMagnitudeLong;
	}
}
