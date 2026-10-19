using System;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedGrounEnemyRandomKeep : SharedVariable<GrounEnemyRandomKeep>
{
	public static implicit operator SharedGrounEnemyRandomKeep(GrounEnemyRandomKeep value)
	{
		return new SharedGrounEnemyRandomKeep
		{
			mValue = value
		};
	}
}
