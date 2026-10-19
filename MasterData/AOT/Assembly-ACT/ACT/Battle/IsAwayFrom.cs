using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("AI离开A点的距离,选择Greater，距离大于distance返回success，选择less，距离小于distance返回failure")]
public class IsAwayFrom : Conditional
{
	public Condition condition;

	public DistanceType distanceType;

	public SharedVector3 targetPoint;

	public SharedFloat distance;

	public override void OnStart()
	{
	}

	public override TaskStatus OnUpdate()
	{
		Vector3 physicsPosition = ((ActBehaviorTree)Owner).Entity.GetCompTransform().physicsPosition;
		float num = 0f;
		switch (distanceType)
		{
		case DistanceType.horizontal:
			num = Mathf.Abs(physicsPosition.x - targetPoint.Value.x);
			break;
		case DistanceType.vertical:
			num = Mathf.Abs(physicsPosition.y - targetPoint.Value.y);
			break;
		case DistanceType.line:
			num = (physicsPosition - targetPoint.Value).sqrMagnitude;
			break;
		}
		bool flag = num < distance.Value;
		switch (condition)
		{
		case Condition.Greater:
			flag = !flag;
			break;
		}
		if (flag)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
