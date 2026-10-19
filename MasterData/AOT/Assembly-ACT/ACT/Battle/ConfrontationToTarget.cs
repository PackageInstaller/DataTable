using ACT.Battle.Configs;
using ACT.MultiPlayer;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/废弃节点")]
[TaskDescription("与目标对峙,有后退动画就会播后退动画，没有就是直接转身往后跑")]
public class ConfrontationToTarget : Action
{
	public SharedBool usemove_front;

	public SharedBool trunCondition;

	public SharedFloat minTimeLimit;

	public SharedFloat maxTimeLimit;

	private const string MOVE_BACK = "move_back";

	private float m_TimeLimit;

	private float m_Timer;

	private Entity m_Entity;

	private Entity hatredTarget;

	private bool m_BackMove;

	private CompNav m_CompNav;

	private Vector3 m_EndPos;

	private float turnTime;

	private float turnCD = 0.2f;

	public override void OnStart()
	{
		m_Timer = 0f;
		turnTime = turnCD;
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		m_CompNav = m_Entity.GetCompNav();
		hatredTarget = m_Entity.GetCompHatred().GetHatred();
		m_TimeLimit = Random.Range(minTimeLimit.Value, maxTimeLimit.Value);
		ConfigCharacter config = m_Entity.GetConfig();
		for (int i = 0; i < config.moveMotions.Length; i++)
		{
			if (config.moveMotions[i].motion != null && config.moveMotions[i].motion.name == "move_back" && !config.moveMotions[i].IsForbidden)
			{
				m_BackMove = true;
			}
		}
	}

	public override TaskStatus OnUpdate()
	{
		m_Timer += Time.deltaTime;
		turnTime += Time.deltaTime;
		if (m_Timer >= m_TimeLimit)
		{
			OnEnd();
			return TaskStatus.Success;
		}
		if (m_Entity.GetCompPhysics().FrameCollided)
		{
			return TaskStatus.Success;
		}
		if (usemove_front.Value)
		{
			if (!hatredTarget.IsValid)
			{
				return TaskStatus.Success;
			}
			CompTransform compTransform = m_Entity.GetCompTransform();
			m_EndPos = compTransform.physicsPosition;
			m_EndPos.x = ((compTransform.physicsPosition.x < hatredTarget.GetCompTransform().physicsPosition.x) ? (m_EndPos.x + 10f) : (m_EndPos.x - 10f));
			if (!m_Entity.GetCompAI().TryCommitCombatMoveDestination(m_CompNav, m_EndPos, "ConfrontationToTarget"))
			{
				return TaskStatus.Success;
			}
			m_CompNav.isStopped = false;
			m_Entity.SetBool("move_front", value: true);
		}
		else if (!m_BackMove)
		{
			if (!hatredTarget.IsValid)
			{
				return TaskStatus.Success;
			}
			CompTransform compTransform2 = m_Entity.GetCompTransform();
			m_EndPos = compTransform2.physicsPosition;
			m_EndPos.x = ((compTransform2.physicsPosition.x < hatredTarget.GetCompTransform().physicsPosition.x) ? (m_EndPos.x - 10f) : (m_EndPos.x + 10f));
			if (!m_Entity.GetCompAI().TryCommitCombatMoveDestination(m_CompNav, m_EndPos, "ConfrontationToTarget"))
			{
				return TaskStatus.Success;
			}
			m_CompNav.isStopped = false;
			if (m_Entity.GetConfig().animationSchema == AnimationSchema.LockRotation)
			{
				if (compTransform2.physicsPosition.x < m_EndPos.x)
				{
					m_Entity.SetBool("DirRight", value: true);
					m_Entity.SetBool("DirLeft", value: false);
				}
				else
				{
					m_Entity.SetBool("DirLeft", value: true);
					m_Entity.SetBool("DirRight", value: false);
				}
			}
		}
		else
		{
			if (trunCondition.Value && turnTime - turnCD > 0f && m_Entity.TryGetCompHatred(out CompHatred component))
			{
				Entity entity = component.hatredTarget;
				if (entity.IsValid)
				{
					Vector3 vector = m_Entity.GetRootTransform().position - entity.GetRootTransform().position;
					if ((m_Entity.GetCompPhysics().faceDirRot * vector).z < 0f)
					{
						turnTime -= turnCD;
						m_Entity.SetFaceLeft(!m_Entity.IsFaceLeft());
						m_Entity.GetCompMotion().layer0Peak.startFaceDir = ((!m_Entity.IsFaceLeft()) ? FaceDir.Right : FaceDir.Left);
					}
				}
			}
			m_Entity.SetBool("move_back", value: true);
		}
		m_Entity.SetBool("Move", value: true);
		return TaskStatus.Running;
	}

	public override void OnEnd()
	{
		m_CompNav.isStopped = true;
		m_Timer = 0f;
		m_Entity.SetBool("move_front", value: false);
		m_Entity.SetBool("Move", value: false);
		m_Entity.SetBool("move_back", value: false);
		if (m_Entity.GetConfig().animationSchema == AnimationSchema.LockRotation)
		{
			m_Entity.SetBool("DirRight", value: false);
			m_Entity.SetBool("DirLeft", value: false);
		}
	}
}
