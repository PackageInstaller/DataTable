using System;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedAirEnemyUpdatePos : SharedVariable<AirEnemyUpdatePos>
{
	public static implicit operator SharedAirEnemyUpdatePos(AirEnemyUpdatePos value)
	{
		return new SharedAirEnemyUpdatePos
		{
			mValue = value
		};
	}
}
