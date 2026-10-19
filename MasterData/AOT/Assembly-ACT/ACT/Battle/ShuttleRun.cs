using System.Collections.Generic;
using ACT.MultiPlayer;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动")]
[TaskDescription("从当前位置向逐个沿着巡逻点移动。抵达最后一个点返回success，寻路失败返回failure，行走过程中返回running")]
public class ShuttleRun : Action
{
	protected CompNav m_CompNav;

	protected Entity m_Entity;

	protected int m_CurrentIndex;

	protected bool m_Started;

	private float waitTime = 0.5f;

	private float realWaitTime = 0.5f;

	private bool needWait;

	private Queue<Vector3> lastPositions = new Queue<Vector3>();

	private const int CliffCheckFrameCount = 4;

	private const float CliffCheckThreshold = 0.08f;

	private float curFrame;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		m_CompNav = m_Entity.GetCompNav();
		CompAI compAI = m_Entity.GetCompAI();
		if (compAI.patrolPoints == null || compAI.patrolPoints.Count <= 1)
		{
			m_Started = false;
			return;
		}
		m_Started = true;
		m_CurrentIndex = 0;
		m_CompNav.destination = compAI.patrolPoints[m_CurrentIndex];
		m_CompNav.isStopped = false;
		lastPositions = new Queue<Vector3>();
		curFrame = 0f;
	}

	public override void OnEnd()
	{
		m_CompNav.isStopped = true;
	}

	public override TaskStatus OnUpdate()
	{
		CompInput compInput = m_Entity.GetCompInput();
		CompAI compAI = m_Entity.GetCompAI();
		if (m_Entity.GetCompHatred().GetHatred().IsValid)
		{
			compInput.inputDir = EInputDir.None;
			return TaskStatus.Success;
		}
		if (!m_Started)
		{
			return TaskStatus.Failure;
		}
		if (needWait)
		{
			realWaitTime -= Time.deltaTime;
			if (realWaitTime > 0f)
			{
				compInput.inputDir = EInputDir.None;
				return TaskStatus.Running;
			}
			needWait = false;
		}
		if (m_Entity.GetCompPhysics().FrameCollided)
		{
			compInput.inputDir = EInputDir.None;
			m_CurrentIndex++;
			if (EndShuttleRun())
			{
				m_CurrentIndex = 0;
			}
			m_CompNav.destination = compAI.patrolPoints[m_CurrentIndex];
			m_CompNav.isStopped = false;
			realWaitTime = waitTime;
			needWait = true;
			return TaskStatus.Running;
		}
		Vector3 vector = m_CompNav.destination - m_Entity.GetCompTransform().physicsPosition;
		if (Mathf.Abs(vector.x) < 0.1f)
		{
			compInput.inputDir = EInputDir.None;
			m_CurrentIndex++;
			if (EndShuttleRun())
			{
				m_CurrentIndex = 0;
			}
			m_CompNav.destination = compAI.patrolPoints[m_CurrentIndex];
			m_CompNav.isStopped = false;
			realWaitTime = waitTime;
			needWait = true;
			return TaskStatus.Running;
		}
		bool flag = vector.x < 0f;
		FaceDir faceDir = ((!flag) ? FaceDir.Right : FaceDir.Left);
		if (m_Entity.GetFaceDir() != faceDir)
		{
			_ = m_Entity.GetConfig().animationSchema;
			_ = 1;
			compInput.inputDir = EInputDir.None;
			m_Entity.SetBool("turn", value: true);
			m_Entity.SetBool("turn_to_left", flag);
			m_Entity.SetBool("turn_to_right", !flag);
			return TaskStatus.Running;
		}
		m_Entity.SetBool("turn", value: false);
		m_Entity.SetBool("turn_to_left", value: false);
		m_Entity.SetBool("turn_to_right", value: false);
		compInput.inputDir = (flag ? EInputDir.Left : EInputDir.Right);
		return TaskStatus.Running;
	}

	public virtual bool EndShuttleRun()
	{
		if (m_CurrentIndex == m_Entity.GetCompAI().patrolPoints.Count)
		{
			return true;
		}
		return false;
	}
}
