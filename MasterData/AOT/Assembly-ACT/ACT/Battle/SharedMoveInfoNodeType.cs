using System;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedMoveInfoNodeType : SharedVariable<MoveInfoNodeType>
{
	public static implicit operator SharedMoveInfoNodeType(MoveInfoNodeType value)
	{
		return new SharedMoveInfoNodeType
		{
			mValue = value
		};
	}
}
