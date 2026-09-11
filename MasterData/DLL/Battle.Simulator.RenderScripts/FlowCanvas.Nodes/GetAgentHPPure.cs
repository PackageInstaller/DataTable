using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取Agent血量(pure)", 0)]
[Category("Render/Agent")]
[Description("获取生命值")]
public class GetAgentHPPure : PureFunctionNode<long, int>
{
	public override long Invoke(int agentID)
	{
		AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
		if (agentManager == null)
		{
			return 0L;
		}
		NAgent agent = agentManager.GetAgent(agentID);
		if (agent != null)
		{
			return (agent.Blackboard as BBHumanoid).HP;
		}
		return 0L;
	}
}
