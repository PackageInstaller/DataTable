using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动")]
[TaskDescription("飞向目标点")]
public class BTFlyToPosition : Action
{
	private const float FlyRootMotionBrakeLookaheadTime = 0.6f;

	private const float MinHorizontalBrakeSpeed = 0.01f;

	private const float ArrivalTargetToleranceSqr = 0.0001f;

	private Vector3 m_RootMotionArrivalTarget;

	private FSMRuntimeState m_RootMotionArrivalState;

	private float m_RootMotionArrivalDirection;

	[BehaviorDesigner.Runtime.Tasks.Tooltip("输入位置")]
	public SharedVector3 position;

	private Entity m_Entity;

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		CompNav compNav = m_Entity.GetCompNav();
		CompInput compInput = m_Entity.GetCompInput();
		Vector3 physicsPosition = m_Entity.GetCompTransform().physicsPosition;
		Vector3 value = position.Value;
		if (!m_Entity.GetCompAI().TryCommitCombatMoveDestination(compNav, value, "BTFlyToPosition"))
		{
			ResetRootMotionArrival();
			compInput.dir = Vector3.zero;
			return TaskStatus.Success;
		}
		if (CanKeepRootMotionArrival(value))
		{
			compInput.dir = Vector3.zero;
			return TaskStatus.Success;
		}
		if (HasReachedFlyTarget(compNav, physicsPosition, value, out var rootMotionBraking))
		{
			if (rootMotionBraking)
			{
				m_RootMotionArrivalTarget = value;
				m_RootMotionArrivalState = m_Entity.GetCompMotion().layer0Peak;
				m_RootMotionArrivalDirection = Mathf.Sign(value.x - physicsPosition.x);
			}
			compInput.dir = Vector3.zero;
			return TaskStatus.Success;
		}
		compInput.dir = (value - physicsPosition).normalized;
		Debug.DrawLine(physicsPosition, value);
		return TaskStatus.Running;
	}

	public override void OnEnd()
	{
		m_Entity.GetCompInput().dir = Vector3.zero;
	}

	public override void OnBehaviorComplete()
	{
		ResetRootMotionArrival();
	}

	private bool HasReachedFlyTarget(CompNav compNav, Vector3 current, Vector3 target, out bool rootMotionBraking)
	{
		rootMotionBraking = false;
		if (compNav.CheckArrived(current, target))
		{
			return true;
		}
		if (!compNav.isAir)
		{
			return false;
		}
		float f = current.x - target.x;
		float num = current.y - target.y;
		if (num * num <= compNav.sqrStoppingDistance)
		{
			return false;
		}
		float num2 = Mathf.Sqrt(compNav.sqrStoppingDistance);
		float rootMotionBrakeDistance = GetRootMotionBrakeDistance(current, target);
		bool flag = Mathf.Abs(f) <= num2 + rootMotionBrakeDistance;
		rootMotionBraking = flag && rootMotionBrakeDistance > 0f;
		return flag;
	}

	private bool CanKeepRootMotionArrival(Vector3 target)
	{
		if (m_RootMotionArrivalState == null)
		{
			return false;
		}
		int num;
		if ((target - m_RootMotionArrivalTarget).sqrMagnitude <= 0.0001f && m_Entity.TryGetCompMotion(out CompMotion component) && component.layerMotionQueue[0].Contains(m_RootMotionArrivalState) && m_Entity.TryGetCompPhysics(out CompPhysics component2))
		{
			num = ((component2.PathLocalToWorld(component2.rawVelocity).x * m_RootMotionArrivalDirection > 0.01f) ? 1 : 0);
			if (num != 0)
			{
				goto IL_0083;
			}
		}
		else
		{
			num = 0;
		}
		ResetRootMotionArrival();
		goto IL_0083;
		IL_0083:
		return (byte)num != 0;
	}

	private void ResetRootMotionArrival()
	{
		m_RootMotionArrivalState = null;
	}

	private float GetRootMotionBrakeDistance(Vector3 current, Vector3 target)
	{
		if (m_Entity.TryGetCompPhysics(out CompPhysics component) && m_Entity.TryGetCompMotion(out CompMotion component2))
		{
			ConfigMotion configMotion = component2.layer0Peak?.actualMotion;
			if ((object)configMotion != null && configMotion.RootMotionXZ)
			{
				if (!TryGetMoveStopTransitionDuration(component2.layer0Peak, out var duration))
				{
					return 0f;
				}
				float num = Mathf.Sign(target.x - current.x);
				float num2 = component.PathLocalToWorld(component.rawVelocity).x * num;
				if (num2 <= 0.01f)
				{
					return 0f;
				}
				float num3 = Mathf.Max(duration + Time.fixedDeltaTime, 0.6f);
				return num2 * num3;
			}
		}
		return 0f;
	}

	private static bool TryGetMoveStopTransitionDuration(FSMRuntimeState runtimeState, out float duration)
	{
		duration = 0f;
		List<StateTransition> list = runtimeState?.state?.transitions;
		if (list == null)
		{
			return false;
		}
		for (int i = 0; i < list.Count; i++)
		{
			ConfigAnimStateTransition value = list[i].value;
			ConfigAnimCondition[] conditions = value.conditions;
			if (conditions != null && conditions.Length == 1)
			{
				ConfigAnimCondition configAnimCondition = conditions[0];
				if (configAnimCondition.parameter == "Move" && configAnimCondition.mode == ConfigAnimConditionMode.IfNot)
				{
					duration = Mathf.Max(0f, value.transitionDuration);
					return true;
				}
			}
		}
		return false;
	}
}
