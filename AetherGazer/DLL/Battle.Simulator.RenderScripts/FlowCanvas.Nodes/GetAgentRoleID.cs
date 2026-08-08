using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体类型ID(Render)", 0)]
[Category("Render/Agent")]
[Description("获取实体类型ID")]
public class GetAgentRoleID : PureFunctionNode<int, int>
{
	public override int Invoke(int agentID)
	{
		NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentID);
		if (agent != null)
		{
			BBHumanoid bBHumanoid = agent.Blackboard as BBHumanoid;
			if (bBHumanoid != null)
			{
				return bBHumanoid.RoleRenderConfig.ID;
			}
		}
		return 0;
	}
}
