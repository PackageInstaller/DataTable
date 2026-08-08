using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("概率事件", 0)]
[Category("Logic/Random")]
[Description("给一个概率,返回是否发生,p为0到100的整数")]
public class RandomEvent : CallableFunctionNode<bool, int>
{
	public override bool Invoke(int p)
	{
		return FlowCanvasLogicFuncHelper.RandomEvent(p);
	}
}
