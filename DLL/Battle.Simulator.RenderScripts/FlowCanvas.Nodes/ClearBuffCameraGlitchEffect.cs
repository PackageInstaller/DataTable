using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清除Buff镜头故障(渲染)", 0)]
[Category("Render/Buff/Buff特效/镜头故障")]
[Description("清除实体上的全部buff控制的镜头故障特效(Render),但不会清除buff,仅仅是清除播放器控制的效果")]
public class ClearBuffCameraGlitchEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "Out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "异常");
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "agentIDVar");
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
						componentTimeline.ClearBuffCameraGlitchEffect();
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDVar.value);
	}
}
