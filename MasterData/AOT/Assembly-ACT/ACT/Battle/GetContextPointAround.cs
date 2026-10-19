using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("当前位置和某个场景点之间的距离  与 distance来比较 ，没有场景点就是返回failure")]
public class GetContextPointAround : Conditional
{
	public Condition condition;

	public DistanceType distanceType;

	public SharedFloat distance;

	private float m_distanceSqr;

	public int contextType;

	public override void OnStart()
	{
		m_distanceSqr = ((distanceType == DistanceType.line) ? Mathf.Pow(distance.Value, 2f) : Mathf.Abs(distance.Value));
	}

	public override TaskStatus OnUpdate()
	{
		bool flag = false;
		BattleInteractableObject battleInteractableObject = MonoECS.instance.aiContextManager.FindContext(contextType);
		if (battleInteractableObject != null)
		{
			Vector3 physicsPosition = ((ActBehaviorTree)Owner).Entity.GetCompTransform().physicsPosition;
			Vector3 position = battleInteractableObject.transform.position;
			flag = distanceType switch
			{
				DistanceType.horizontal => Mathf.Abs(physicsPosition.x - position.x), 
				DistanceType.vertical => Mathf.Abs(physicsPosition.y - position.y), 
				DistanceType.line => (physicsPosition - position).sqrMagnitude, 
				_ => 0f, 
			} < m_distanceSqr;
			switch (condition)
			{
			case Condition.Greater:
			case Condition.GreaterAndEqual:
				flag = !flag;
				break;
			}
		}
		if (!flag)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
