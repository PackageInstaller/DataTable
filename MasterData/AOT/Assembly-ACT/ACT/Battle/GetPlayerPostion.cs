using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/废弃节点")]
[TaskDescription("用 GetHatredPosition，获取仇恨目标的坐标")]
public class GetPlayerPostion : Action
{
	private Entity m_Entity;

	public SharedVector3 targetPos;

	public override void OnStart()
	{
		targetPos.Value = Vector3.zero;
	}

	public override TaskStatus OnUpdate()
	{
		Entity hatredTarget = ((ActBehaviorTree)Owner).Entity.GetCompHatred().hatredTarget;
		if (hatredTarget.IsValid)
		{
			targetPos.Value = hatredTarget.GetCompTransform().physicsPosition;
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
