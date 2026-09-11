using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("随机返回1或者-1", 0)]
[Category("Logic/Random")]
[Description("随机返回1或者-1")]
public class GetRandom : CallableFunctionNode<int>
{
	public override int Invoke()
	{
		if (DRandom.Random(10u) % 2 == 0)
		{
			return 1;
		}
		return -1;
	}
}
