using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription(" 靠近目标到一个dis的距离")]
public class AutoMoveToTarget : Action
{
	public SharedFloat minDis;

	public SharedFloat maxDis;

	private float dis;

	public SharedFloat minTimeLimit;

	public SharedFloat maxTimeLimit;

	private float m_TimeLimit;

	private float m_Timer;

	private Vector3 m_EndPos;

	private Entity _entity;

	private Entity _hatredTarget;

	private CompNav m_CompNav;

	public override void OnStart()
	{
		_entity = Owner.ToEntity();
		_hatredTarget = _entity.GetCompHatred().GetHatred();
		dis = Random.Range(minDis.Value, maxDis.Value);
		m_CompNav = _entity.GetCompNav();
		m_TimeLimit = Random.Range(minTimeLimit.Value, maxTimeLimit.Value);
	}

	public override TaskStatus OnUpdate()
	{
		if (!_entity.IsValid || !_hatredTarget.IsValid)
		{
			return TaskStatus.Success;
		}
		m_EndPos = _hatredTarget.GetCompTransform().physicsPosition;
		m_EndPos.x = ((_entity.GetCompTransform().physicsPosition.x < m_EndPos.x) ? (m_EndPos.x - dis) : (m_EndPos.x + dis));
		m_Timer += Time.deltaTime;
		if (m_Timer >= m_TimeLimit)
		{
			OnEnd();
			return TaskStatus.Success;
		}
		if (_entity.GetCompPhysics().FrameCollided)
		{
			return TaskStatus.Success;
		}
		CompNav compNav = _entity.GetCompNav();
		if (!_entity.GetCompAI().TryCommitCombatMoveDestination(compNav, m_EndPos, "AutoMoveToTarget"))
		{
			return TaskStatus.Success;
		}
		m_CompNav.isStopped = false;
		if (compNav.isArrived)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Running;
	}

	public override void OnEnd()
	{
		m_Timer = 0f;
		m_CompNav.isStopped = true;
	}
}
