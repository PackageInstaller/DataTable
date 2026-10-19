using System;
using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[Obsolete]
public class BTAndConditional : Conditional
{
	[SerializeField]
	public ConfigPredicate[] conditions;

	private Entity m_entity;

	public override void OnStart()
	{
		m_entity = (Owner as ActBehaviorTree).Entity;
	}

	public override TaskStatus OnUpdate()
	{
		ActionMemory memory = new ActionMemory(m_entity, m_entity, m_entity);
		ConfigPredicate[] array = conditions;
		for (int i = 0; i < array.Length; i++)
		{
			if (!array[i].Check(memory))
			{
				return TaskStatus.Failure;
			}
		}
		return TaskStatus.Success;
	}
}
