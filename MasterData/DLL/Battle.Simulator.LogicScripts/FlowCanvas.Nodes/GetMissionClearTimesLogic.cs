using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取通关次数(逻辑)", 0)]
[Category("Render/UI")]
[Description("获取通关次数")]
public class GetMissionClearTimesLogic : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("通关次数", () => CommonProcessor.GetWorldState().mMissionClearTimes);
	}
}
