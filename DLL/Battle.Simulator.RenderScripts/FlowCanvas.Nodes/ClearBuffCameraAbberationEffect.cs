using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清除Buff画面分离(渲染)", 0)]
[Category("Render/Buff/Buff特效/画面分离")]
[Description("清除实体上的全部buff控制的画面分离效果(Render),但不会清除buff,仅仅是清除播放器控制的效果")]
public class ClearBuffCameraAbberationEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "Out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "异常");
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "agentIDVar");
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
						componentTimeline.ClearBuffCameraAbberationEffect();
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDVar.value);
	}
}
