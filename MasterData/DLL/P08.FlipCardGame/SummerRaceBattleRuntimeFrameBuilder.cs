using System;
using System.Collections.Generic;
using UnityEngine;

public static class SummerRaceBattleRuntimeFrameBuilder
{
	public static SummerRaceBattleRuntimeFrame Build(in SummerRaceBattleRuntimeFrameSource source)
	{
		float hp = 0f;
		float maxHp = 0f;
		float energy = 0f;
		float maxEnergy = 0f;
		Vector3 vector = Vector3.zero;
		float playerLabelScreenOffsetY = 150f;
		if (source.Player != null)
		{
			hp = SanitizeHudStat(source.Player.CurrentHP);
			maxHp = SanitizeHudStat(source.Player.MaxHP);
			energy = SanitizeHudStat(source.Player.CurrentEnergy);
			maxEnergy = SanitizeHudStat(source.Player.MaxEnergy);
			vector = ResolvePlayerBattleAdminLabelWorldPosition(source.Player);
			playerLabelScreenOffsetY = source.Player.ResolvePlayerBattleAdminLabelScreenOffsetY();
		}
		SummerRaceEnemy summerRaceEnemy = ResolveActiveEnemyForHud(source.AliveEnemies);
		float enemyHp = 0f;
		float enemyMaxHp = 0f;
		string enemyId = string.Empty;
		string enemyName = string.Empty;
		string enemyIntroText = source.EnemyIntroText ?? string.Empty;
		bool enemyAlive = false;
		SummerRaceEnemyHudRuntimeState[] enemyHudSlots = ((source.EnemyHudSlotsOverride != null && source.EnemyHudSlotsOverride.Length != 0) ? source.EnemyHudSlotsOverride : BuildEnemyHudSlots(source.AliveEnemies));
		if (summerRaceEnemy != null)
		{
			enemyHp = SanitizeHudStat(summerRaceEnemy.CurrentHP);
			enemyMaxHp = SanitizeHudStat(summerRaceEnemy.MaxHP);
			enemyId = summerRaceEnemy.CatalogEnemyId ?? string.Empty;
			enemyName = summerRaceEnemy.DisplayName ?? string.Empty;
			enemyAlive = summerRaceEnemy.IsCombatAlive || summerRaceEnemy.IsNormalDefeatPending;
		}
		SummerRaceBattleSkillRuntimeState[] skills = BuildSkillRuntimeStates(in source);
		bool skillReady = HasAnyInteractableSkill(skills);
		return new SummerRaceBattleRuntimeFrame(source.Mode, source.Wave, source.WaveTotal, source.Timer, source.CountdownRemaining, source.WaveElapsed, source.Score, hp, maxHp, energy, maxEnergy, vector.x, vector.y, vector.z, playerLabelScreenOffsetY, enemyHp, enemyMaxHp, source.EnemyCount, enemyId, enemyName, enemyHudSlots, enemyIntroText, source.EnemyOverclockBubbleText, source.EnemyOverclockBubbleToken, enemyAlive, source.EnemyHeadOut, source.Phase, source.IsBattleActive, source.IsPaused, skillReady, source.StageId, skills);
	}

	private static SummerRaceEnemy ResolveActiveEnemyForHud(List<SummerRaceEnemy> aliveEnemies)
	{
		if (aliveEnemies == null)
		{
			return null;
		}
		SummerRaceEnemy summerRaceEnemy = null;
		SummerRaceEnemy summerRaceEnemy2 = null;
		SummerRaceEnemy summerRaceEnemy3 = null;
		for (int num = aliveEnemies.Count - 1; num >= 0; num--)
		{
			SummerRaceEnemy summerRaceEnemy4 = aliveEnemies[num];
			if (summerRaceEnemy4 == null)
			{
				aliveEnemies.RemoveAt(num);
			}
			else if (summerRaceEnemy4.IsNormalDefeatPending && summerRaceEnemy == null)
			{
				summerRaceEnemy = summerRaceEnemy4;
			}
			else
			{
				if (summerRaceEnemy4.IsCombatAlive && summerRaceEnemy2 == null)
				{
					summerRaceEnemy2 = summerRaceEnemy4;
				}
				if (summerRaceEnemy3 == null)
				{
					summerRaceEnemy3 = summerRaceEnemy4;
				}
			}
		}
		if (summerRaceEnemy != null)
		{
			return summerRaceEnemy;
		}
		if (summerRaceEnemy2 != null)
		{
			return summerRaceEnemy2;
		}
		return summerRaceEnemy3;
	}

	private static Vector3 ResolvePlayerBattleAdminLabelWorldPosition(SummerRacePlayerController player)
	{
		if (player == null)
		{
			return Vector3.zero;
		}
		Collider2D[] componentsInChildren = player.GetComponentsInChildren<Collider2D>(includeInactive: true);
		bool flag = false;
		Bounds bounds = default(Bounds);
		foreach (Collider2D collider2D in componentsInChildren)
		{
			if (!(collider2D == null) && collider2D.enabled && !collider2D.isTrigger)
			{
				if (!flag)
				{
					bounds = collider2D.bounds;
					flag = true;
				}
				else
				{
					bounds.Encapsulate(collider2D.bounds);
				}
			}
		}
		if (flag)
		{
			return new Vector3(bounds.center.x, bounds.max.y, player.transform.position.z);
		}
		return player.transform.position;
	}

	private static SummerRaceEnemyHudRuntimeState[] BuildEnemyHudSlots(List<SummerRaceEnemy> aliveEnemies)
	{
		if (aliveEnemies == null || aliveEnemies.Count == 0)
		{
			return Array.Empty<SummerRaceEnemyHudRuntimeState>();
		}
		List<SummerRaceEnemyHudRuntimeState> list = new List<SummerRaceEnemyHudRuntimeState>(aliveEnemies.Count);
		for (int i = 0; i < aliveEnemies.Count; i++)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemies[i];
			if (!(summerRaceEnemy == null))
			{
				bool flag = summerRaceEnemy.IsCombatAlive || summerRaceEnemy.IsNormalDefeatPending;
				if (flag)
				{
					list.Add(new SummerRaceEnemyHudRuntimeState
					{
						enemyId = (summerRaceEnemy.CatalogEnemyId ?? string.Empty),
						enemyName = (summerRaceEnemy.DisplayName ?? string.Empty),
						enemyHp = SanitizeHudStat(summerRaceEnemy.CurrentHP),
						enemyMaxHp = SanitizeHudStat(summerRaceEnemy.MaxHP),
						enemyAlive = flag,
						enemyHeadOut = summerRaceEnemy.IsNormalDefeatPending
					});
				}
			}
		}
		return list.ToArray();
	}

	private static SummerRaceBattleSkillRuntimeState[] BuildSkillRuntimeStates(in SummerRaceBattleRuntimeFrameSource source)
	{
		if (source.Player == null)
		{
			return Array.Empty<SummerRaceBattleSkillRuntimeState>();
		}
		int num = Mathf.Max(0, source.Player.WeaponSlotCount);
		int num2 = Mathf.Max(0, source.Player.EquipSlotCount);
		bool isSkillInputBlocked = source.Player.IsSkillInputBlocked;
		List<SummerRaceBattleSkillRuntimeState> list = new List<SummerRaceBattleSkillRuntimeState>(num + num2);
		for (int i = 0; i < num; i++)
		{
			float cooldownRemaining = SanitizeHudStat(source.Player.GetWeaponSlotCooldownRemain(i));
			float cooldownTotal = SanitizeHudStat(source.Player.GetWeaponSlotCooldownDuration(i));
			float overloadRemaining = SanitizeHudStat(source.Player.GetWeaponSlotOverloadRemaining(i));
			float activeRemaining = SanitizeHudStat(source.Player.GetWeaponSlotOverloadActiveRemaining(i));
			bool flag = source.Player.IsWeaponSlotReady(i);
			bool isOverloaded = source.Player.IsWeaponSlotOverloaded(i);
			list.Add(new SummerRaceBattleSkillRuntimeState
			{
				slotIndex = i,
				slotType = "weapon",
				label = (source.Player.GetWeaponSlotLabel(i) ?? string.Empty),
				cooldownRemaining = cooldownRemaining,
				cooldownTotal = cooldownTotal,
				overloadRemaining = overloadRemaining,
				overloadTotal = 3f,
				activeRemaining = activeRemaining,
				activeTotal = 3f,
				energyCost = SanitizeHudStat(source.Player.GetWeaponSlotEnergyCost(i)),
				overloadEnergyCost = SanitizeHudStat(source.Player.GetWeaponSlotEnergyCost(i)),
				isReady = flag,
				isOverloaded = isOverloaded,
				canUse = (flag && source.IsBattleActive && !source.IsPaused),
				canOverload = source.Player.CanTriggerWeaponOverload(i),
				inputBlocked = isSkillInputBlocked
			});
		}
		for (int j = 0; j < num2; j++)
		{
			float cooldownRemaining2 = SanitizeHudStat(source.Player.GetEquipSlotCooldownRemain(j));
			list.Add(new SummerRaceBattleSkillRuntimeState
			{
				slotIndex = j,
				slotType = "equip",
				label = (source.Player.GetEquipSlotLabel(j) ?? string.Empty),
				cooldownRemaining = cooldownRemaining2,
				cooldownTotal = SanitizeHudStat(source.Player.GetEquipSlotCooldownDuration(j)),
				overloadRemaining = 0f,
				overloadTotal = 0f,
				activeRemaining = SanitizeHudStat(source.Player.GetEquipSlotActiveRemain(j)),
				activeTotal = SanitizeHudStat(source.Player.GetEquipSlotActiveDuration(j)),
				energyCost = SanitizeHudStat(source.Player.GetEquipSlotEnergyCost(j)),
				overloadEnergyCost = 0f,
				isReady = source.Player.IsEquipSlotReady(j),
				isOverloaded = false,
				canUse = (source.IsBattleActive && !source.IsPaused && source.Player.CanPresentEquipSlotAsReady(j)),
				canOverload = false,
				inputBlocked = isSkillInputBlocked
			});
		}
		return list.ToArray();
	}

	private static bool HasAnyInteractableSkill(SummerRaceBattleSkillRuntimeState[] skills)
	{
		if (skills == null)
		{
			return false;
		}
		foreach (SummerRaceBattleSkillRuntimeState summerRaceBattleSkillRuntimeState in skills)
		{
			if (summerRaceBattleSkillRuntimeState != null && (summerRaceBattleSkillRuntimeState.canUse || summerRaceBattleSkillRuntimeState.canOverload))
			{
				return true;
			}
		}
		return false;
	}

	private static float SanitizeHudStat(float value)
	{
		if (float.IsNaN(value) || float.IsInfinity(value))
		{
			return 0f;
		}
		return Mathf.Max(0f, value);
	}
}
