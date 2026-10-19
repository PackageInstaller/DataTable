using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("执行指定的出生行为")]
public class DoSpecifyBornBehaviour : BehaviorDesigner.Runtime.Tasks.Action
{
	public SharedAIBehaviourList allBehaviourList;

	public SharedString actionName;

	private Entity m_Entity;

	public override void OnStart()
	{
		if (actionName == null || string.IsNullOrEmpty(actionName.Value))
		{
			return;
		}
		m_Entity = (Owner as ActBehaviorTree)?.Entity ?? default(Entity);
		List<AIBehaviourData> list = allBehaviourList?.Value;
		AIBehaviourData aIBehaviourData = list?.Find((AIBehaviourData item) => item != null && item.name == actionName.Value);
		if (aIBehaviourData != null)
		{
			aIBehaviourData.lastTime = Time.time;
		}
		if (m_Entity.IsValid)
		{
			CompMotion compMotion = m_Entity.GetCompMotion();
			if (compMotion != null)
			{
				compMotion.SetBool(actionName.Value, b: true);
				compMotion.SetTrigger("UseSkill");
			}
		}
		if (list != null)
		{
			for (int num = 0; num < list.Count; num++)
			{
				AIBehaviourData aIBehaviourData2 = list[num];
				if (aIBehaviourData2 != null && !(aIBehaviourData2.name != actionName.Value) && !(aIBehaviourData2.decoratorCondition == null) && aIBehaviourData2.decoratorCondition.configAction != null)
				{
					ActionMemory memory = new ActionMemory(m_Entity, m_Entity, m_Entity);
					try
					{
						aIBehaviourData2.decoratorCondition.configAction.Do(memory);
					}
					catch (Exception)
					{
						_ = LuminApplication.LogEnabled;
					}
				}
			}
		}
		if (m_Entity.IsValid)
		{
			CompAI compAI = m_Entity.GetCompAI();
			if (compAI != null)
			{
				compAI.behaviorDepth = 0;
			}
		}
	}

	public override TaskStatus OnUpdate()
	{
		if (actionName == null || string.IsNullOrEmpty(actionName.Value))
		{
			return TaskStatus.Failure;
		}
		CompMotion compMotion = m_Entity.GetCompMotion();
		if (compMotion == null)
		{
			return TaskStatus.Failure;
		}
		compMotion.parameters.TryGetValue("UseSkill", out var value);
		if (!value.defaultBool && compMotion.curMotionState != MotionState.Attack)
		{
			return TaskStatus.Success;
		}
		if (compMotion.curMotionState == MotionState.Hit)
		{
			m_Entity.ResetTrigger("UseSkill");
			return TaskStatus.Success;
		}
		compMotion.SetBool(actionName.Value, b: true);
		return TaskStatus.Running;
	}

	public override void OnEnd()
	{
		if (actionName != null && !string.IsNullOrEmpty(actionName.Value) && m_Entity.IsValid)
		{
			m_Entity.GetCompMotion()?.SetBool(actionName.Value, b: false);
			m_Entity.GetCompAI()?.ReleaseAttackBody(actionName.Value);
		}
	}
}
