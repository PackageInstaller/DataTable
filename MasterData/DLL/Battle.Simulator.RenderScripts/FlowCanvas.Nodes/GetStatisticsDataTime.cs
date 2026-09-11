using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取统计数据的时间", 0)]
[Category("Render/UI")]
[Description("获取统计数据的时间")]
public class GetStatisticsDataTime : FlowNode
{
	protected override void RegisterPorts()
	{
		float res = 0f;
		AddValueOutput("当前时间(秒)", () => res);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			WorldStateManager worldSatetManager = (NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager();
			res = worldSatetManager.data.dataForLua.battleTime;
			output.Call(f);
		});
	}
}
