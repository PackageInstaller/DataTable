using System;
using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT")]
[TaskDescription("按列表顺序选择第一个自定义行为")]
public class SelectCustomAIBehaviour : BehaviorDesigner.Runtime.Tasks.Action
{
	public SharedAIBehaviourList allBehaviourList;

	public SharedInt priority;

	private Entity m_entity;

	public override void OnStart()
	{
		m_entity = ((ActBehaviorTree)Owner).Entity;
		if (!m_entity.IsValid || allBehaviourList?.Value == null)
		{
			return;
		}
		foreach (AIBehaviourData item in allBehaviourList.Value)
		{
			if (item != null && !string.IsNullOrEmpty(item.name))
			{
				m_entity.GetCompAI().SubmitAttackRequest(item, "SelectCustomAIBehaviour", priority.Value);
				item.lastTime = Time.time;
				if (item.decoratorCondition != null && item.decoratorCondition.configAction != null)
				{
					ActionMemory memory = new ActionMemory(m_entity, m_entity, m_entity);
					try
					{
						item.decoratorCondition.configAction.Do(memory);
						break;
					}
					catch (Exception)
					{
						_ = LuminApplication.LogEnabled;
						break;
					}
				}
				break;
			}
		}
	}

	public override TaskStatus OnUpdate()
	{
		if (!m_entity.IsValid || !m_entity.GetCompAI().HasPendingAttackRequest())
		{
			return TaskStatus.Failure;
		}
		return TaskStatus.Success;
	}
}
