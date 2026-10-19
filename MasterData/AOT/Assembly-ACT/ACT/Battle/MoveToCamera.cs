using ACT.Battle.Configs;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/废弃节点")]
public class MoveToCamera : Action
{
	public SharedFloat minDis;

	public SharedFloat maxDis;

	private float m_Dis;

	private Vector3 m_ViewportPosition;

	private Vector3 m_LeftViewPoint;

	private Vector3 m_RightViewPoint;

	private Entity m_Entity;

	private CompNav m_CompNav;

	private CompInput m_CompInput;

	private CompPhysics m_CompPhysics;

	private CompMotion m_CompMotion;

	private CompTransform m_CompTransform;

	public override void OnStart()
	{
		m_Entity = Owner.ToEntity();
		m_CompPhysics = m_Entity.GetCompPhysics();
		m_CompNav = m_Entity.GetCompNav();
		m_CompTransform = m_Entity.GetCompTransform();
		m_CompPhysics = m_Entity.GetCompPhysics();
		m_CompMotion = m_Entity.GetCompMotion();
		m_Dis = Random.Range(minDis.Value, maxDis.Value);
		m_LeftViewPoint = Vector3.zero;
		m_RightViewPoint = new Vector3(1f, 0f, 0f);
		m_Entity.SetBool("move_back", value: false);
	}

	public override TaskStatus OnUpdate()
	{
		if (m_CompPhysics.FrameCollided)
		{
			return TaskStatus.Success;
		}
		_ = m_CompNav.pathStatus;
		_ = 2;
		Vector3 physicsPosition = m_CompTransform.physicsPosition;
		Vector3 vector = GameUtility.mainCamera.WorldToViewportPoint(physicsPosition);
		m_LeftViewPoint.y = (m_RightViewPoint.y = vector.y);
		m_LeftViewPoint.z = (m_RightViewPoint.z = vector.z);
		Vector3 vector2 = GameUtility.mainCamera.ViewportToWorldPoint(m_LeftViewPoint);
		Vector3 vector3 = GameUtility.mainCamera.ViewportToWorldPoint(m_RightViewPoint);
		float num = Mathf.Abs(vector2.x - physicsPosition.x);
		float num2 = Mathf.Abs(vector3.x - physicsPosition.x);
		Vector3 zero = Vector3.zero;
		if (num < num2)
		{
			vector2.x += m_Dis;
			zero = vector2;
		}
		else
		{
			vector3.x -= m_Dis;
			zero = vector3;
		}
		if (!m_Entity.GetCompAI().TryCommitCombatMoveDestination(m_CompNav, zero, "MoveToCamera"))
		{
			m_CompInput.inputDir = EInputDir.None;
			return TaskStatus.Success;
		}
		m_CompNav.isStopped = false;
		if (m_CompPhysics.FrameCollided)
		{
			m_CompInput.inputDir = EInputDir.None;
			m_CompNav.isStopped = true;
			return TaskStatus.Success;
		}
		if (m_CompNav.isArrived || m_CompNav.CheckArrived(physicsPosition, m_CompNav.destination))
		{
			m_CompInput.inputDir = EInputDir.None;
			m_CompNav.isStopped = true;
			m_Entity.SetBool("Move", value: false);
			return TaskStatus.Success;
		}
		Vector3 vector4 = m_CompNav.destination - m_CompTransform.physicsPosition;
		if (Mathf.Abs(vector4.x) < 0.1f)
		{
			m_CompInput.inputDir = EInputDir.None;
			m_CompNav.isStopped = true;
			m_Entity.SetBool("Move", value: false);
			return TaskStatus.Success;
		}
		bool flag = vector4.x < 0f;
		FaceDir faceDir = ((!flag) ? FaceDir.Right : FaceDir.Left);
		if (m_Entity.GetFaceDir() != faceDir)
		{
			if (m_Entity.GetConfig().animationSchema == AnimationSchema.LockRotation)
			{
				m_Entity.SetBool("turn", value: true);
				m_Entity.SetBool("turn_to_left", flag);
				m_Entity.SetBool("turn_to_right", !flag);
				return TaskStatus.Running;
			}
			if (m_CompMotion.curMotionState != MotionState.Attack)
			{
				m_Entity.SetFaceLeft(flag);
				m_CompMotion.layer0Peak.startFaceDir = faceDir;
			}
		}
		m_Entity.SetBool("turn", value: false);
		m_CompInput.inputDir = (flag ? EInputDir.Left : EInputDir.Right);
		return TaskStatus.Running;
	}

	public override void OnEnd()
	{
		m_Entity.SetBool("Move", value: false);
		m_CompInput.inputDir = EInputDir.None;
		m_CompNav.isStopped = true;
	}
}
