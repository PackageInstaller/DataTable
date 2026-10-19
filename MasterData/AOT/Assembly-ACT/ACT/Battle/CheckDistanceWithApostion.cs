using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class CheckDistanceWithApostion : Conditional
{
	public float distance;

	public Condition condition;

	public DistanceType distanceType;

	public string parameter;

	public bool boolTrueValue = true;

	public bool boolFalseValue;

	private MonoECS ecs;

	private Entity owner;

	private Vector3 thisPos;

	public override void OnStart()
	{
		ecs = MonoECS.instance;
		owner = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		bool flag = false;
		Entity hatred = owner.GetCompHatred().GetHatred();
		if (hatred.IsValid)
		{
			Vector3 physicsPosition = hatred.GetCompTransform().physicsPosition;
			thisPos = owner.GetCompTransform().physicsPosition;
			float num = ((distanceType == DistanceType.line) ? Mathf.Pow(distance, 2f) : distance);
			flag = distanceType switch
			{
				DistanceType.horizontal => Mathf.Abs(physicsPosition.x - thisPos.x), 
				DistanceType.vertical => Mathf.Abs(physicsPosition.y - thisPos.y), 
				DistanceType.line => (physicsPosition - thisPos).sqrMagnitude, 
				_ => 0f, 
			} < num;
			switch (condition)
			{
			case Condition.Greater:
			case Condition.GreaterAndEqual:
				flag = !flag;
				break;
			}
		}
		if (!string.IsNullOrEmpty(parameter))
		{
			if (flag)
			{
				owner.SetBool(parameter, boolTrueValue);
			}
			else
			{
				owner.SetBool(parameter, boolFalseValue);
			}
		}
		return TaskStatus.Success;
	}
}
