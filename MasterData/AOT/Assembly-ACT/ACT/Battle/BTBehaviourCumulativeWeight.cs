using System;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/仇恨")]
[TaskDescription("根据仇恨目标的行为积累权重, hitFromBehindWeight 需要ability中配合修改行为树参数")]
public class BTBehaviourCumulativeWeight : BehaviorDesigner.Runtime.Tasks.Action
{
	[Flags]
	public enum CumulativeWeightOptions
	{
		distance = 1,
		air = 2,
		hitFromBehind = 4
	}

	[FlagsEnum]
	public CumulativeWeightOptions options;

	[SharedRequired]
	public SharedFloat distanceWeight;

	[SharedRequired]
	public SharedFloat airWeight;

	[SharedRequired]
	public SharedFloat hitFromBehindWeight;

	public Condition distanceCondition;

	public SharedFloat distanceThresholds;

	public SharedFloat distanceTimeThresholds;

	public SharedFloat distanceMaxTime;

	public SharedFloat distanceRecessionTime;

	public SharedFloat distanceWeightSpeed;

	private float m_InDistanceTime;

	private float m_UnInDistanceTime;

	public SharedFloat airTimeThresholds;

	public SharedFloat airMaxTime;

	public SharedFloat airRecessionTime;

	public SharedFloat airWeightSpeed;

	private float m_InAirTime;

	private float m_UnInAirTime;

	[SharedRequired]
	public SharedInt hitCount;

	public SharedInt hitCountThresholds;

	public SharedInt hitCountMaxCount;

	public override TaskStatus OnUpdate()
	{
		Entity entity = ((ActBehaviorTree)Owner).Entity;
		CompHatred compHatred = entity.GetCompHatred();
		if (compHatred == null || !compHatred.hatredTarget.IsValid)
		{
			return TaskStatus.Failure;
		}
		Entity hatredTarget = compHatred.hatredTarget;
		float fixedDeltaTime = hatredTarget.GetCompTime().fixedDeltaTime;
		float num = Vector3.Distance(entity.GetCompTransform().physicsPosition, hatredTarget.GetCompTransform().physicsPosition);
		if (options.HasFlag(CumulativeWeightOptions.distance) && distanceWeight != null)
		{
			bool flag = distanceCondition switch
			{
				Condition.Greater => num > distanceThresholds.Value, 
				Condition.Less => num < distanceThresholds.Value, 
				Condition.Equal => num == distanceThresholds.Value, 
				Condition.GreaterAndEqual => num >= distanceThresholds.Value, 
				Condition.LessAndEqual => num <= distanceThresholds.Value, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			m_InDistanceTime = (flag ? Mathf.Clamp(m_InDistanceTime + fixedDeltaTime, 0f, distanceMaxTime.Value) : 0f);
			m_UnInDistanceTime = (flag ? 0f : Mathf.Clamp(m_UnInDistanceTime + fixedDeltaTime, 0f, distanceMaxTime.Value));
			if (m_InDistanceTime > distanceTimeThresholds.Value)
			{
				distanceWeight.Value = Mathf.Clamp01(distanceWeight.Value + distanceWeightSpeed.Value * fixedDeltaTime / (distanceMaxTime.Value - distanceTimeThresholds.Value));
			}
			if (m_UnInDistanceTime > distanceRecessionTime.Value)
			{
				distanceWeight.Value = Mathf.Clamp01(distanceWeight.Value - distanceWeightSpeed.Value * fixedDeltaTime / (distanceMaxTime.Value - distanceTimeThresholds.Value));
			}
		}
		if (options.HasFlag(CumulativeWeightOptions.air) && airWeight != null)
		{
			bool flag2 = !hatredTarget.GetCompPhysics().isGrounded;
			m_InAirTime = (flag2 ? Mathf.Clamp(m_InAirTime + fixedDeltaTime, 0f, airMaxTime.Value) : 0f);
			m_UnInAirTime = (flag2 ? 0f : Mathf.Clamp(m_UnInAirTime + fixedDeltaTime, 0f, airMaxTime.Value));
			if (m_InAirTime > airTimeThresholds.Value)
			{
				airWeight.Value = Mathf.Clamp01(airWeight.Value + airWeightSpeed.Value * fixedDeltaTime / (airMaxTime.Value - airTimeThresholds.Value));
			}
			if (m_UnInDistanceTime > airRecessionTime.Value)
			{
				airWeight.Value = Mathf.Clamp01(airWeight.Value - airWeightSpeed.Value * fixedDeltaTime / (airMaxTime.Value - airTimeThresholds.Value));
			}
		}
		if (options.HasFlag(CumulativeWeightOptions.hitFromBehind) && hitFromBehindWeight != null)
		{
			if (hitCount.Value > hitCountThresholds.Value)
			{
				hitFromBehindWeight.Value = (float)(hitCount.Value - hitCountThresholds.Value) / (float)(hitCountMaxCount.Value - hitCountThresholds.Value);
			}
			else
			{
				hitFromBehindWeight.Value = 0f;
			}
		}
		return TaskStatus.Success;
	}
}
