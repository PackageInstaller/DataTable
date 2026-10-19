using ACT.Battle.Configs;
using ACT.MultiPlayer;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("导航到某个位置，也可以是往某个方向移动多少米，具体参数见文档了")]
public class MoveToLocation : Action
{
	public bool isGetValueFromHatredTarget;

	public SharedVector3 targetPos;

	public SharedFloat targetPosFloat = -1f;

	public SharedFloat tatargetPosFloatRIght = -1f;

	public SharedFloat leftHorizontalStopRange = 0.15f;

	public SharedFloat rightHorizontalStopRange = 0.15f;

	public SharedBool alwaysWalk2Player;

	private Vector3 startPos;

	private Vector3 m_EndPos;

	private int dir;

	private bool stopFlag;

	private bool m_UseDistanceDestination;

	private CompNav m_CompNav;

	private CompTransform m_CompTransform;

	private CompPhysics m_CompPhysics;

	private CompMotion m_CompMotion;

	private CompHatred m_CompHatred;

	private CompAI m_CompAI;

	private CompInput m_CompInput;

	private ConfigCharacter m_Config;

	public override void OnStart()
	{
		stopFlag = false;
		Entity entity = Owner.ToEntity();
		m_CompNav = entity.GetCompNav();
		m_CompTransform = entity.GetCompTransform();
		m_CompPhysics = entity.GetCompPhysics();
		m_CompMotion = entity.GetCompMotion();
		m_CompHatred = entity.GetCompHatred();
		m_CompAI = entity.GetCompAI();
		m_CompInput = entity.GetCompInput();
		m_Config = entity.GetConfig();
		leftHorizontalStopRange.Value = ((leftHorizontalStopRange.Value < 0.15f) ? 0.15f : leftHorizontalStopRange.Value);
		rightHorizontalStopRange.Value = ((rightHorizontalStopRange.Value < 0.15f) ? 0.15f : rightHorizontalStopRange.Value);
		if (alwaysWalk2Player.Value)
		{
			m_CompMotion.SetBool("useWalk", b: true);
		}
		m_EndPos = (startPos = m_CompTransform.physicsPosition);
		m_UseDistanceDestination = !Mathf.Approximately(targetPosFloat.Value, -1f);
		if (m_UseDistanceDestination)
		{
			float num = Random.Range(targetPosFloat.Value, tatargetPosFloatRIght.Value);
			m_EndPos.x = ((m_CompTransform.FaceDir == FaceDir.Left) ? (startPos.x - num) : (startPos.x + num));
		}
		m_CompNav.SetManualKeepDestination(value: true);
	}

	public override void OnEnd()
	{
		stopFlag = true;
		StopMove();
		if (m_CompNav != null)
		{
			if (m_CompTransform != null)
			{
				m_CompNav.destination = m_CompTransform.physicsPosition;
			}
			m_CompNav.manual = false;
		}
		if (alwaysWalk2Player.Value)
		{
			m_CompMotion.SetBool("useWalk", b: false);
		}
		if (m_Config != null && m_Config.animationSchema == AnimationSchema.LockRotation)
		{
			m_CompMotion.SetBool("DirRight", b: false);
			m_CompMotion.SetBool("DirLeft", b: false);
		}
	}

	public override TaskStatus OnUpdate()
	{
		if (stopFlag)
		{
			StopMove();
			if (m_CompMotion.curMotionState == MotionState.Move)
			{
				return TaskStatus.Running;
			}
			return TaskStatus.Success;
		}
		if (!TryRefreshEndPos())
		{
			StopMove();
			return TaskStatus.Success;
		}
		if (m_CompPhysics.FrameCollided)
		{
			m_CompAI.RecordMoveFail("MoveToLocation");
			StopMove();
			return TaskStatus.Success;
		}
		if (HasReachedStopRange() || m_CompNav.CheckArrived(m_CompTransform.physicsPosition, m_EndPos))
		{
			stopFlag = true;
			StopMove();
			return TaskStatus.Running;
		}
		if (!m_CompAI.TryCommitCombatMoveDestination(m_CompNav, m_EndPos, "MoveToLocation"))
		{
			StopMove();
			return TaskStatus.Success;
		}
		m_CompNav.isStopped = false;
		if (m_CompNav.isArrived)
		{
			stopFlag = true;
			StopMove();
			return TaskStatus.Running;
		}
		ApplyMoveInput();
		return TaskStatus.Running;
	}

	private bool TryRefreshEndPos()
	{
		if (m_UseDistanceDestination)
		{
			return true;
		}
		if (isGetValueFromHatredTarget)
		{
			if (m_CompHatred == null)
			{
				return false;
			}
			Entity hatred = m_CompHatred.GetHatred();
			if (!hatred.IsValid)
			{
				return false;
			}
			CompTransform compTransform = hatred.GetCompTransform();
			if (compTransform == null)
			{
				return false;
			}
			m_EndPos = compTransform.physicsPosition;
			return true;
		}
		m_EndPos = targetPos.Value;
		return true;
	}

	private bool HasReachedStopRange()
	{
		FaceDir faceDir = m_CompTransform.FaceDir;
		float num = Mathf.Abs(m_CompTransform.physicsPosition.x - m_EndPos.x);
		if (faceDir != FaceDir.Left || !(num - leftHorizontalStopRange.Value < 0f))
		{
			if (faceDir == FaceDir.Right)
			{
				return num - rightHorizontalStopRange.Value < 0f;
			}
			return false;
		}
		return true;
	}

	private void ApplyMoveInput()
	{
		Vector3 rhs = m_EndPos - m_CompTransform.physicsPosition;
		if (m_CompNav != null && m_CompNav.isAir)
		{
			Vector2 vector = new Vector2(rhs.x, rhs.y);
			if (Mathf.Abs(vector.x) < 0.001f && Mathf.Abs(vector.y) > 0.001f)
			{
				vector.x = ((m_CompTransform.FaceDir == FaceDir.Left) ? (-0.01f) : 0.01f);
			}
			m_CompInput.dir = vector;
		}
		else
		{
			rhs.y = (rhs.z = 0f);
			m_CompInput.inputDir = ((!(Vector3.Dot(m_CompPhysics.pathTangent, rhs) > 0f)) ? EInputDir.Left : EInputDir.Right);
		}
		m_CompMotion.SetBool("Move", b: true);
		if (m_Config.animationSchema == AnimationSchema.LockRotation)
		{
			bool flag = m_CompTransform.physicsPosition.x < m_EndPos.x;
			m_CompMotion.SetBool("DirRight", flag);
			m_CompMotion.SetBool("DirLeft", !flag);
		}
	}

	private void StopMove()
	{
		if (m_CompInput != null)
		{
			m_CompInput.inputDir = EInputDir.None;
		}
		if (m_CompMotion != null)
		{
			m_CompMotion.SetBool("Move", b: false);
			m_CompMotion.SetBool("FlyMove", b: false);
		}
	}
}
