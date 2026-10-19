using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/废弃节点")]
[TaskDescription("功能重复了，直接用 BTGetFlyEndPosition 就行")]
public class BTGetFlyToTargetPosition : Action
{
	public SharedAirEnemyUpdatePos sharedAirEnemyUpdatePos;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("输出位置")]
	public SharedVector3 position;

	[SharedRequired]
	public SharedFloat outRandomRadius;

	[SharedRequired]
	public SharedFloat outRandomAngle;

	public PosSourceType posSourceType;

	public SharedFloat followOutsideRadius;

	public SharedFloat followInsideRadius;

	public SharedFloat minAngle;

	public SharedFloat maxAngle;

	public SharedBool mirrorAngle = true;

	private Entity m_Entity;

	private Vector3 m_TargetPos;

	private float m_RandomRadius;

	private float m_RandomAngle;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		if (sharedAirEnemyUpdatePos.Value != null)
		{
			followOutsideRadius.Value = sharedAirEnemyUpdatePos.Value.followOutsideRadius;
			followInsideRadius.Value = sharedAirEnemyUpdatePos.Value.followInsideRadius;
			minAngle.Value = sharedAirEnemyUpdatePos.Value.minAngle;
			maxAngle.Value = sharedAirEnemyUpdatePos.Value.maxAngle;
			mirrorAngle.Value = sharedAirEnemyUpdatePos.Value.mirrorAngle;
		}
	}

	public override TaskStatus OnUpdate()
	{
		GetRandomParam();
		UpdateTargetPos();
		position.Value = m_TargetPos;
		return TaskStatus.Success;
	}

	private void UpdateTargetPos()
	{
		CompHatred compHatred = m_Entity.GetCompHatred();
		CompTransform compTransform = m_Entity.GetCompTransform();
		Vector3 vector = ((!(compHatred.hatredTarget != null)) ? compTransform.physicsPosition : AbilityUtility.GetTargetPosition(compHatred.hatredTarget, posSourceType));
		m_TargetPos = vector + (Quaternion.AngleAxis(m_RandomAngle, -(compTransform.PathRotation * Vector3.right)) * m_Entity.GetCompTransform().PathRotation * Vector3.forward).normalized * m_RandomRadius;
		ClampTargetPosByFrontEnvironment();
	}

	private void ClampTargetPosByFrontEnvironment()
	{
		CompTransform compTransform = m_Entity.GetCompTransform();
		if (compTransform.FaceDir != FaceDir.Right && compTransform.FaceDir != FaceDir.Left)
		{
			return;
		}
		float num = ((compTransform.FaceDir == FaceDir.Right) ? 1f : (-1f));
		Vector3 direction = Vector3.right * num;
		if (!Physics.Raycast(compTransform.physicsPosition, direction, out var hitInfo, 5f, BattleConsts.enviromentMask))
		{
			return;
		}
		MonoEntity mono = m_Entity.GetMono();
		Vector3 sonCollidersCenterOffset = mono.SonCollidersCenterOffset;
		float x = mono.SonColliderBounds.size.x;
		float num2 = hitInfo.point.x + ((compTransform.FaceDir == FaceDir.Left) ? (x / 2f + sonCollidersCenterOffset.x) : ((0f - x) / 2f - sonCollidersCenterOffset.x));
		float num3 = (m_TargetPos.x - compTransform.physicsPosition.x) * num;
		if (!(num3 <= 0f))
		{
			float num4 = Mathf.Max((num2 - compTransform.physicsPosition.x) * num, 0f);
			if (num3 > num4)
			{
				m_TargetPos.x = compTransform.physicsPosition.x + num4 * num;
			}
		}
	}

	private void GetRandomParam()
	{
		m_RandomRadius = Mathf.Max(Random.Range(followInsideRadius.Value, followOutsideRadius.Value), 0f);
		m_RandomAngle = Random.Range(minAngle.Value, maxAngle.Value);
		m_RandomAngle = Mathf.Clamp(m_RandomAngle, 0f, 180f);
		CompHatred compHatred = m_Entity.GetCompHatred();
		CompTransform compTransform = m_Entity.GetCompTransform();
		if (compHatred.hatredTarget.IsValid)
		{
			Vector3 targetPosition = AbilityUtility.GetTargetPosition(compHatred.hatredTarget, posSourceType);
			Vector3 vector = compHatred.hatredTarget.GetCompTransform().PathRotation * (targetPosition - compTransform.physicsPosition);
			if (mirrorAngle.Value && (!(vector.z > 0f) || !(m_RandomAngle < 90f)) && (!(vector.z >= 0f) || !(m_RandomAngle >= 90f)))
			{
				m_RandomAngle = 180f - m_RandomAngle;
			}
		}
		if (outRandomRadius != null)
		{
			outRandomRadius.Value = m_RandomRadius;
		}
		if (outRandomAngle != null)
		{
			outRandomAngle.Value = m_RandomAngle;
		}
	}
}
