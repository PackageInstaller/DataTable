using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("重置统计数据的时间", 0)]
[Category("Render/UI")]
[Description("重置统计数据的时间")]
public class ResetStatisticsDataTime : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			WorldStateManager worldSatetManager = (NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager();
			worldSatetManager.data.dataForLua.battleTime = 0f;
			worldSatetManager.gameStratFrame = (int)worldSatetManager.currentFrameNumber;
			output.Call(f);
		});
	}
}
