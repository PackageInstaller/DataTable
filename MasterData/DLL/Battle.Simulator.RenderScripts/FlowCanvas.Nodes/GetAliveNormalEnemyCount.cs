using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取存活的小怪数量", 0)]
[Category("Render/Agent")]
[Description("获取存活的小怪数量")]
public class GetAliveNormalEnemyCount : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("数量", delegate
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager == null)
			{
				return 0;
			}
			int num = 0;
			Dictionary<int, NAgent>.Enumerator enumerator = agentManager.mAgentsCreatedThisFrame.GetEnumerator();
			while (enumerator.MoveNext())
			{
				NAgent value = enumerator.Current.Value;
				if (value != null && RoleCampProcessor.IsEnemy(value.Camp))
				{
					long hP = (value.Blackboard as BBHumanoid).HP;
					EnemyType mEntityType = (value.Blackboard as BBHumanoid).m_LastSimFrameData.mEntityType;
					if (hP > 0 && mEntityType == EnemyType.MonsterNormal)
					{
						num++;
					}
				}
			}
			return num;
		});
	}
}
