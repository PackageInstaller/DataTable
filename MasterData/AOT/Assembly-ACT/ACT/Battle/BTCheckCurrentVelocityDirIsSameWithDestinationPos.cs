using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("地面单位 判断 当前运动方向与寻路终点是否一致？")]
public class BTCheckCurrentVelocityDirIsSameWithDestinationPos : Conditional
{
	public override TaskStatus OnUpdate()
	{
		Entity entity = Owner.ToEntity();
		float num = entity.GetCompPhysics().rawVelocity.z * Time.deltaTime;
		if (Mathf.Approximately(num, 0f))
		{
			return TaskStatus.Success;
		}
		if (Mathf.Abs(num) < 0.1f)
		{
			return TaskStatus.Success;
		}
		float self = entity.GetCompTransform().physicsPosition.x + num;
		if (BoolUtility.IsInFront(entity.IsFaceLeft(), self, entity.GetCompNav().destination.x))
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
