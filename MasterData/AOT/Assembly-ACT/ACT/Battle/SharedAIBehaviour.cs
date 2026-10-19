using System;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedAIBehaviour : SharedVariable<AIBehaviourData>
{
	public static implicit operator SharedAIBehaviour(AIBehaviourData value)
	{
		return new SharedAIBehaviour
		{
			mValue = value
		};
	}
}
