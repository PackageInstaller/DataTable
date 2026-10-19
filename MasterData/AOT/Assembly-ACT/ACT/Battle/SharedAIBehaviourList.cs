using System;
using System.Collections.Generic;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedAIBehaviourList : SharedVariable<List<AIBehaviourData>>
{
	public static implicit operator SharedAIBehaviourList(List<AIBehaviourData> value)
	{
		return new SharedAIBehaviourList
		{
			mValue = value
		};
	}
}
