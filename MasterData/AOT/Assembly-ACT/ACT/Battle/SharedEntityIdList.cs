using System;
using System.Collections.Generic;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedEntityIdList : SharedVariable<List<EntityId>>
{
	public static implicit operator SharedEntityIdList(List<EntityId> value)
	{
		return new SharedEntityIdList
		{
			mValue = value
		};
	}
}
