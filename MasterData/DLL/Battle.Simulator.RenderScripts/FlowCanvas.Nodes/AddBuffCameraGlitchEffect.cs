using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加Buff镜头故障(渲染)", 0)]
[Category("Render/Buff/Buff特效/镜头故障")]
[Description("BUFF使用镜头故障特效(Render)")]
public class AddBuffCameraGlitchEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "Out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "异常");
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "AddBuffCameraGlitchEffectProcessor_In_AgentID");
		ValueInput<int> buffIDVar = AddValueInput<int>("创建ID", "AddBuffCameraGlitchEffectProcessor_In_BuffID");
		ValueInput<float> glitchIntensityVar = AddValueInput<float>("强度(0-1)", "AddBuffCameraGlitchEffectProcessor_In_glitchIntensityVar");
		ValueInput<float> glitchFrequencyVar = AddValueInput<float>("频率(0-30)", "AddBuffCameraGlitchEffectProcessor_In_glitchFrequencyVar");
		AddFlowInput("In", delegate(Flow f)
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
						componentTimeline.AddBuffCameraGlitchEffect(buffIDVar.GetValue(), glitchIntensityVar.GetValue(), glitchFrequencyVar.GetValue());
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", () => agentIDVar.value, "AddBuffCameraGlitchEffectProcessor_Out_AgentID");
		AddValueOutput("创建ID", "BuffCreationIndex", () => buffIDVar.GetValue());
	}
}
