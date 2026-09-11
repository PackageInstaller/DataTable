using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("判断Agent类型", 0)]
[Category("Render/Agent")]
[Description("判断Agent类型")]
public class AgentType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID");
		FlowOutput MonsterNormal = AddFlowOutput("小怪");
		FlowOutput MonsterElitel = AddFlowOutput("精英");
		FlowOutput MonsterBoss = AddFlowOutput("BOSS");
		FlowOutput Other = AddFlowOutput("其他");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null)
			{
				Debug.Log(base.graph.name + "agent 为空");
				Other.Call(f);
			}
			else if (!RoleCampProcessor.IsEnemy(agent.Camp))
			{
				Other.Call(f);
			}
			else
			{
				switch ((agent.Blackboard as BBHumanoid).m_LastSimFrameData.mEntityType)
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
				default:
					Other.Call(f);
					break;
				}
			}
		});
	}
}
