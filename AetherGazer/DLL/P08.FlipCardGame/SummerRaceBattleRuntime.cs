using System;

public sealed class SummerRaceBattleRuntime
{
	private SummerRaceBattleSnapshot currentSnapshot;

	private SummerRaceBattleSnapshot lastPublishedSnapshot;

	private SummerRaceBattleSettlement currentSettlement;

	private SummerRaceBattleStageResolved currentStageResolved;

	public SummerRaceBattleSnapshot UpdateSnapshot(in SummerRaceBattleRuntimeFrame frame)
	{
		currentSnapshot = new SummerRaceBattleSnapshot
		{
			mode = frame.mode,
			wave = frame.wave,
			waveTotal = frame.waveTotal,
			timer = frame.timer,
			countdownRemaining = frame.countdownRemaining,
			waveElapsed = frame.waveElapsed,
			score = frame.score,
			hp = frame.hp,
			maxHp = frame.maxHp,
			energy = frame.energy,
			maxEnergy = frame.maxEnergy,
			playerLabelWorldX = frame.playerLabelWorldX,
			playerLabelWorldY = frame.playerLabelWorldY,
			playerLabelWorldZ = frame.playerLabelWorldZ,
			playerLabelScreenOffsetY = frame.playerLabelScreenOffsetY,
			enemyHp = frame.enemyHp,
			enemyMaxHp = frame.enemyMaxHp,
			enemyCount = frame.enemyCount,
			enemyId = frame.enemyId,
			enemyName = frame.enemyName,
			enemyHudSlots = frame.enemyHudSlots,
			enemyIntroText = frame.enemyIntroText,
			enemyOverclockBubbleText = frame.enemyOverclockBubbleText,
			enemyOverclockBubbleToken = frame.enemyOverclockBubbleToken,
			enemyAlive = frame.enemyAlive,
			enemyHeadOut = frame.enemyHeadOut,
			phase = frame.phase,
			isBattleActive = frame.isBattleActive,
			isPaused = frame.isPaused,
			skillReady = frame.skillReady,
			stageId = frame.stageId,
			skills = frame.skills
		};
		return currentSnapshot.Clone();
	}

	public SummerRaceBattleSnapshot GetSnapshot()
	{
		if (currentSnapshot == null)
		{
			return null;
		}
		return currentSnapshot.Clone();
	}

	public bool TryGetSnapshotForPublish(bool force, out SummerRaceBattleSnapshot snapshot)
	{
		if (currentSnapshot == null)
		{
			snapshot = null;
			return false;
		}
		if (!force && SnapshotEquals(lastPublishedSnapshot, currentSnapshot))
		{
			snapshot = null;
			return false;
		}
		snapshot = currentSnapshot.Clone();
		return true;
	}

	public void MarkSnapshotPublished()
	{
		lastPublishedSnapshot = ((currentSnapshot != null) ? currentSnapshot.Clone() : null);
	}

	public SummerRaceBattleSettlement SetSettlement(SummerRaceBattleSettlement settlement)
	{
		if (settlement == null)
		{
			throw new ArgumentNullException("settlement");
		}
		currentSettlement = settlement.Clone();
		return currentSettlement.Clone();
	}

	public SummerRaceBattleSettlement GetSettlement()
	{
		if (currentSettlement == null)
		{
			return null;
		}
		return currentSettlement.Clone();
	}

	public void ClearSettlement()
	{
		currentSettlement = null;
	}

	public SummerRaceBattleStageResolved SetStageResolved(SummerRaceBattleStageResolved stageResolved)
	{
		if (stageResolved == null)
		{
			throw new ArgumentNullException("stageResolved");
		}
		currentStageResolved = stageResolved.Clone();
		return currentStageResolved.Clone();
	}

	public SummerRaceBattleStageResolved GetStageResolved()
	{
		if (currentStageResolved == null)
		{
			return null;
		}
		return currentStageResolved.Clone();
	}

	private static bool SnapshotEquals(SummerRaceBattleSnapshot a, SummerRaceBattleSnapshot b)
	{
		if (a == b)
		{
			return true;
		}
		if (a == null || b == null)
		{
			return false;
		}
		if (a.mode == b.mode && a.wave == b.wave && a.waveTotal == b.waveTotal && a.timer.Equals(b.timer) && a.countdownRemaining.Equals(b.countdownRemaining) && a.waveElapsed.Equals(b.waveElapsed) && a.score == b.score && a.hp.Equals(b.hp) && a.maxHp.Equals(b.maxHp) && a.energy.Equals(b.energy) && a.maxEnergy.Equals(b.maxEnergy) && a.playerLabelWorldX.Equals(b.playerLabelWorldX) && a.playerLabelWorldY.Equals(b.playerLabelWorldY) && a.playerLabelWorldZ.Equals(b.playerLabelWorldZ) && a.playerLabelScreenOffsetY.Equals(b.playerLabelScreenOffsetY) && a.enemyHp.Equals(b.enemyHp) && a.enemyMaxHp.Equals(b.enemyMaxHp) && a.enemyCount == b.enemyCount && a.enemyId == b.enemyId && a.enemyName == b.enemyName && EnemyHudSlotArrayEquals(a.enemyHudSlots, b.enemyHudSlots) && a.enemyIntroText == b.enemyIntroText && a.enemyOverclockBubbleText == b.enemyOverclockBubbleText && a.enemyOverclockBubbleToken == b.enemyOverclockBubbleToken && a.enemyAlive == b.enemyAlive && a.enemyHeadOut == b.enemyHeadOut && a.phase == b.phase && a.isBattleActive == b.isBattleActive && a.isPaused == b.isPaused && a.skillReady == b.skillReady && a.stageId == b.stageId)
		{
			return SkillArrayEquals(a.skills, b.skills);
		}
		return false;
	}

	private static bool EnemyHudSlotArrayEquals(SummerRaceEnemyHudRuntimeState[] a, SummerRaceEnemyHudRuntimeState[] b)
	{
		if (a == b)
		{
			return true;
		}
		if (a == null || b == null || a.Length != b.Length)
		{
			return false;
		}
		for (int i = 0; i < a.Length; i++)
		{
			if (!EnemyHudSlotEquals(a[i], b[i]))
			{
				return false;
			}
		}
		return true;
	}

	private static bool EnemyHudSlotEquals(SummerRaceEnemyHudRuntimeState a, SummerRaceEnemyHudRuntimeState b)
	{
		if (a == b)
		{
			return true;
		}
		if (a == null || b == null)
		{
			return false;
		}
		if (a.enemyId == b.enemyId && a.enemyName == b.enemyName && a.enemyHp.Equals(b.enemyHp) && a.enemyMaxHp.Equals(b.enemyMaxHp) && a.enemyAlive == b.enemyAlive)
		{
			return a.enemyHeadOut == b.enemyHeadOut;
		}
		return false;
	}

	private static bool SkillArrayEquals(SummerRaceBattleSkillRuntimeState[] a, SummerRaceBattleSkillRuntimeState[] b)
	{
		if (a == b)
		{
			return true;
		}
		if (a == null || b == null || a.Length != b.Length)
		{
			return false;
		}
		for (int i = 0; i < a.Length; i++)
		{
			if (!SkillEquals(a[i], b[i]))
			{
				return false;
			}
		}
		return true;
	}

	private static bool SkillEquals(SummerRaceBattleSkillRuntimeState a, SummerRaceBattleSkillRuntimeState b)
	{
		if (a == b)
		{
			return true;
		}
		if (a == null || b == null)
		{
			return false;
		}
		if (a.slotIndex == b.slotIndex && a.slotType == b.slotType && a.label == b.label && a.cooldownRemaining.Equals(b.cooldownRemaining) && a.cooldownTotal.Equals(b.cooldownTotal) && a.overloadRemaining.Equals(b.overloadRemaining) && a.overloadTotal.Equals(b.overloadTotal) && a.activeRemaining.Equals(b.activeRemaining) && a.activeTotal.Equals(b.activeTotal) && a.energyCost.Equals(b.energyCost) && a.overloadEnergyCost.Equals(b.overloadEnergyCost) && a.isReady == b.isReady && a.isOverloaded == b.isOverloaded && a.canUse == b.canUse && a.canOverload == b.canOverload)
		{
			return a.inputBlocked == b.inputBlocked;
		}
		return false;
	}
}
