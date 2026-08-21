using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断阵营(通过AgentID)", 0)]
[Category("Render/Config")]
[Description("判断输入的entityID判断是哪一方")]
public class GetAgentCamp : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("AgentID");
		AddValueOutput("AgentID", () => entityID.value);
		FlowOutput enemyOut = AddFlowOutput("敌方阵营");
		FlowOutput playerOut = AddFlowOutput("玩家阵营");
		FlowOutput other = AddFlowOutput("其他阵营");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			int value = entityID.value;
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager == null)
			{
				errorOut.Call(f);
			}
			else
			{
				NAgent agent = agentManager.GetAgent(value);
				if (agent == null)
				{
					errorOut.Call(f);
				}
				else
				{
					uint camp = agent.Camp;
					if (RoleCampProcessor.IsEnemy(camp))
					{
						enemyOut.Call(f);
					}
					else if (RoleCampProcessor.IsPlayer(camp))
					{
						playerOut.Call(f);
					}
					else
					{
						other.Call(f);
					}
				}
			}
		});
	}
}
