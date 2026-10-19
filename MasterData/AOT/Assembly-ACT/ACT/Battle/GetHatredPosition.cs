using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/可以用的节点")]
[TaskDescription("获取仇恨目标的坐标")]
public class GetHatredPosition : Action
{
	private Entity m_Entity;

	public SharedVector3 targetPos;

	public PosSourceType posSourceType;

	public override void OnStart()
	{
		targetPos.Value = Vector3.zero;
	}

	public override TaskStatus OnUpdate()
	{
		Entity hatredTarget = ((ActBehaviorTree)Owner).Entity.GetCompHatred().hatredTarget;
		if (hatredTarget.IsValid)
		{
			targetPos.Value = AbilityUtility.GetTargetPosition(hatredTarget, posSourceType);
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
