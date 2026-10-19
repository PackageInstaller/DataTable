using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/\ufffd\ufffd\ufffd\ufffdҪ\ufffdú\ufffd\ufffd\ufffd\ufffd\ufffd\ufffd")]
[TaskDescription("\ufffdж\ufffd\ufffd뵱ǰ\ufffd\ufffdս\ufffd\ufffdɫ\ufffdľ\ufffd\ufffd\ufffd")]
public class CheckDistanceWithMainEntity : Conditional
{
	public SharedFloat distance = 1f;

	public Condition condition;

	public DistanceType distanceType;

	private Entity owner;

	private MonoECS ecs;

	private float m_distanceSqr;

	private Vector3 thisPos;

	public override void OnStart()
	{
		ecs = MonoECS.instance;
		owner = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		thisPos = owner.GetCompTransform().physicsPosition;
		m_distanceSqr = ((distanceType == DistanceType.line) ? Mathf.Pow(distance.Value, 2f) : distance.Value);
		Vector3 physicsPosition = ecs.mainEntity.GetCompTransform().physicsPosition;
		bool flag = distanceType switch
		{
			DistanceType.horizontal => Mathf.Abs(physicsPosition.x - thisPos.x), 
			DistanceType.vertical => Mathf.Abs(physicsPosition.y - thisPos.y), 
			DistanceType.line => (physicsPosition - thisPos).sqrMagnitude, 
			_ => 0f, 
		} < m_distanceSqr;
		switch (condition)
		{
		case Condition.Greater:
		case Condition.GreaterAndEqual:
			flag = !flag;
			break;
		}
		if (!flag)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
