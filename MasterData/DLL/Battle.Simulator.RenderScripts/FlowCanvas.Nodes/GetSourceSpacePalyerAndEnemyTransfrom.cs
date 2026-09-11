using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取队长和怪物的tarnsform", 0)]
[Category("Render/Agent")]
[Description("获取进修正模式时的队长和镜头前的怪的transform")]
public class GetSourceSpacePalyerAndEnemyTransfrom : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("队长", delegate
		{
			Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
			int agentID = 0;
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				int mEntityID = enumerator.Current.Value.mEntityID;
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID);
				if (entityWithEntityID != null && entityWithEntityID.entityHealth.mCurrentHealth > 0)
				{
					agentID = mEntityID;
					break;
				}
			}
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentID);
			if (agent != null)
			{
				agent.transform.position = (agent.Blackboard as BBHumanoid).NextFramePosition;
				agent.transform.forward = (agent.Blackboard as BBHumanoid).NextFrameFaceDirection;
				return agent.transform;
			}
			return (Transform)null;
		});
		AddValueOutput("怪物", delegate
		{
			List<int>.Enumerator enumerator = SpawnProcessor.GetAllEnemy().GetEnumerator();
			SimEntity simEntity = null;
			while (enumerator.MoveNext())
			{
				simEntity = base.mSimContext.GetEntityWithEntityID(enumerator.Current);
			}
			int agentID = 0;
			if (simEntity != null)
			{
				agentID = simEntity.creationIndex;
			}
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentID);
			if (agent != null)
			{
				agent.transform.position = (agent.Blackboard as BBHumanoid).NextFramePosition;
				agent.transform.forward = (agent.Blackboard as BBHumanoid).NextFrameFaceDirection;
				return agent.transform;
			}
			return (Transform)null;
		});
	}
}
