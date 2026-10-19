using System;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedRobotMoveType : SharedVariable<RobotMoveType>
{
	public static implicit operator SharedRobotMoveType(RobotMoveType value)
	{
		return new SharedRobotMoveType
		{
			mValue = value
		};
	}
}
