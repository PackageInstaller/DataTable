using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("多数神系(渲染)", 0)]
[Category("Render/Attribute")]
[Description("本次战斗玩家出场角色中占最多数量的神系,如果全部相同则返回5(其他)")]
public class RaceIDOfMaxCountAndCountRender : FlowControlNode
{
	private int m_raceIDOfMaxCount;

	private int m_count = 1;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_raceIDOfMaxCount = 0;
			m_count = 1;
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				m_raceIDOfMaxCount = battleScene.ready.SceneDataForExcehange.IndexOfMaxCountRace;
				m_count = battleScene.ready.SceneDataForExcehange.NumOfMaxCountRace;
			}
			output.Call(f);
		});
		AddValueOutput("多数神系", "raceIDOfMaxCount", () => m_raceIDOfMaxCount);
		AddValueOutput("数量", "count", () => m_count);
	}
}
