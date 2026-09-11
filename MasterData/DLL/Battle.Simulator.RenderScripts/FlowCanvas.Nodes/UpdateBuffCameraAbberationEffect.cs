using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("更新Buff画面分离(渲染)", 0)]
[Category("Render/Buff/Buff特效/画面分离")]
[Description("更新画面分离特效(Render)")]
public class UpdateBuffCameraAbberationEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "Out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "异常");
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "agentIDVar");
		ValueInput<int> buffIDVar = AddValueInput<int>("创建ID", "buffIDVar");
		ValueInput<float> abberationIntensityVar = AddValueInput<float>("强度", "abberationIntensityVar");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				NAgent agent = battleScene.GetAgentManager().GetAgent(agentIDVar.GetValue());
				if (agent == null)
				{
					abnormalOut.Call(f);
				}
				else
				{
					ComponentTimeline componentTimeline = agent.ComponentTimeline;
					if (componentTimeline == null)
					{
						abnormalOut.Call(f);
					}
					else
					{
						componentTimeline.UpdateBuffCameraAbberationEffect(buffIDVar.GetValue(), abberationIntensityVar.GetValue());
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDVar.value);
		AddValueOutput("创建ID", "BuffCreationIndex", () => buffIDVar.GetValue());
	}
}
