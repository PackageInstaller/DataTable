using ACT.Battle.Configs;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("地面单位 从自身位置移动到某个位置")]
public class BTGroundMoveToPosition : Action
{
	public SharedVector3 posLeft;

	public SharedVector3 posRight;

	private Vector3 realPos;

	private Entity m_Entity;

	private CompNav m_CompNav;

	private CompTransform m_CompTransform;

	private CompPhysics m_CompPhysics;

	private CompInput m_CompInput;

	private CompHatred m_CompHatred;

	private MonoEntity m_MonoEntity;

	private bool hasMoveBack;

	private bool isInFront;

	private bool checkBehindHasBlock;

	private bool checkFrontHasBlock;

	private bool moveBlocked;

	private float stopDis;

	public override void OnStart()
	{
		m_Entity = Owner.ToEntity();
		m_MonoEntity = m_Entity.GetMono();
		m_CompTransform = m_Entity.GetCompTransform();
		m_CompPhysics = m_Entity.GetCompPhysics();
		m_CompInput = m_Entity.GetCompInput();
		m_CompHatred = m_Entity.GetCompHatred();
		realPos = VectorUtility.GetClosestPoint(m_CompTransform.physicsPosition, posLeft.Value, posRight.Value);
		m_CompNav = m_Entity.GetCompNav();
		m_CompNav.SetManualKeepDestination(value: true);
		moveBlocked = !m_Entity.GetCompAI().TryCommitCombatMoveDestination(m_CompNav, realPos, "BTGroundMoveToPosition");
		ConfigCharacter config = m_Entity.GetConfig();
		for (int i = 0; i < config.moveMotions.Length; i++)
		{
			if (config.moveMotions[i].motion != null && !config.moveMotions[i].IsForbidden && config.moveMotions[i].motion.name.Contains("move") && config.moveMotions[i].motion.name.Contains("back"))
			{
				hasMoveBack = true;
				break;
			}
		}
		checkBehindHasBlock = (checkFrontHasBlock = false);
		m_CompPhysics.SetCliffBlockDetection(enabled: true);
		OnFixedUpdate();
		stopDis = ((m_CompNav.sqrStoppingDistance < 0.1f) ? 0.1f : m_CompNav.sqrStoppingDistance);
	}

	public override void OnFixedUpdate()
	{
		Vector3 attachPointPosition = m_MonoEntity.GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT);
		Vector3 vector = attachPointPosition;
		float x = m_CompTransform.size.x;
		float num = x;
		float num2 = x;
		float num3 = m_MonoEntity.SonColliderBounds.size.x * 0.5f;
		if (num3 > x)
		{
			float x2 = m_MonoEntity.SonCollidersCenterOffset.x;
			float num4 = num3 + x2;
			float num5 = num3 - x2;
			if (m_CompTransform.FaceDir == FaceDir.Left)
			{
				num = Mathf.Max(x, num4 + 0.5f);
				num2 = Mathf.Max(x, num5 + 0.5f);
			}
			else
			{
				num = Mathf.Max(x, num5 + 0.5f);
				num2 = Mathf.Max(x, num4 + 0.5f);
			}
		}
		float num6 = m_CompNav.sqrStoppingDistance + num;
		float num7 = m_CompNav.sqrStoppingDistance + num2;
		vector.x -= num6;
		checkBehindHasBlock = Physics.Raycast(attachPointPosition, vector - attachPointPosition, num6, BattleConsts.enviromentMask);
		vector = attachPointPosition;
		vector.x += num7;
		checkFrontHasBlock = Physics.Raycast(attachPointPosition, vector - attachPointPosition, num7, BattleConsts.enviromentMask);
	}

	public override TaskStatus OnUpdate()
	{
		if (moveBlocked)
		{
			return TaskStatus.Success;
		}
		realPos = VectorUtility.GetClosestPoint(m_CompTransform.physicsPosition, posLeft.Value, posRight.Value);
		isInFront = BoolUtility.IsInFront(m_CompTransform.FaceDir == FaceDir.Left, m_CompTransform.physicsPosition.x, realPos.x);
		if (m_CompPhysics.FrameCollided || m_CompPhysics.FrameCliffBlocked)
		{
			m_Entity.GetCompAI().RecordMoveFail("BTGroundMoveToPosition");
			m_CompInput.inputDir = EInputDir.None;
			SharedVector3 sharedVector = posLeft;
			Vector3 value = (posRight.Value = m_CompTransform.physicsPosition);
			sharedVector.Value = value;
			return TaskStatus.Success;
		}
		if (m_CompNav.CheckArrived(m_CompTransform.physicsPosition, realPos))
		{
			m_CompInput.inputDir = EInputDir.None;
			SharedVector3 sharedVector2 = posRight;
			Vector3 value = (posLeft.Value = m_CompTransform.physicsPosition);
			sharedVector2.Value = value;
			return TaskStatus.Success;
		}
		if (!m_Entity.GetCompAI().TryCommitCombatMoveDestination(m_CompNav, realPos, "BTGroundMoveToPosition"))
		{
			m_CompInput.inputDir = EInputDir.None;
			return TaskStatus.Success;
		}
		Vector3 rhs = realPos - m_CompTransform.physicsPosition;
		rhs.y = (rhs.z = 0f);
		if (rhs.sqrMagnitude <= stopDis)
		{
			m_CompInput.inputDir = EInputDir.None;
			SharedVector3 sharedVector3 = posRight;
			Vector3 value = (posLeft.Value = m_CompTransform.physicsPosition);
			sharedVector3.Value = value;
			return TaskStatus.Success;
		}
		if (Vector3.Dot(m_CompPhysics.pathTangent, rhs) > 0f)
		{
			if (!checkFrontHasBlock)
			{
				m_CompInput.inputDir = EInputDir.Right;
			}
		}
		else if (!checkBehindHasBlock)
		{
			m_CompInput.inputDir = EInputDir.Left;
		}
		if (hasMoveBack)
		{
			if (!isInFront)
			{
				Vector3 physicsPosition4 = m_CompHatred.hatredTarget.GetCompTransform().physicsPosition;
				float num = Mathf.Abs(m_CompTransform.physicsPosition.x - physicsPosition4.x);
				if (Mathf.Abs(realPos.x - physicsPosition4.x) > num)
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
		m_CompPhysics.SetCliffBlockDetection(enabled: false);
		m_CompInput.inputDir = EInputDir.None;
		m_CompNav.destination = m_CompTransform.physicsPosition;
		m_CompNav.manual = false;
		m_Entity.SetBool("move_back", value: false);
	}
}
