using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
[TaskDescription("辅助机从当前位置飞到指定位置，到达位置后返回success")]
public class RobotMoveToPosition : Action
{
	public float posDamping;

	public SharedVector3 targetPos;

	public float stopDistance = 0.1f;

	public SharedBool canMove;

	public override TaskStatus OnUpdate()
	{
		Entity robotEntity = MonoECS.instance.localPlayer.robotEntity;
		if (robotEntity.IsValid && canMove.Value)
		{
			Transform rootTransform = robotEntity.GetRootTransform();
			Vector3 position = rootTransform.position;
			rootTransform.position = Vector3.Lerp(position, targetPos.Value, posDamping * Time.deltaTime);
			if ((position - targetPos.Value).sqrMagnitude <= stopDistance)
			{
				return TaskStatus.Success;
			}
			return TaskStatus.Running;
		}
		return TaskStatus.Failure;
	}
}
