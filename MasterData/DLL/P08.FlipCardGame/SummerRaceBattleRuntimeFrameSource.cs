using System;
using System.Collections.Generic;
using UnityEngine;

public readonly struct SummerRaceBattleRuntimeFrameSource(SummerRacePlayerController player, List<SummerRaceEnemy> aliveEnemies, string mode, int wave, int waveTotal, float timer, float countdownRemaining, float waveElapsed, int score, int enemyCount, string phase, bool isBattleActive, bool isPaused, string stageId, string enemyIntroText, string enemyOverclockBubbleText, int enemyOverclockBubbleToken, bool enemyHeadOut, SummerRaceEnemyHudRuntimeState[] enemyHudSlotsOverride = null)
{
	public readonly SummerRacePlayerController Player = player;

	public readonly List<SummerRaceEnemy> AliveEnemies = aliveEnemies;

	public readonly string Mode = mode ?? string.Empty;

	public readonly int Wave = wave;

	public readonly int WaveTotal = waveTotal;

	public readonly float Timer = timer;

	public readonly float CountdownRemaining = countdownRemaining;

	public readonly float WaveElapsed = waveElapsed;

	public readonly int Score = Mathf.Max(0, score);

	public readonly int EnemyCount = Mathf.Max(1, enemyCount);

	public readonly string Phase = phase ?? string.Empty;

	public readonly bool IsBattleActive = isBattleActive;

	public readonly bool IsPaused = isPaused;

	public readonly string StageId = stageId ?? string.Empty;

	public readonly string EnemyIntroText = enemyIntroText ?? string.Empty;

	public readonly string EnemyOverclockBubbleText = enemyOverclockBubbleText ?? string.Empty;

	public readonly int EnemyOverclockBubbleToken = Mathf.Max(0, enemyOverclockBubbleToken);

	public readonly bool EnemyHeadOut = enemyHeadOut;

	public readonly SummerRaceEnemyHudRuntimeState[] EnemyHudSlotsOverride = enemyHudSlotsOverride ?? Array.Empty<SummerRaceEnemyHudRuntimeState>();
}
