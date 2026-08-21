using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff运行时间比(渲染)", 0)]
[Category("Render/Attribute")]
[Description("得到BUFF运行的总时间比率,范围为0-1")]
public class GetBuffRuntimeRate : FlowControlNode
{
	private float m_runTimeRate;

	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "agentIDVar");
		ValueInput<int> buffIDVar = AddValueInput<int>("创建ID", "buffIDVar");
		FlowOutput abnormalOut = AddFlowOutput("异常", "abnormalOut");
		FlowOutput nullOut = AddFlowOutput("无BUFF", "nullOut");
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				abnormalOut.Call(f);
			}
			else if (!BuffRuntimtRateHelper.TryGetBuffRuntimeRate(battleScene, agentIDVar.GetValue(), buffIDVar.GetValue(), out m_runTimeRate))
			{
				nullOut.Call(f);
			}
			else
			{
				output.Call(f);
			}
		});
		AddValueOutput("Buff运行时间比(0-1)", "buffRuntimeRate", () => m_runTimeRate);
	}
}
