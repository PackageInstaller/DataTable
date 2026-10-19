using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("清除当前移动终点")]
public class BTGroundClearMove : Action
{
	[SharedRequired]
	public SharedVector3 posLeft;

	[SharedRequired]
	public SharedVector3 posRight;

	public override TaskStatus OnUpdate()
	{
		Entity entity = Owner.ToEntity();
		CompNav compNav = entity.GetCompNav();
		CompAI compAI = entity.GetCompAI();
		if (!compAI.CanStartCombatMove("BTGroundClearMove"))
		{
			return TaskStatus.Success;
		}
		Vector3 physicsPosition = entity.GetCompTransform().physicsPosition;
		SharedVector3 sharedVector = posLeft;
		Vector3 value = (posRight.Value = physicsPosition);
		sharedVector.Value = value;
		compAI.TryCommitCombatMoveDestination(compNav, physicsPosition, "BTGroundClearMove");
		compNav.isStopped = true;
		return TaskStatus.Success;
	}
}
