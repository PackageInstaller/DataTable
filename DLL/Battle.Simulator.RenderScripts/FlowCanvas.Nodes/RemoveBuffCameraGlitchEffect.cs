using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除Buff镜头故障(渲染)", 0)]
[Category("Render/Buff/Buff特效/镜头故障")]
[Description("移除BUFFID对应镜头故障特效(Render)")]
public class RemoveBuffCameraGlitchEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "Out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "异常");
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "RemoveBuffCameraGlitchEffectProcessor_In_AgentID");
		ValueInput<int> buffIDVar = AddValueInput<int>("创建ID", "RemoveBuffCameraGlitchEffectProcessor_In_BuffID");
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
						componentTimeline.RemoveBuffCameraGlitchEffect(buffIDVar.GetValue());
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", () => agentIDVar.value, "RemoveBuffCameraGlitchEffectProcessor_Out_AgentID");
		AddValueOutput("创建ID", "BuffCreationIndex", () => buffIDVar.GetValue());
	}
}
