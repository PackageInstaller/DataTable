using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取第一个存活的精英", 0)]
[Category("Render/Agent")]
[Description("获取第一个存活的并且可以被锁定的精英,boss也算, 如果没有的话,返回0")]
public class GetFirstAliveElitel : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("agentID", delegate
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager == null)
			{
				return 0;
			}
			int result = 0;
			Dictionary<int, NAgent>.Enumerator enumerator = agentManager.mAgentsCreatedThisFrame.GetEnumerator();
			while (enumerator.MoveNext())
			{
				NAgent value = enumerator.Current.Value;
				if (value != null && RoleCampProcessor.IsEnemy(value.Camp))
				{
					BBHumanoid bBHumanoid = value.Blackboard as BBHumanoid;
					if (!(bBHumanoid == null) && bBHumanoid.m_LastSimFrameData != null && !bBHumanoid.m_LastSimFrameData.mCantBeLocked)
					{
						long hP = bBHumanoid.HP;
						EnemyType mEntityType = bBHumanoid.m_LastSimFrameData.mEntityType;
						if (hP > 0 && (mEntityType == EnemyType.MonsterElitel || mEntityType == EnemyType.MonsterBoss))
						{
							result = enumerator.Current.Key;
							break;
						}
					}
				}
			}
			return result;
		});
	}
}
