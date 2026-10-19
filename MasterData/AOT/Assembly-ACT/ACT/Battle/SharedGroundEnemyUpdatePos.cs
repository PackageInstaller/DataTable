using System;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedGroundEnemyUpdatePos : SharedVariable<GroundEnemyUpdatePos>
{
	public static implicit operator SharedGroundEnemyUpdatePos(GroundEnemyUpdatePos value)
	{
		return new SharedGroundEnemyUpdatePos
		{
			mValue = value
		};
	}
}
