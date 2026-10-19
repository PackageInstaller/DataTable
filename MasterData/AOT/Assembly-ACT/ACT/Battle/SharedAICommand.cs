using System;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedAICommand : SharedVariable<AICommandData>
{
	public static implicit operator SharedAICommand(AICommandData value)
	{
		return new SharedAICommand
		{
			mValue = value
		};
	}
}
