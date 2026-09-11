using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清除Buff角色干涉特效(渲染)", 0)]
[Category("Render/Buff/Buff特效/角色干涉特效")]
[Description("清除实体上的全部buff控制的角色干涉特效(Render),但不会清除buff,仅仅是清除播放器控制的效果")]
public class ClearBuffCharacterInterenceEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "abnormalOut");
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentIDInput");
		AddFlowInput("In", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				error.Call(f);
			}
			else
			{
				NAgent agent = battleScene.GetAgentManager().GetAgent(agentIDInput.GetValue());
				if (agent == null)
				{
					error.Call(f);
				}
				else
				{
					ComponentTimeline componentTimeline = agent.ComponentTimeline;
					if (componentTimeline == null)
					{
						error.Call(f);
					}
					else
					{
						componentTimeline.ClearBuffCharacterInterenceEffect();
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDInput.value);
	}
}
