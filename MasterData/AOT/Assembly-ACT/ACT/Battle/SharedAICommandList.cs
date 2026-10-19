using System;
using System.Collections.Generic;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedAICommandList : SharedVariable<Queue<AICommandData>>
{
	public static implicit operator SharedAICommandList(Queue<AICommandData> value)
	{
		return new SharedAICommandList
		{
			mValue = value
		};
	}
}
