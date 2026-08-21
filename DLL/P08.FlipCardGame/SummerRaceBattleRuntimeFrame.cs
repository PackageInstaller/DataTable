using System;
using UnityEngine;

public readonly struct SummerRaceBattleRuntimeFrame(string mode, int wave, int waveTotal, float timer, float countdownRemaining, float waveElapsed, int score, float hp, float maxHp, float energy, float maxEnergy, float playerLabelWorldX, float playerLabelWorldY, float playerLabelWorldZ, float playerLabelScreenOffsetY, float enemyHp, float enemyMaxHp, int enemyCount, string enemyId, string enemyName, SummerRaceEnemyHudRuntimeState[] enemyHudSlots, string enemyIntroText, string enemyOverclockBubbleText, int enemyOverclockBubbleToken, bool enemyAlive, bool enemyHeadOut, string phase, bool isBattleActive, bool isPaused, bool skillReady, string stageId, SummerRaceBattleSkillRuntimeState[] skills)
{
	public readonly string mode = mode ?? string.Empty;

	public readonly int wave = wave;

	public readonly int waveTotal = waveTotal;

	public readonly float timer = timer;

	public readonly float countdownRemaining = countdownRemaining;

	public readonly float waveElapsed = waveElapsed;

	public readonly int score = score;

	public readonly float hp = hp;

	public readonly float maxHp = maxHp;

	public readonly float energy = energy;

	public readonly float maxEnergy = maxEnergy;

	public readonly float playerLabelWorldX = playerLabelWorldX;

	public readonly float playerLabelWorldY = playerLabelWorldY;

	public readonly float playerLabelWorldZ = playerLabelWorldZ;

	public readonly float playerLabelScreenOffsetY = playerLabelScreenOffsetY;

	public readonly float enemyHp = enemyHp;

	public readonly float enemyMaxHp = enemyMaxHp;

	public readonly int enemyCount = Mathf.Max(1, enemyCount);

	public readonly string enemyId = enemyId ?? string.Empty;

	public readonly string enemyName = enemyName ?? string.Empty;

	public readonly SummerRaceEnemyHudRuntimeState[] enemyHudSlots = CloneEnemyHudSlots(enemyHudSlots);

	public readonly string enemyIntroText = enemyIntroText ?? string.Empty;

	public readonly string enemyOverclockBubbleText = enemyOverclockBubbleText ?? string.Empty;

	public readonly int enemyOverclockBubbleToken = Mathf.Max(0, enemyOverclockBubbleToken);

	public readonly bool enemyAlive = enemyAlive;

	public readonly bool enemyHeadOut = enemyHeadOut;

	public readonly string phase = phase ?? string.Empty;

	public readonly bool isBattleActive = isBattleActive;

	public readonly bool isPaused = isPaused;

	public readonly bool skillReady = skillReady;

	public readonly string stageId = stageId ?? string.Empty;

	public readonly SummerRaceBattleSkillRuntimeState[] skills = CloneSkills(skills);

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
