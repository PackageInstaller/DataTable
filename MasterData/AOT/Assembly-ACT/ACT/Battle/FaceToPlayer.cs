using ACT.Battle.Configs;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("将面向调向玩家,time为负数表示无限次转向")]
public class FaceToPlayer : Action
{
	private const float AirFaceHorizontalDeadZone = 0.3f;

	private bool m_PreserveMoveInputOnEnd;

	public SharedAIBehaviourList allBehaviourList;

	public bool useMove = true;

	public float time = 3f;

	private float m_Timer = 1f;

	private Entity target;

	private Entity m_Entity;

	private bool needDoTurn = true;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		m_PreserveMoveInputOnEnd = false;
		m_Entity.SetBool("turn", value: false);
		m_Entity.SetBool("turn_to_left", value: false);
		m_Entity.SetBool("turn_to_right", value: false);
		if (m_Entity.GetCompAI().TryGetPendingAttackRequest(out var request))
		{
			needDoTurn = request.needFace2HatredTarget;
		}
		else
		{
			needDoTurn = true;
		}
	}

	public override TaskStatus OnUpdate()
	{
		if (m_Entity.GetCompNav().isAir && m_Entity.GetCompAI().TryGetPendingAttackRequest(out var request))
		{
			AIBodyMovePolicy movePolicy = request.movePolicy;
			if (movePolicy == AIBodyMovePolicy.NoMove || movePolicy == AIBodyMovePolicy.FaceOnly)
			{
				m_Entity.GetCompInput().dir = Vector2.zero;
			}
		}
		if (m_Entity.GetCompMotion().curMotionState == MotionState.Hit)
		{
			return TaskStatus.Success;
		}
		if (!needDoTurn)
		{
			return TaskStatus.Success;
		}
		if (!m_Entity.TryGetCompHatred(out CompHatred component))
		{
			return TaskStatus.Success;
		}
		target = component.GetHatred();
		if (!target.IsValid)
		{
			return TaskStatus.Success;
		}
		if (m_Timer < 0f)
		{
			m_Entity.SetBool("turn", value: false);
			return TaskStatus.Success;
		}
		m_Timer -= Time.deltaTime;
		Vector3 physicsPosition = target.GetCompTransform().physicsPosition;
		Vector3 physicsPosition2 = m_Entity.GetCompTransform().physicsPosition;
		if (useMove && m_Entity.GetCompNav().isAir && m_Entity.GetConfig().animationSchema == AnimationSchema.UnlockRotation && Mathf.Abs(physicsPosition.x - physicsPosition2.x) <= 0.3f)
		{
			m_Entity.SetBool("turn", value: false);
			m_Entity.SetBool("turn_to_left", value: false);
			m_Entity.SetBool("turn_to_right", value: false);
			m_PreserveMoveInputOnEnd = true;
			return TaskStatus.Success;
		}
		bool flag = physicsPosition.x < physicsPosition2.x;
		if (m_Entity.GetConfig().animationSchema == AnimationSchema.LockRotation)
		{
			if (flag)
			{
				m_Entity.SetBool("turn", value: true);
				m_Entity.SetBool("turn_to_left", value: true);
				m_Entity.SetBool("turn_to_right", value: false);
			}
			else
			{
				m_Entity.SetBool("turn", value: true);
				m_Entity.SetBool("turn_to_left", value: false);
				m_Entity.SetBool("turn_to_right", value: true);
			}
			if (((!flag) ? 1 : 2) != (int)m_Entity.GetFaceDir())
			{
				return TaskStatus.Running;
			}
			return TaskStatus.Success;
		}
		FaceDir faceDir = ((!flag) ? FaceDir.Right : FaceDir.Left);
		float b = QuaternionUtility.FaceLocalYAngle(faceDir);
		if (Mathf.Approximately(m_Entity.GetCompTransform().physicsRotateDegree, b))
		{
			m_Entity.SetBool("turn", value: false);
			m_Timer = time;
			return TaskStatus.Success;
		}
		FaceDir faceDir2 = m_Entity.GetFaceDir();
		if (useMove)
		{
			if (faceDir2 == faceDir)
			{
				m_Entity.SetBool("turn", value: false);
			}
			else
			{
				m_Entity.SetBool("turn", value: true);
			}
		}
		else
		{
			CompMotion compMotion = m_Entity.GetCompMotion();
			if (faceDir2 != faceDir && compMotion.curMotionState != MotionState.Attack)
			{
				m_Entity.SetFaceLeft(flag);
				compMotion.layer0Peak.startFaceDir = ((!flag) ? FaceDir.Right : FaceDir.Left);
			}
		}
		return TaskStatus.Running;
	}

	public override void OnEnd()
	{
		bool preserveMoveInputOnEnd = m_PreserveMoveInputOnEnd;
		m_PreserveMoveInputOnEnd = false;
		m_Timer = time;
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		m_Entity.SetBool("turn", value: false);
		m_Entity.SetBool("turn_to_left", value: false);
		m_Entity.SetBool("turn_to_right", value: false);
		if (!(!useMove | preserveMoveInputOnEnd))
		{
			m_Entity.GetCompNav().manual = false;
			m_Entity.GetCompInput().inputDir = EInputDir.None;
		}
	}
}
