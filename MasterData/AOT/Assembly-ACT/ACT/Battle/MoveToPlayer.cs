using ACT.Battle.Configs;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;
using UnityEngine.AI;

namespace ACT.Battle;

[TaskCategory("ACT/废弃节点")]
[TaskDescription("朝仇恨目标移动,寻路失败返回failure，行走过程中返回running（后续应该改成朝仇恨目标移动")]
public class MoveToPlayer : Action
{
	public SharedFloat startWalkDistances = -1f;

	public SharedBool alwaysWalk2Player;

	private bool m_EntityCanTurn;

	private bool m_HasMoveBack;

	private float m_StopDis;

	private Entity m_Entity;

	private CompNav m_CompNav;

	private CompTransform m_CompTransform;

	private CompPhysics m_CompPhysics;

	private CompMotion m_CompMotion;

	private CompHatred m_CompHatred;

	private CompInput m_CompInput;

	private ConfigCharacter m_Config;

	public override void OnStart()
	{
		Entity entity = (m_Entity = Owner.ToEntity());
		m_CompNav = entity.GetCompNav();
		m_CompTransform = entity.GetCompTransform();
		m_CompPhysics = entity.GetCompPhysics();
		m_CompMotion = entity.GetCompMotion();
		m_CompHatred = entity.GetCompHatred();
		m_CompInput = entity.GetCompInput();
		m_Config = entity.GetConfig();
		m_EntityCanTurn = m_Config.animationSchema == AnimationSchema.CantTurn || m_Config.animationSchema == AnimationSchema.LookAtCamera;
		m_CompMotion.SetBool("move_back", b: false);
		if (alwaysWalk2Player.Value)
		{
			m_CompMotion.SetBool("useWalk", b: true);
		}
		m_CompNav.SetManualKeepDestination(value: true);
		m_CompNav.isStopped = false;
		m_StopDis = ((m_CompNav.sqrStoppingDistance < 0.1f) ? 0.1f : m_CompNav.sqrStoppingDistance);
		m_HasMoveBack = false;
		for (int i = 0; i < m_Config.moveMotions.Length; i++)
		{
			if (!(m_Config.moveMotions[i].motion == null) && !(m_Config.moveMotions[i].motion.name != "move_back") && !m_Config.moveMotions[i].IsForbidden)
			{
				m_HasMoveBack = true;
				break;
			}
		}
	}

	public override void OnEnd()
	{
		m_CompInput.inputDir = EInputDir.None;
		m_CompNav.destination = m_CompTransform.physicsPosition;
		m_CompNav.isStopped = true;
		m_CompNav.manual = false;
		m_CompMotion.SetBool("move_back", b: false);
		if (alwaysWalk2Player.Value)
		{
			m_CompMotion.SetBool("useWalk", b: false);
		}
	}

	public override TaskStatus OnUpdate()
	{
		Vector3 zero = Vector3.zero;
		zero = ((!m_CompHatred.GetHatred().IsValid) ? MonoECS.instance.mainEntity.GetCompTransform().physicsPosition : m_CompHatred.GetHatred().GetCompTransform().physicsPosition);
		if (!m_CompNav.manual)
		{
			m_CompNav.SetManualKeepDestination(value: true);
		}
		if (!m_Entity.GetCompAI().TryCommitCombatMoveDestination(m_CompNav, zero, "MoveToPlayer"))
		{
			m_CompInput.inputDir = EInputDir.None;
			return TaskStatus.Success;
		}
		m_CompNav.isStopped = false;
		if (m_CompPhysics.FrameCollided)
		{
			m_CompInput.inputDir = EInputDir.None;
			return TaskStatus.Success;
		}
		if (m_CompNav.pathStatus == NavMeshPathStatus.PathInvalid)
		{
			m_Entity.GetCompAI().RecordMoveFail("MoveToPlayer");
			return TaskStatus.Failure;
		}
		if (m_CompNav.CheckArrived(m_CompTransform.physicsPosition, m_CompNav.destination))
		{
			m_CompInput.inputDir = EInputDir.None;
			return TaskStatus.Success;
		}
		Vector3 rhs = m_CompNav.destination - m_CompTransform.physicsPosition;
		if (rhs.sqrMagnitude <= m_StopDis)
		{
			m_CompInput.inputDir = EInputDir.None;
			return TaskStatus.Success;
		}
		bool flag = rhs.x < 0f;
		FaceDir faceDir = ((!flag) ? FaceDir.Right : FaceDir.Left);
		if (m_CompTransform.FaceDir != faceDir)
		{
			if (m_Config.animationSchema == AnimationSchema.LockRotation)
			{
				m_CompMotion.SetBool("turn", b: true);
				m_CompMotion.SetBool("turn_to_left", flag);
				m_CompMotion.SetBool("turn_to_right", !flag);
				return TaskStatus.Running;
			}
			if (m_CompMotion.curMotionState != MotionState.Attack)
			{
				m_Entity.SetFaceLeft(flag);
				m_CompMotion.layer0Peak.startFaceDir = faceDir;
			}
		}
		m_CompMotion.SetBool("turn", b: false);
		if (Vector3.Dot(m_CompPhysics.pathTangent, rhs) > 0f)
		{
			m_CompInput.inputDir = EInputDir.Right;
		}
		else
		{
			m_CompInput.inputDir = EInputDir.Left;
		}
		if (m_HasMoveBack)
		{
			if (!BoolUtility.IsInFront(m_CompTransform.FaceDir == FaceDir.Left, m_CompTransform.physicsPosition.x, m_CompNav.destination.x))
			{
				Vector3 physicsPosition = m_CompHatred.hatredTarget.GetCompTransform().physicsPosition;
				float num = Mathf.Abs(m_CompTransform.physicsPosition.x - physicsPosition.x);
				if (Mathf.Abs(m_CompNav.destination.x - physicsPosition.x) > num)
				{
					m_CompMotion.SetBool("move_back", b: true);
				}
				else
				{
					m_CompMotion.SetBool("move_back", b: false);
				}
			}
			else
			{
				m_CompMotion.SetBool("move_back", b: false);
			}
		}
		return TaskStatus.Running;
	}
}
