using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取Agent瞄准的目标", 0)]
[Category("Render/Agent")]
[Description("获取Agent瞄准的目标")]
[ExposeAsDefinition]
public class GetAgentTarget : FlowControlNode
{
	private int targetId;

	protected override void RegisterPorts()
	{
		ValueInput<int> agentId = AddValueInput<int>("实体Id");
		FlowOutput flowOutput = AddFlowOutput(" ");
		AddValueOutput("目标", () => targetId);
		AddFlowInput(" ", delegate(Flow f)
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			NAgent agent = agentManager.GetAgent(agentId.value);
			if (agent != null)
			{
				targetId = (agent.Blackboard as BBHumanoid).AimingTarget;
				NAgent agent2 = agentManager.GetAgent(targetId);
				if (agent2 == null)
				{
					targetId = 0;
				}
				else if ((agent2.Blackboard as BBHumanoid).HP <= 0)
				{
					targetId = 0;
				}
			}
			flowOutput.Call(f);
		});
	}
}
