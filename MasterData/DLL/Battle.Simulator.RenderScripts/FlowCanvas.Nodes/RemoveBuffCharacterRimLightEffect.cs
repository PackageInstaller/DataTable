using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除Buff外发光(渲染)", 0)]
[Category("Render/Buff/Buff特效/外发光")]
[Description("移除BUFFID对应外发光(Render)")]
public class RemoveBuffCharacterRimLightEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "AgentID");
		ValueInput<int> buffIDVar = AddValueInput<int>("创建ID", "BuffID");
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
						componentTimeline.RemoveBuffRimLight(buffIDVar.GetValue());
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("AgentID", () => agentIDVar.value);
	}
}
