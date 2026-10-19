using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("当前位置和某个点之间的距离  与 distance来比较 ")]
public class GetPointAround : Conditional
{
	public Condition condition;

	public DistanceType distanceType;

	public SharedVector3 targetPoint;

	public SharedFloat distance;

	private float m_distanceSqr;

	public override void OnStart()
	{
		m_distanceSqr = ((distanceType == DistanceType.line) ? Mathf.Pow(distance.Value, 2f) : Mathf.Abs(distance.Value));
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
		bool flag = num < m_distanceSqr;
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
