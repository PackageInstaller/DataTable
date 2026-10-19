using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("待定把，要不要和CheckDistanceWithApostion合并呢？ 判断是否在范围内")]
public class BTCheckInDistance : Conditional
{
	public SharedAirEnemyUpdatePos sharedAirEnemyUpdatePos;

	public PosSourceType posSourceType;

	public SharedFloat distance;

	public override void OnStart()
	{
		if (sharedAirEnemyUpdatePos.Value != null)
		{
			distance.Value = sharedAirEnemyUpdatePos.Value.bufferRange;
		}
	}

	public override TaskStatus OnUpdate()
	{
		Entity entity = ((ActBehaviorTree)Owner).Entity;
		Entity hatredTarget = entity.GetCompHatred().hatredTarget;
		CompTransform compTransform = entity.GetCompTransform();
		Vector3 vector = ((!hatredTarget.IsValid) ? compTransform.physicsPosition : AbilityUtility.GetTargetPosition(hatredTarget, posSourceType));
		if (!((vector - compTransform.physicsPosition).sqrMagnitude > distance.Value * distance.Value))
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
