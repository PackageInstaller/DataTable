using System.Collections.Generic;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/废弃")]
[TaskDescription("判定当前是否有巡逻点，有巡逻点返还success，没有巡逻点返还failure")]
public class CheckPatrolPoints : Conditional
{
	private List<Vector3> m_PatrolPoints;

	public override void OnAwake()
	{
	}

	public override void OnStart()
	{
		CompAI compAI = ((ActBehaviorTree)Owner).Entity.GetCompAI();
		if (compAI == null)
		{
			m_PatrolPoints = null;
		}
		else
		{
			m_PatrolPoints = compAI.patrolPoints;
		}
	}

	public override TaskStatus OnUpdate()
	{
		if (m_PatrolPoints == null || m_PatrolPoints.Count == 0)
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
