using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using PathFinding2D.Runtime.Models;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("判断我能不能移动到仇恨目标的位置")]
public class CanMoveToPlayer : Conditional
{
	public override TaskStatus OnUpdate()
	{
		Entity entity = Owner.ToEntity();
		int areaMask = entity.GetCompNav().areaMask;
		Vector3 zero = Vector3.zero;
		Vector3 zero2 = Vector3.zero;
		Entity hatredTarget = entity.GetCompHatred().hatredTarget;
		if (hatredTarget.IsValid)
		{
			CompTransform compTransform = entity.GetCompTransform();
			CompNav? compNav = entity.GetCompNav();
			CompTransform? compTransform2 = hatredTarget.GetCompTransform();
			zero = (zero2 = compTransform.physicsPosition);
			zero.x += 0f - compTransform.size.x - 0.1f;
			zero2.x += compTransform.size.x + 0.1f;
			Vector3 physicsPosition = compTransform2.physicsPosition;
			NavigationMoveCapability moveCapability = compNav.moveCapability;
			if (ACTNavMeshAgent.CanNavigateBetween(zero, physicsPosition, areaMask, moveCapability) || ACTNavMeshAgent.CanNavigateBetween(zero2, physicsPosition, areaMask, moveCapability))
			{
				return TaskStatus.Success;
			}
		}
		return TaskStatus.Failure;
	}
}
