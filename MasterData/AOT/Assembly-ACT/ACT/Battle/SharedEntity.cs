using System;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedEntity : SharedVariable<Entity>
{
	public static implicit operator SharedEntity(Entity value)
	{
		return new SharedEntity
		{
			mValue = value
		};
	}
}
