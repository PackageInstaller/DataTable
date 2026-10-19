using ACT.Battle.Configs;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;
using UnityEngine.AI;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("地面单位 朝某个方向移动多少米")]
public class BTGroundMoveSomeDistance : Action
{
	public SharedFloat dis;

	private Entity m_Entity;

	private CompNav m_CompNav;

	private CompPhysics m_CompPhysics;

	private CompInput m_CompInput;

	private CompTransform m_CompTransform;

	private CompHatred m_CompHatred;

	private bool hasSetPos;

	private Vector3 realPos;

	private bool hasMoveBack;

	private bool isFirstMove = true;

	private float stopDis;

	public override void OnStart()
	{
		m_Entity = Owner.ToEntity();
		m_CompNav = m_Entity.GetCompNav();
		m_CompPhysics = m_Entity.GetCompPhysics();
		m_CompInput = m_Entity.GetCompInput();
		m_CompTransform = m_Entity.GetCompTransform();
		m_CompHatred = m_Entity.GetCompHatred();
		isFirstMove = true;
		hasSetPos = false;
		ConfigCharacter config = m_Entity.GetConfig();
		for (int i = 0; i < config.moveMotions.Length; i++)
		{
			if (config.moveMotions[i].motion != null && config.moveMotions[i].motion.name == "move_back" && !config.moveMotions[i].IsForbidden)
			{
				hasMoveBack = true;
			}
		}
		stopDis = ((m_CompNav.sqrStoppingDistance < 0.1f) ? 0.1f : m_CompNav.sqrStoppingDistance);
	}

	public override TaskStatus OnUpdate()
	{
		if (m_CompPhysics.FrameCollided)
		{
			m_Entity.GetCompAI().RecordMoveFail("BTGroundMoveSomeDistance");
			return TaskStatus.Success;
		}
		if (m_CompNav.pathStatus == NavMeshPathStatus.PathInvalid)
		{
			m_Entity.GetCompAI().RecordMoveFail("BTGroundMoveSomeDistance");
			return TaskStatus.Success;
		}
		if (hasSetPos && m_CompNav.CheckArrived(m_CompTransform.physicsPosition, realPos))
		{
			return TaskStatus.Success;
		}
		if (!hasSetPos)
		{
			realPos = m_CompTransform.physicsPosition;
			realPos.x += dis.Value;
			if (!BoolUtility.IsInFront(m_CompTransform.FaceDir == FaceDir.Left, m_CompTransform.physicsPosition.x, realPos.x) && !hasMoveBack)
			{
				return TaskStatus.Success;
			}
			m_CompNav.SetManualKeepDestination(value: true);
			if (!m_Entity.GetCompAI().TryCommitCombatMoveDestination(m_CompNav, realPos, "BTGroundMoveSomeDistance"))
			{
				return TaskStatus.Success;
			}
			hasSetPos = true;
			return TaskStatus.Running;
		}
		Vector3 rhs = realPos - m_CompTransform.physicsPosition;
		float num = Vector3.Dot(m_CompPhysics.pathTangent, rhs);
		if (num < 0f)
		{
			m_CompInput.inputDir = EInputDir.None;
			return TaskStatus.Success;
		}
		if (rhs.sqrMagnitude <= stopDis)
		{
			m_CompInput.inputDir = EInputDir.None;
		}
		else if (num > 0f)
		{
			m_CompInput.inputDir = EInputDir.Right;
		}
		else
		{
			m_CompInput.inputDir = EInputDir.Left;
		}
		if (hasMoveBack)
		{
			if (!BoolUtility.IsInFront(m_Entity.GetFaceDir() == FaceDir.Left, m_CompTransform.physicsPosition.x, realPos.x))
			{
				Vector3 physicsPosition = m_CompHatred.hatredTarget.GetCompTransform().physicsPosition;
				float num2 = Mathf.Abs(m_CompTransform.physicsPosition.x - physicsPosition.x);
				if (Mathf.Abs(realPos.x - physicsPosition.x) > num2)
				{
					m_Entity.SetBool("move_back", value: true);
				}
				else
				{
					m_Entity.SetBool("move_back", value: false);
				}
			}
			else
			{
				m_Entity.SetBool("move_back", value: false);
			}
		}
		return TaskStatus.Running;
	}

	public override void OnEnd()
	{
		m_CompNav.destination = m_CompTransform.physicsPosition;
		m_CompNav.manual = false;
		m_CompInput.inputDir = EInputDir.None;
	}
}
