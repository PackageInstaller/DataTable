using System;

[Serializable]
public sealed class SummerRaceBattleSnapshot
{
	public string mode = string.Empty;

	public int wave;

	public int waveTotal;

	public float timer;

	public float countdownRemaining;

	public float waveElapsed;

	public int score;

	public float hp;

	public float maxHp;

	public float energy;

	public float maxEnergy;

	public float playerLabelWorldX;

	public float playerLabelWorldY;

	public float playerLabelWorldZ;

	public float playerLabelScreenOffsetY;

	public float enemyHp;

	public float enemyMaxHp;

	public int enemyCount = 1;

	public string enemyId = string.Empty;

	public string enemyName = string.Empty;

	public SummerRaceEnemyHudRuntimeState[] enemyHudSlots = Array.Empty<SummerRaceEnemyHudRuntimeState>();

	public string enemyIntroText = string.Empty;

	public string enemyOverclockBubbleText = string.Empty;

	public int enemyOverclockBubbleToken;

	public bool enemyAlive;

	public bool enemyHeadOut;

	public string phase = string.Empty;

	public bool isBattleActive;

	public bool isPaused;

	public bool skillReady;

	public string stageId = string.Empty;

	public SummerRaceBattleSkillRuntimeState[] skills = Array.Empty<SummerRaceBattleSkillRuntimeState>();

	public SummerRaceBattleSnapshot Clone()
	{
		SummerRaceBattleSnapshot obj = (SummerRaceBattleSnapshot)MemberwiseClone();
		obj.skills = CloneSkills(skills);
		obj.enemyHudSlots = CloneEnemyHudSlots(enemyHudSlots);
		return obj;
	}

	private static SummerRaceBattleSkillRuntimeState[] CloneSkills(SummerRaceBattleSkillRuntimeState[] source)
	{
		if (source == null || source.Length == 0)
		{
			return Array.Empty<SummerRaceBattleSkillRuntimeState>();
		}
		SummerRaceBattleSkillRuntimeState[] array = new SummerRaceBattleSkillRuntimeState[source.Length];
		for (int i = 0; i < source.Length; i++)
		{
			array[i] = ((source[i] != null) ? source[i].Clone() : new SummerRaceBattleSkillRuntimeState());
		}
		return array;
	}

	private static SummerRaceEnemyHudRuntimeState[] CloneEnemyHudSlots(SummerRaceEnemyHudRuntimeState[] source)
	{
		if (source == null || source.Length == 0)
		{
			return Array.Empty<SummerRaceEnemyHudRuntimeState>();
		}
		SummerRaceEnemyHudRuntimeState[] array = new SummerRaceEnemyHudRuntimeState[source.Length];
		for (int i = 0; i < source.Length; i++)
		{
			array[i] = ((source[i] != null) ? source[i].Clone() : new SummerRaceEnemyHudRuntimeState());
		}
		return array;
	}
}
