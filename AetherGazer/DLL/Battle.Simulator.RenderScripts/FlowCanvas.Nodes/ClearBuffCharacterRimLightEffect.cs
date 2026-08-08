using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清除Buff外发光(渲染)", 0)]
[Category("Render/Buff/Buff特效/外发光")]
[Description("清除实体上的全部buff控制的外放光(Render),但不会清除buff,仅仅是清除播放器控制的效果")]
public class ClearBuffCharacterRimLightEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput abnormalOut = AddFlowOutput("异常", "abnormalOut");
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
						componentTimeline.ClearBuffRimList();
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDVar.value);
	}
}
