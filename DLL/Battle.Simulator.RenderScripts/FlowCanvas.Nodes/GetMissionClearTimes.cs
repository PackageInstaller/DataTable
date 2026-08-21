using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取通关次数(渲染)", 0)]
[Category("Render/UI")]
[Description("获取通关次数")]
public class GetMissionClearTimes : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("通关次数", () => (NScene.GetCurrentScene() as BattleScene).GetMapTriggerManager().missionClearTimes);
	}
}
