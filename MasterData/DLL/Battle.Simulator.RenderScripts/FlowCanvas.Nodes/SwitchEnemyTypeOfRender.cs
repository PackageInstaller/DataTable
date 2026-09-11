using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断怪物类型(渲染)", 0)]
[Category("Render/Config")]
[Description("判断怪物类型, 小怪还是精英还是boss, 其他中包括玩家和AI")]
public class SwitchEnemyTypeOfRender : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentID");
		AddValueOutput("实体ID", "agentID", () => agentIDInput.value);
		FlowOutput MonsterNormal = AddFlowOutput("小怪", "normal");
		FlowOutput MonsterElitel = AddFlowOutput("精英", "elitel");
		FlowOutput MonsterBoss = AddFlowOutput("首领", "boss");
		FlowOutput Other = AddFlowOutput("其他", "other");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null)
			{
				errorOut.Call(f);
			}
			else
			{
				BBHumanoid bBHumanoid = agent.Blackboard as BBHumanoid;
				if (bBHumanoid == null)
				{
					errorOut.Call(f);
				}
				else
				{
					switch (bBHumanoid.m_LastSimFrameData.mEntityType)
					{
					case EnemyType.MonsterBoss:
						MonsterBoss.Call(f);
						break;
					case EnemyType.MonsterElitel:
						MonsterElitel.Call(f);
						break;
					case EnemyType.MonsterNormal:
						MonsterNormal.Call(f);
						break;
					case EnemyType.Other:
						Other.Call(f);
						break;
					}
				}
			}
		});
	}
}
