using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动节点")]
[TaskDescription("空中单位 基于仇恨目标从扇形范围内获取飞行终点")]
public class BTGetFlyEndPosition : Action
{
	public SharedAirEnemyUpdatePos attackToken;

	public SharedAirEnemyUpdatePos noAttackToken;

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
		m_Entity = Owner.ToEntity();
		if (attackToken.Value != null)
		{
			followOutsideRadius.Value = attackToken.Value.followOutsideRadius;
			followInsideRadius.Value = attackToken.Value.followInsideRadius;
			minAngle.Value = attackToken.Value.minAngle;
			maxAngle.Value = attackToken.Value.maxAngle;
			mirrorAngle.Value = attackToken.Value.mirrorAngle;
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
		CompTransform compTransform = m_Entity.GetCompTransform();
		CompHatred compHatred = m_Entity.GetCompHatred();
		Vector3 vector = ((compHatred == null || !compHatred.hatredTarget.IsValid) ? compTransform.physicsPosition : AbilityUtility.GetTargetPosition(m_Entity.GetCompHatred().hatredTarget, posSourceType));
		m_TargetPos = vector + (Quaternion.AngleAxis(m_RandomAngle, -(compTransform.PathRotation * Vector3.right)) * compTransform.PathRotation * Vector3.forward).normalized * m_RandomRadius;
	}

	private void GetRandomParam()
	{
		m_RandomRadius = Mathf.Max(Random.Range(followInsideRadius.Value, followOutsideRadius.Value), 0f);
		m_RandomAngle = Random.Range(minAngle.Value, maxAngle.Value);
		m_RandomAngle = Mathf.Clamp(m_RandomAngle, 0f, 180f);
		CompHatred compHatred = m_Entity.GetCompHatred();
		CompTransform compTransform = m_Entity.GetCompTransform();
		if (compHatred != null && compHatred.hatredTarget.IsValid)
		{
			Entity hatredTarget = compHatred.hatredTarget;
			Vector3 targetPosition = AbilityUtility.GetTargetPosition(hatredTarget, posSourceType);
			Vector3 vector = hatredTarget.GetCompTransform().PathRotation * (targetPosition - compTransform.physicsPosition);
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
