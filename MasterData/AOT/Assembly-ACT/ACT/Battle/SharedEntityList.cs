using System;
using System.Collections.Generic;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedEntityList : SharedVariable<List<Entity>>
{
	public static implicit operator SharedEntityList(List<Entity> value)
	{
		return new SharedEntityList
		{
			mValue = value
		};
	}
}
