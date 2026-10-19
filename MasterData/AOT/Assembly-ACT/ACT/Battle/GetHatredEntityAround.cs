using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("检查仇恨目标是否在范围内或范围外，处于判定范围返还success，不在判定范围返还failure")]
public class GetHatredEntityAround : Conditional
{
	public SharedFloat distance = 1f;

	public DistanceType distanceType;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("使用导航位置/物理位置计算距离")]
	public bool navPosition;

	private float m_distanceSqr;

	public override void OnStart()
	{
		m_distanceSqr = ((distanceType == DistanceType.line) ? Mathf.Pow(distance.Value, 2f) : distance.Value);
	}

	public override TaskStatus OnUpdate()
	{
		Entity entity = ((ActBehaviorTree)Owner).Entity;
		Vector3 vector = (navPosition ? entity.GetCompNav().navPosition : entity.GetCompTransform().physicsPosition);
		Vector3 physicsPosition = entity.GetCompHatred().hatredTarget.GetCompTransform().physicsPosition;
		if (!(distanceType switch
		{
			DistanceType.horizontal => Mathf.Abs(physicsPosition.x - vector.x), 
			DistanceType.vertical => Mathf.Abs(physicsPosition.y - vector.y), 
			DistanceType.line => (physicsPosition - vector).sqrMagnitude, 
			_ => 0f, 
		} <= m_distanceSqr))
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
