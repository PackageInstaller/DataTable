using ACT.NPC.BehaviorTree.Variables;
using ACT.NPC.BehaviorTree.Variables.BehaviorTreeAction;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.NPC.BehaviorTree.Condition;

[TaskCategory("NPC")]
[TaskDescription("到达指定位置")]
public class ReachPosition : NpcConditionBase
{
	public SharedNpcPatrolParam patrolParam;

	private bool _isReach;

	public override TaskStatus OnUpdate()
	{
		NpcPatrolParam npcPatrolParam = patrolParam?.Value;
		Transform modelTrans = OwnerEntity.GetModelTrans();
		if (npcPatrolParam == null || modelTrans == null)
		{
			return TaskStatus.Failure;
		}
		Vector3 position = modelTrans.position;
		if (!_isReach)
		{
			if (Vector3.Distance(position, npcPatrolParam.patrolPoint) < npcPatrolParam.reachDistance)
			{
				_isReach = true;
				OwnerEntity.GetCompNpc()?.ReachDestination(npcPatrolParam.patrolPoint);
				foreach (BehaviorActionWrap reachAction in npcPatrolParam.reachActions)
				{
					reachAction.GetAction()?.Execute(OwnerEntity);
				}
				return TaskStatus.Success;
			}
		}
		else if (Vector3.Distance(position, npcPatrolParam.patrolPoint) >= npcPatrolParam.reachDistance)
		{
			_isReach = false;
		}
		return TaskStatus.Failure;
	}
}
