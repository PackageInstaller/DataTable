using System;

[Serializable]
public sealed class SummerRaceEnemyHudRuntimeState
{
	public string enemyId = string.Empty;

	public string enemyName = string.Empty;

	public float enemyHp;

	public float enemyMaxHp;

	public bool enemyAlive;

	public bool enemyHeadOut;

	public SummerRaceEnemyHudRuntimeState Clone()
	{
		return (SummerRaceEnemyHudRuntimeState)MemberwiseClone();
	}
}
