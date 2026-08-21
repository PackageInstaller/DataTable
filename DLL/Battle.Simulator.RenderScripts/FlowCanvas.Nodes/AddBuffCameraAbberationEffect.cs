using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加Buff画面分离(渲染)", 0)]
[Category("Render/Buff/Buff特效/画面分离")]
[Description("BUFF使用画面分离特效")]
public class AddBuffCameraAbberationEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "Out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "异常");
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "AddBuffCameraAbberationEffect_In_AgentID");
		ValueInput<int> buffIDVar = AddValueInput<int>("创建ID", "AddBuffCameraAbberationEffect_In_BuffID");
		ValueInput<float> abberationIntensityVar = AddValueInput<float>("强度", "AddBuffCameraAbberationEffect_In_glitchIntensityVar");
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
						componentTimeline.AddBuffCameraAbberationEffect(buffIDVar.GetValue(), abberationIntensityVar.GetValue());
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", () => agentIDVar.value, "AddBuffCameraAbberationEffect_Out_AgentID");
		AddValueOutput("创建ID", "BuffCreationIndex", () => buffIDVar.GetValue());
	}
}
