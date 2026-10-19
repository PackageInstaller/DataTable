using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("判断行为是否可以执行")]
public class IsAIBehaviourCanUse : Action
{
	public SharedAIBehaviourList allBehaviourList;

	public SharedAIBehaviourList canDoBehaviourList;

	public SharedFloat inBattleTime;

	private AIBehaviourData action;

	private Entity m_entity;

	private bool _loggedInvalidContext;

	public override void OnAwake()
	{
		base.OnAwake();
		if (canDoBehaviourList == null)
		{
			LogInvalidContext("OnAwake canDoBehaviourList is null");
		}
		else if (canDoBehaviourList.Value == null)
		{
			canDoBehaviourList.Value = new List<AIBehaviourData>();
		}
	}

	public override void OnStart()
	{
		if (Owner is ActBehaviorTree actBehaviorTree)
		{
			m_entity = actBehaviorTree.Entity;
		}
		else
		{
			LogInvalidContext("OnStart owner is not ActBehaviorTree");
		}
	}

	public override TaskStatus OnUpdate()
	{
		if (!(Owner is ActBehaviorTree actBehaviorTree))
		{
			LogInvalidContext("OnUpdate owner is not ActBehaviorTree");
			return TaskStatus.Failure;
		}
		m_entity = actBehaviorTree.Entity;
		if (!m_entity.IsValid)
		{
			LogInvalidContext("OnUpdate entity is invalid");
			return TaskStatus.Failure;
		}
		if (!m_entity.TryGetCompHatred(out CompHatred component) || allBehaviourList?.Value == null || canDoBehaviourList?.Value == null || inBattleTime == null)
		{
			LogInvalidContext("OnUpdate invalid dependency");
			return TaskStatus.Failure;
		}
		float time = Time.time;
		float distanceBetweenMeAndHatredTarget = component.GetDistanceBetweenMeAndHatredTarget(DistanceType.verticalWithOutAbs);
		bool flag = component.HatredIsInFront();
		float num = 0f;
		num = component.GetDistanceBetweenMeAndHatredTarget(DistanceType.horizontalAddColliderRadius);
		num = Mathf.Max(num, 0f);
		for (int i = 0; i < allBehaviourList.Value.Count; i++)
		{
			action = allBehaviourList.Value[i];
			if (action == null)
			{
				if (!LuminApplication.LogEnabled)
				{
				}
				continue;
			}
			if (string.IsNullOrEmpty(action.name))
			{
				if (!LuminApplication.LogEnabled)
				{
				}
				continue;
			}
			bool flag2 = true;
			if (flag2 && (action.parameterFlag.HasFlag(SubTaskParameterFlag.frontDistance) || action.parameterFlag.HasFlag(SubTaskParameterFlag.backDistance)) && (!(0f - action.verticalDownDistance <= distanceBetweenMeAndHatredTarget) || !(distanceBetweenMeAndHatredTarget <= action.verticalUpDistance)) && Mathf.Abs(0f - action.verticalDownDistance - action.verticalUpDistance) > 0.2f)
			{
				flag2 = false;
			}
			if (flag2 && action.parameterFlag.HasFlag(SubTaskParameterFlag.cd))
			{
				if (action.lastTime <= 0f)
				{
					if (time - inBattleTime.Value + action.lastTime <= 0f)
					{
						flag2 = false;
					}
				}
				else if (flag2 && time - action.lastTime <= action.cd)
				{
					flag2 = false;
				}
			}
			if (action.parameterFlag.HasFlag(SubTaskParameterFlag.frontDistance) || action.parameterFlag.HasFlag(SubTaskParameterFlag.backDistance))
			{
				if (flag2 && action.parameterFlag.HasFlag(SubTaskParameterFlag.frontDistance) && flag)
				{
					if (action.minFrontDistance > num)
					{
						flag2 = false;
					}
					if (action.maxFrontDistance < num)
					{
						flag2 = false;
					}
				}
				if (flag && !action.parameterFlag.HasFlag(SubTaskParameterFlag.frontDistance))
				{
					flag2 = false;
				}
				if (flag2 && action.parameterFlag.HasFlag(SubTaskParameterFlag.backDistance) && !flag)
				{
					if (action.minBackDistance > num)
					{
						flag2 = false;
					}
					if (action.maxBackDistance < num)
					{
						flag2 = false;
					}
				}
				if (!flag && !action.parameterFlag.HasFlag(SubTaskParameterFlag.backDistance))
				{
					flag2 = false;
				}
			}
			if (flag2 && action.parameterFlag.HasFlag(SubTaskParameterFlag.condition) && action.condition != null && action.condition.configPredicates != null)
			{
				ActionMemory memory = new ActionMemory(m_entity, m_entity, m_entity);
				ConfigPredicate[] configPredicates = action.condition.configPredicates;
				foreach (ConfigPredicate configPredicate in configPredicates)
				{
					if (!(configPredicate.Inverse ? (!configPredicate.Check(memory)) : configPredicate.Check(memory)))
					{
						flag2 = false;
						break;
					}
				}
			}
			if (flag2 && !canDoBehaviourList.Value.Contains(action))
			{
				canDoBehaviourList.Value.Add(action);
			}
			else if (!flag2 && canDoBehaviourList.Value.Contains(action))
			{
				canDoBehaviourList.Value.Remove(action);
			}
		}
		return TaskStatus.Success;
	}

	public override void OnEnd()
	{
	}

	public override void OnReset()
	{
		action = null;
	}

	private void LogInvalidContext(string reason)
	{
		if (!_loggedInvalidContext)
		{
			_loggedInvalidContext = true;
			ActBehaviorTree actBehaviorTree = Owner as ActBehaviorTree;
			string arg = ((Owner != null && Owner.gameObject != null) ? Owner.gameObject.name : "<null>");
			bool isValid = m_entity.IsValid;
			CompAI component = null;
			bool flag = isValid && m_entity.TryGetCompAI(out component);
			bool flag2 = isValid && m_entity.TryGetCompHatred(out CompHatred _);
			bool flag3 = isValid && m_entity.HasCompGroupAI();
			bool flag4 = isValid && m_entity.GetRoot() != null;
			bool flag5 = isValid && m_entity.IsLogicAvailable();
			bool flag6 = isValid && m_entity.IsOnRemove();
			bool flag7 = isValid && m_entity.IsToRemove();
			bool flag8 = component?.ActBehaviorTree != null;
			int num = allBehaviourList?.Value?.Count ?? (-1);
			int num2 = canDoBehaviourList?.Value?.Count ?? (-1);
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"[BTDiag] IsAIBehaviourCanUse invalid context. reason={reason}, owner={arg}, taskId={ID}, " + $"actBtNull={actBehaviorTree == null}, entity={m_entity}, entityValid={isValid}, hasAI={flag}, " + $"actTreeReady={flag8}, hasHatred={flag2}, hasGroupAI={flag3}, hasRoot={flag4}, " + $"logicAvailable={flag5}, onRemove={flag6}, toRemove={flag7}, " + $"allListNull={allBehaviourList == null}, allListCount={num}, canDoListNull={canDoBehaviourList == null}, " + $"canDoCount={num2}, inBattleTimeNull={inBattleTime == null}");
			}
		}
	}
}
