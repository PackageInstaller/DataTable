using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("当前时间", 0)]
[Description("返回从战斗开始到目前的毫秒数,从long强转成int")]
[Category("Logic/Control")]
public class GetRealTimeFromBattleStart : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("当前时间", () => (int)base.mSimContext.simStatus.mSimTime);
	}
}
