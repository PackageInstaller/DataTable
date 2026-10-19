using System;
using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[Obsolete]
public class BTOrConditional : Conditional
{
	public ConfigPredicate[] conditions;

	private Entity _entity;

	public override void OnStart()
	{
		_entity = Owner.ToEntity();
	}

	public override TaskStatus OnUpdate()
	{
		if (!_entity.IsValid)
		{
			return TaskStatus.Success;
		}
		ActionMemory memory = new ActionMemory(_entity, _entity, _entity);
		ConfigPredicate[] array = conditions;
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].Check(memory))
			{
				return TaskStatus.Success;
			}
		}
		return TaskStatus.Failure;
	}
}
