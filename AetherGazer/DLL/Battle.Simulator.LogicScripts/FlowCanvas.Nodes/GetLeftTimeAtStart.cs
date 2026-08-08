using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取界面传进来的剩余时长", 0)]
[Description("获取界面传进来的剩余时长, 其实是一个整型变量, 默认是0. 说明没人设置过")]
[Category("Logic/Control")]
public class GetLeftTimeAtStart : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("毫秒数", () => (!(base.graph == null) && base.mSimContext != null && base.mSimContext.hasSEntityWorldState && base.mSimContext.sEntityWorldState.status != null) ? base.mSimContext.sEntityWorldState.status.leftTimeAtStart : 0);
	}
}
