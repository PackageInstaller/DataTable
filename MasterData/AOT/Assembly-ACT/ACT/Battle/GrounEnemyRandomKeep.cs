using System;

namespace ACT.Battle;

[Serializable]
public class GrounEnemyRandomKeep
{
	public float groundMinKeepCD = 1f;

	public float groundMaxKeepCD = 5f;

	public float groundMinFrontDis = 1f;

	public float groundMaxFrontDis = 4f;

	public float groundMinBackDis = 1f;

	public float groundMaxBackDis = 4f;

	public GrounEnemyRandomKeep(GrounEnemyRandomKeep key)
	{
		groundMinKeepCD = key.groundMinKeepCD;
		groundMaxKeepCD = key.groundMaxKeepCD;
		groundMinFrontDis = key.groundMinFrontDis;
		groundMaxFrontDis = key.groundMaxFrontDis;
		groundMinBackDis = key.groundMinBackDis;
		groundMaxBackDis = key.groundMaxBackDis;
	}

	public GrounEnemyRandomKeep()
	{
	}
}
