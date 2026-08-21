using System;
using System.Collections.Generic;
using UnityEngine;

public static class SummerRaceActivityConfigMapper
{
	public static SummerRaceActivityEnemySourceRecord[] BuildEnemySourcesFromDatabase(SummerRaceBuildDatabaseSO buildDatabase)
	{
		if (buildDatabase == null || buildDatabase.buildDefs == null || buildDatabase.buildDefs.Count == 0)
		{
			throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Build database is empty.");
		}
		List<SummerRaceActivityEnemySourceRecord> list = new List<SummerRaceActivityEnemySourceRecord>(buildDatabase.buildDefs.Count);
		for (int i = 0; i < buildDatabase.buildDefs.Count; i++)
		{
			SummerRaceBuildDefSO summerRaceBuildDefSO = buildDatabase.buildDefs[i];
			if (summerRaceBuildDefSO == null)
			{
				throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Null build definition at index " + i);
			}
			if (summerRaceBuildDefSO.body == null)
			{
				SummerRaceRuntimeLog.Warning("[SummerRaceActivityConfigMapper] Skip invalid build without body: " + summerRaceBuildDefSO.name);
				continue;
			}
			list.Add(new SummerRaceActivityEnemySourceRecord
			{
				Id = NormalizeId(summerRaceBuildDefSO.buildName, "build_" + i),
				DisplayName = ((!string.IsNullOrEmpty(summerRaceBuildDefSO.buildName)) ? summerRaceBuildDefSO.buildName : summerRaceBuildDefSO.name),
				BuildDefinition = summerRaceBuildDefSO,
				BodyType = summerRaceBuildDefSO.body.bodyType,
				Weapons = ToWeaponTypes(summerRaceBuildDefSO.weapons),
				Equips = ToEquipTypes(summerRaceBuildDefSO.equips),
				SignatureHint = ((!string.IsNullOrEmpty(summerRaceBuildDefSO.buildName)) ? summerRaceBuildDefSO.buildName : summerRaceBuildDefSO.name),
				BaseHp = Mathf.Max(1, Mathf.RoundToInt(summerRaceBuildDefSO.body.baseHp)),
				MoveSpeed = Mathf.Max(0.1f, summerRaceBuildDefSO.body.moveSpeed)
			});
		}
		return list.ToArray();
	}

	public static SummerRaceActivityRuntimeCatalog BuildCatalog(SummerRaceActivityCatalogSourceData source, SummerRaceActivityLoadContext context = null)
	{
		if (source == null)
		{
			throw new InvalidOperationException("[SummerRaceActivityConfigMapper] source is null.");
		}
		SummerRaceActivityLoadContext summerRaceActivityLoadContext = context ?? new SummerRaceActivityLoadContext();
		return new SummerRaceActivityRuntimeCatalog
		{
			ActivityId = ((!string.IsNullOrEmpty(source.ActivityId)) ? source.ActivityId : summerRaceActivityLoadContext.ActivityId),
			Stages = BuildStages(source.Stages),
			Enemies = BuildEnemies(source.Enemies),
			Bodies = BuildBodies(source.BuildDatabase, source.Bodies),
			Weapons = BuildWeapons(source.BuildDatabase, source.Weapons),
			Equips = BuildEquips(source.BuildDatabase, source.Equips),
			ChallengePools = BuildChallengePools(source.ChallengePools)
		};
	}

	private static SummerRaceActivityStageContract[] BuildStages(SummerRaceActivityStageSourceRecord[] rows)
	{
		if (rows == null || rows.Length == 0)
		{
			return Array.Empty<SummerRaceActivityStageContract>();
		}
		SummerRaceActivityStageContract[] array = new SummerRaceActivityStageContract[rows.Length];
		for (int i = 0; i < rows.Length; i++)
		{
			SummerRaceActivityStageSourceRecord summerRaceActivityStageSourceRecord = rows[i];
			if (summerRaceActivityStageSourceRecord == null)
			{
				throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Stage row is null at index " + i);
			}
			if (string.IsNullOrWhiteSpace(summerRaceActivityStageSourceRecord.Id))
			{
				throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Stage id is empty at index " + i);
			}
			array[i] = new SummerRaceActivityStageContract
			{
				Id = summerRaceActivityStageSourceRecord.Id,
				DisplayName = (summerRaceActivityStageSourceRecord.DisplayName ?? string.Empty),
				Mode = summerRaceActivityStageSourceRecord.Mode,
				SortOrder = summerRaceActivityStageSourceRecord.SortOrder,
				IsMainline = summerRaceActivityStageSourceRecord.IsMainline,
				UnlockStageId = (summerRaceActivityStageSourceRecord.UnlockStageId ?? string.Empty),
				FirstClearRewardGroupId = (summerRaceActivityStageSourceRecord.FirstClearRewardGroupId ?? string.Empty),
				StartStoryId = (summerRaceActivityStageSourceRecord.StartStoryId ?? string.Empty),
				EndStoryId = (summerRaceActivityStageSourceRecord.EndStoryId ?? string.Empty),
				MapName = (string.IsNullOrWhiteSpace(summerRaceActivityStageSourceRecord.MapName) ? string.Empty : summerRaceActivityStageSourceRecord.MapName.Trim()),
				ChallengePoolId = (summerRaceActivityStageSourceRecord.ChallengePoolId ?? string.Empty),
				RecommendedPower = Mathf.Max(0, summerRaceActivityStageSourceRecord.RecommendedPower),
				TimeLimitSeconds = Mathf.Max(0, summerRaceActivityStageSourceRecord.TimeLimitSeconds),
				SurvivalDurationSeconds = Mathf.Max(0, summerRaceActivityStageSourceRecord.SurvivalDurationSeconds),
				ChallengeWaveHealRatio = ValidateChallengeWaveHealRatio(summerRaceActivityStageSourceRecord.ChallengeWaveHealRatio, summerRaceActivityStageSourceRecord.Id),
				DamageToEnergyRatio = ValidateDamageToEnergyRatio(summerRaceActivityStageSourceRecord.DamageToEnergyRatio, summerRaceActivityStageSourceRecord.Id),
				EnergyRegenPerSecond = ValidateEnergyRegenPerSecond(summerRaceActivityStageSourceRecord.EnergyRegenPerSecond, summerRaceActivityStageSourceRecord.Id),
				MaxEnergy = ValidateMaxEnergy(summerRaceActivityStageSourceRecord.MaxEnergy, summerRaceActivityStageSourceRecord.Id),
				ChallengeWaveScoreTable = BuildWaveScoreTable(summerRaceActivityStageSourceRecord.ChallengeWaveScoreTable),
				SpecialDefeatRules = BuildSpecialDefeatRules(summerRaceActivityStageSourceRecord.SpecialDefeatRules),
				Waves = BuildWaves(summerRaceActivityStageSourceRecord.Waves),
				SurvivalRandomPool = BuildSpawns(summerRaceActivityStageSourceRecord.SurvivalRandomPool),
				ChallengeRandomPool = BuildSpawns(summerRaceActivityStageSourceRecord.ChallengeRandomPool)
			};
		}
		return array;
	}

	private static int[] BuildWaveScoreTable(int[] rows)
	{
		if (rows == null || rows.Length == 0)
		{
			return Array.Empty<int>();
		}
		List<int> list = new List<int>(rows.Length);
		for (int i = 0; i < rows.Length; i++)
		{
			int num = Mathf.Max(0, rows[i]);
			if (num > 0)
			{
				list.Add(num);
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<int>();
		}
		return list.ToArray();
	}

	private static SummerRaceActivitySpecialDefeatRuleContract[] BuildSpecialDefeatRules(SummerRaceActivitySpecialDefeatRuleSourceRecord[] rows)
	{
		if (rows == null || rows.Length == 0)
		{
			return Array.Empty<SummerRaceActivitySpecialDefeatRuleContract>();
		}
		List<SummerRaceActivitySpecialDefeatRuleContract> list = new List<SummerRaceActivitySpecialDefeatRuleContract>(rows.Length);
		foreach (SummerRaceActivitySpecialDefeatRuleSourceRecord summerRaceActivitySpecialDefeatRuleSourceRecord in rows)
		{
			if (summerRaceActivitySpecialDefeatRuleSourceRecord != null && !string.IsNullOrWhiteSpace(summerRaceActivitySpecialDefeatRuleSourceRecord.EnemyId))
			{
				list.Add(new SummerRaceActivitySpecialDefeatRuleContract
				{
					WaveIndex = Mathf.Max(1, summerRaceActivitySpecialDefeatRuleSourceRecord.WaveIndex),
					EnemyId = summerRaceActivitySpecialDefeatRuleSourceRecord.EnemyId.Trim(),
					GuideId = Mathf.Max(0, summerRaceActivitySpecialDefeatRuleSourceRecord.GuideId),
					FxId = (string.IsNullOrWhiteSpace(summerRaceActivitySpecialDefeatRuleSourceRecord.FxId) ? string.Empty : summerRaceActivitySpecialDefeatRuleSourceRecord.FxId.Trim())
				});
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<SummerRaceActivitySpecialDefeatRuleContract>();
		}
		return list.ToArray();
	}

	private static float ValidateChallengeWaveHealRatio(float ratio, string stageId)
	{
		if (!float.IsFinite(ratio) || ratio < 0f || ratio > 1f)
		{
			throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Stage '" + stageId + "' has invalid ChallengeWaveHealRatio: " + ratio + ".");
		}
		return ratio;
	}

	private static float ValidateDamageToEnergyRatio(float ratio, string stageId)
	{
		if (float.IsNaN(ratio))
		{
			return 0.25f;
		}
		if (!float.IsFinite(ratio) || ratio < 0f)
		{
			throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Stage '" + stageId + "' has invalid DamageToEnergyRatio: " + ratio + " (expected >= 0).");
		}
		return ratio;
	}

	private static float ValidateEnergyRegenPerSecond(float regenPerSecond, string stageId)
	{
		if (float.IsNaN(regenPerSecond))
		{
			return 1.8f;
		}
		if (!float.IsFinite(regenPerSecond) || regenPerSecond < 0f)
		{
			throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Stage '" + stageId + "' has invalid EnergyRegenPerSecond: " + regenPerSecond + " (expected >= 0).");
		}
		return regenPerSecond;
	}

	private static float ValidateMaxEnergy(float maxEnergy, string stageId)
	{
		if (float.IsNaN(maxEnergy))
		{
			return 10f;
		}
		if (!float.IsFinite(maxEnergy) || maxEnergy <= 0f)
		{
			throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Stage '" + stageId + "' has invalid MaxEnergy: " + maxEnergy + " (expected > 0).");
		}
		return maxEnergy;
	}

	private static SummerRaceActivityWaveContract[] BuildWaves(SummerRaceActivityWaveSourceRecord[] rows)
	{
		if (rows == null || rows.Length == 0)
		{
			return Array.Empty<SummerRaceActivityWaveContract>();
		}
		SummerRaceActivityWaveContract[] array = new SummerRaceActivityWaveContract[rows.Length];
		for (int i = 0; i < rows.Length; i++)
		{
			SummerRaceActivityWaveSourceRecord summerRaceActivityWaveSourceRecord = rows[i] ?? new SummerRaceActivityWaveSourceRecord();
			array[i] = new SummerRaceActivityWaveContract
			{
				WaveIndex = Mathf.Max(0, summerRaceActivityWaveSourceRecord.WaveIndex),
				SpawnIntervalSeconds = Mathf.Max(0f, summerRaceActivityWaveSourceRecord.SpawnIntervalSeconds),
				MaxAliveEnemies = Mathf.Max(0, summerRaceActivityWaveSourceRecord.MaxAliveEnemies),
				TimeLimitSeconds = Mathf.Max(0, summerRaceActivityWaveSourceRecord.TimeLimitSeconds),
				Enemies = BuildSpawns(summerRaceActivityWaveSourceRecord.Enemies)
			};
		}
		return array;
	}

	private static SummerRaceActivityEnemySpawnContract[] BuildSpawns(SummerRaceActivityEnemySpawnSourceRecord[] rows)
	{
		if (rows == null || rows.Length == 0)
		{
			return Array.Empty<SummerRaceActivityEnemySpawnContract>();
		}
		SummerRaceActivityEnemySpawnContract[] array = new SummerRaceActivityEnemySpawnContract[rows.Length];
		for (int i = 0; i < rows.Length; i++)
		{
			SummerRaceActivityEnemySpawnSourceRecord summerRaceActivityEnemySpawnSourceRecord = rows[i] ?? new SummerRaceActivityEnemySpawnSourceRecord();
			array[i] = new SummerRaceActivityEnemySpawnContract
			{
				EnemyId = (summerRaceActivityEnemySpawnSourceRecord.EnemyId ?? string.Empty),
				Count = Mathf.Max(1, summerRaceActivityEnemySpawnSourceRecord.Count),
				SpawnDelaySeconds = Mathf.Max(0f, summerRaceActivityEnemySpawnSourceRecord.SpawnDelaySeconds),
				Weight = Mathf.Max(1, summerRaceActivityEnemySpawnSourceRecord.Weight),
				MinWave = Mathf.Max(1, summerRaceActivityEnemySpawnSourceRecord.MinWave),
				MaxWave = Mathf.Max(Mathf.Max(1, summerRaceActivityEnemySpawnSourceRecord.MinWave), summerRaceActivityEnemySpawnSourceRecord.MaxWave)
			};
		}
		return array;
	}

	private static SummerRaceActivityEnemyContract[] BuildEnemies(SummerRaceActivityEnemySourceRecord[] rows)
	{
		if (rows == null || rows.Length == 0)
		{
			return Array.Empty<SummerRaceActivityEnemyContract>();
		}
		SummerRaceActivityEnemyContract[] array = new SummerRaceActivityEnemyContract[rows.Length];
		for (int i = 0; i < rows.Length; i++)
		{
			SummerRaceActivityEnemySourceRecord summerRaceActivityEnemySourceRecord = rows[i];
			if (summerRaceActivityEnemySourceRecord == null)
			{
				throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Enemy row is null at index " + i);
			}
			array[i] = BuildEnemy(summerRaceActivityEnemySourceRecord, i);
		}
		return array;
	}

	private static SummerRaceActivityEnemyContract BuildEnemy(SummerRaceActivityEnemySourceRecord row, int index)
	{
		SummerRaceActivityEnemyContract summerRaceActivityEnemyContract = new SummerRaceActivityEnemyContract();
		summerRaceActivityEnemyContract.Id = ((!string.IsNullOrEmpty(row.Id)) ? row.Id : NormalizeId(row.DisplayName, "enemy_" + index));
		summerRaceActivityEnemyContract.DisplayName = row.DisplayName ?? string.Empty;
		summerRaceActivityEnemyContract.PreferredArchetype = row.PreferredArchetype;
		summerRaceActivityEnemyContract.SignatureHint = row.SignatureHint ?? string.Empty;
		summerRaceActivityEnemyContract.BaseHp = Mathf.Max(1, row.BaseHp);
		summerRaceActivityEnemyContract.MoveSpeed = Mathf.Max(0.1f, row.MoveSpeed);
		summerRaceActivityEnemyContract.CollisionDamage = Mathf.Max(0, row.CollisionDamage);
		summerRaceActivityEnemyContract.DamageMultiplier = Mathf.Max(0f, row.DamageMultiplier);
		summerRaceActivityEnemyContract.BattleIntroText = row.BattleIntroText ?? string.Empty;
		summerRaceActivityEnemyContract.OverclockBubbleText = row.OverclockBubbleText ?? string.Empty;
		summerRaceActivityEnemyContract.DefeatEffect = row.DefeatEffect ?? string.Empty;
		summerRaceActivityEnemyContract.BodyIcon = row.BodyIcon ?? string.Empty;
		summerRaceActivityEnemyContract.LogoSkinName = row.LogoSkinName ?? string.Empty;
		if (row.BuildDefinition != null)
		{
			summerRaceActivityEnemyContract.DisplayName = ((!string.IsNullOrEmpty(summerRaceActivityEnemyContract.DisplayName)) ? summerRaceActivityEnemyContract.DisplayName : row.BuildDefinition.buildName);
			if (row.BuildDefinition.body == null)
			{
				throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Enemy build body is null: " + row.BuildDefinition.name);
			}
			summerRaceActivityEnemyContract.BodyType = MapBodyType(row.BuildDefinition.body.bodyType);
			summerRaceActivityEnemyContract.Weapons = ((row.BuildDefinition.weapons != null) ? ToWeaponKinds(row.BuildDefinition.weapons) : Array.Empty<WeaponKind>());
			summerRaceActivityEnemyContract.Equips = ((row.BuildDefinition.equips != null) ? ToEquipKinds(row.BuildDefinition.equips) : Array.Empty<EquipKind>());
			if (summerRaceActivityEnemyContract.Weapons.Length == 0 && row.Weapons != null && row.Weapons.Length != 0)
			{
				summerRaceActivityEnemyContract.Weapons = ToWeaponKinds(row.Weapons);
			}
			if (summerRaceActivityEnemyContract.Equips.Length == 0 && row.Equips != null && row.Equips.Length != 0)
			{
				summerRaceActivityEnemyContract.Equips = ToEquipKinds(row.Equips);
			}
			if (row.HasBodyOverride)
			{
				summerRaceActivityEnemyContract.BodyType = MapBodyType(row.BodyType);
			}
			if (row.HasWeaponOverride)
			{
				summerRaceActivityEnemyContract.Weapons = ToWeaponKinds(row.Weapons);
			}
			if (row.HasEquipOverride)
			{
				summerRaceActivityEnemyContract.Equips = ToEquipKinds(row.Equips);
			}
			if (!row.HasBodyOverride)
			{
				summerRaceActivityEnemyContract.BaseHp = Mathf.Max(summerRaceActivityEnemyContract.BaseHp, Mathf.RoundToInt(row.BuildDefinition.body.baseHp));
			}
			summerRaceActivityEnemyContract.MoveSpeed = Mathf.Max(summerRaceActivityEnemyContract.MoveSpeed, row.BuildDefinition.body.moveSpeed);
		}
		else
		{
			summerRaceActivityEnemyContract.BodyType = MapBodyType(row.BodyType);
			summerRaceActivityEnemyContract.Weapons = ToWeaponKinds(row.Weapons);
			summerRaceActivityEnemyContract.Equips = ToEquipKinds(row.Equips);
		}
		if (string.IsNullOrEmpty(summerRaceActivityEnemyContract.SignatureHint))
		{
			summerRaceActivityEnemyContract.SignatureHint = summerRaceActivityEnemyContract.DisplayName;
		}
		return summerRaceActivityEnemyContract;
	}

	private static SummerRaceActivityBodyContract[] BuildBodies(SummerRaceBuildDatabaseSO database, SummerRaceActivityBodySourceRecord[] rows)
	{
		Dictionary<SummerRaceBodyType, SummerRaceActivityBodyContract> dictionary = new Dictionary<SummerRaceBodyType, SummerRaceActivityBodyContract>();
		if (database != null && database.bodyDefs != null)
		{
			for (int i = 0; i < database.bodyDefs.Count; i++)
			{
				SummerRaceBodyDefSO summerRaceBodyDefSO = database.bodyDefs[i];
				if (!(summerRaceBodyDefSO == null))
				{
					SummerRaceBodyType key = MapBodyType(summerRaceBodyDefSO.bodyType);
					dictionary[key] = BuildBodyContractFromDef(summerRaceBodyDefSO, key);
				}
			}
		}
		if (rows != null)
		{
			foreach (SummerRaceActivityBodySourceRecord summerRaceActivityBodySourceRecord in rows)
			{
				if (summerRaceActivityBodySourceRecord != null)
				{
					SummerRaceBodyType summerRaceBodyType = MapBodyType(summerRaceActivityBodySourceRecord.BodyType);
					dictionary[summerRaceBodyType] = new SummerRaceActivityBodyContract
					{
						BodyType = summerRaceBodyType,
						DisplayName = (summerRaceActivityBodySourceRecord.DisplayName ?? string.Empty),
						CostCap = Mathf.Max(0, summerRaceActivityBodySourceRecord.CostCap),
						WeaponSlots = Mathf.Max(0, summerRaceActivityBodySourceRecord.WeaponSlots),
						EquipSlots = Mathf.Max(0, summerRaceActivityBodySourceRecord.EquipSlots),
						MaxHp = Mathf.Max(0f, summerRaceActivityBodySourceRecord.MaxHp),
						CruiseSpeed = Mathf.Max(0f, summerRaceActivityBodySourceRecord.CruiseSpeed),
						ForwardAcceleration = Mathf.Max(0f, summerRaceActivityBodySourceRecord.ForwardAcceleration),
						Mass = Mathf.Max(0f, summerRaceActivityBodySourceRecord.Mass),
						Drag = Mathf.Max(0f, summerRaceActivityBodySourceRecord.Drag),
						AngularDrag = Mathf.Max(0f, summerRaceActivityBodySourceRecord.AngularDrag),
						GravityScale = Mathf.Max(0f, summerRaceActivityBodySourceRecord.GravityScale),
						TractionGain = Mathf.Max(0f, summerRaceActivityBodySourceRecord.TractionGain),
						CollisionImpulseScale = Mathf.Max(0f, summerRaceActivityBodySourceRecord.CollisionImpulseScale),
						LaneSpring = Mathf.Max(0f, summerRaceActivityBodySourceRecord.LaneSpring),
						LaneDamping = Mathf.Max(0f, summerRaceActivityBodySourceRecord.LaneDamping),
						CenterOfMassOffset = summerRaceActivityBodySourceRecord.CenterOfMassOffset,
						BodyColor = summerRaceActivityBodySourceRecord.BodyColor,
						BodyScale = summerRaceActivityBodySourceRecord.BodyScale,
						ColliderPoints = CloneColliderPoints(summerRaceActivityBodySourceRecord.ColliderPoints),
						Wheels = BuildWheelContracts(summerRaceActivityBodySourceRecord.Wheels),
						MountPoints = BuildMountContracts(summerRaceActivityBodySourceRecord.MountPoints),
						ChassisPrefabPath = (summerRaceActivityBodySourceRecord.ChassisPrefabPath ?? string.Empty),
						UnlockStageId = (summerRaceActivityBodySourceRecord.UnlockStageId ?? string.Empty)
					};
				}
			}
		}
		return ToArray(dictionary);
	}

	private static SummerRaceActivityBodyContract BuildBodyContractFromDef(SummerRaceBodyDefSO def, SummerRaceBodyType key)
	{
		return new SummerRaceActivityBodyContract
		{
			BodyType = key,
			DisplayName = (def.displayName ?? string.Empty),
			CostCap = Mathf.Max(0, def.costCap),
			WeaponSlots = Mathf.Max(0, def.weaponSlots),
			EquipSlots = Mathf.Max(0, def.equipSlots),
			MaxHp = Mathf.Max(0f, def.baseHp),
			CruiseSpeed = Mathf.Max(0f, def.moveSpeed),
			ForwardAcceleration = Mathf.Max(0f, def.forwardAcceleration),
			Mass = Mathf.Max(0f, def.mass),
			Drag = Mathf.Max(0f, def.drag),
			AngularDrag = Mathf.Max(0f, def.angularDrag),
			GravityScale = Mathf.Max(0f, def.gravityScale),
			TractionGain = Mathf.Max(0f, def.tractionGain),
			CollisionImpulseScale = Mathf.Max(0f, def.collisionImpulseScale),
			LaneSpring = Mathf.Max(0f, def.laneSpring),
			LaneDamping = Mathf.Max(0f, def.laneDamping),
			CenterOfMassOffset = def.centerOfMassOffset,
			BodyColor = def.bodyColor,
			BodyScale = def.bodyScale,
			ColliderPoints = CloneColliderPoints(def.colliderPoints),
			Wheels = BuildWheelContracts(def.wheels),
			MountPoints = BuildMountContracts(def.mountPoints),
			ChassisPrefabPath = (def.chassisPrefabPath ?? string.Empty)
		};
	}

	private static Vector2[] CloneColliderPoints(IList<Vector2> points)
	{
		if (points == null || points.Count == 0)
		{
			return Array.Empty<Vector2>();
		}
		Vector2[] array = new Vector2[points.Count];
		for (int i = 0; i < points.Count; i++)
		{
			array[i] = points[i];
		}
		return array;
	}

	private static Vector2[] CloneColliderPoints(Vector2[] points)
	{
		if (points == null || points.Length == 0)
		{
			return Array.Empty<Vector2>();
		}
		Vector2[] array = new Vector2[points.Length];
		for (int i = 0; i < points.Length; i++)
		{
			array[i] = points[i];
		}
		return array;
	}

	private static SummerRaceActivityWheelContract[] BuildWheelContracts(IList<SummerRaceWheelDefConfig> wheels)
	{
		if (wheels == null || wheels.Count == 0)
		{
			return Array.Empty<SummerRaceActivityWheelContract>();
		}
		List<SummerRaceActivityWheelContract> list = new List<SummerRaceActivityWheelContract>(wheels.Count);
		for (int i = 0; i < wheels.Count; i++)
		{
			SummerRaceWheelDefConfig summerRaceWheelDefConfig = wheels[i];
			if (summerRaceWheelDefConfig != null)
			{
				list.Add(new SummerRaceActivityWheelContract
				{
					Name = (summerRaceWheelDefConfig.name ?? string.Empty),
					LocalPosition = summerRaceWheelDefConfig.localPosition,
					Radius = Mathf.Max(0.05f, summerRaceWheelDefConfig.radius)
				});
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<SummerRaceActivityWheelContract>();
		}
		return list.ToArray();
	}

	private static SummerRaceActivityWheelContract[] BuildWheelContracts(SummerRaceActivityWheelSourceRecord[] wheels)
	{
		if (wheels == null || wheels.Length == 0)
		{
			return Array.Empty<SummerRaceActivityWheelContract>();
		}
		SummerRaceActivityWheelContract[] array = new SummerRaceActivityWheelContract[wheels.Length];
		for (int i = 0; i < wheels.Length; i++)
		{
			SummerRaceActivityWheelSourceRecord summerRaceActivityWheelSourceRecord = wheels[i] ?? new SummerRaceActivityWheelSourceRecord();
			array[i] = new SummerRaceActivityWheelContract
			{
				Name = (summerRaceActivityWheelSourceRecord.Name ?? string.Empty),
				LocalPosition = summerRaceActivityWheelSourceRecord.LocalPosition,
				Radius = Mathf.Max(0.05f, summerRaceActivityWheelSourceRecord.Radius)
			};
		}
		return array;
	}

	private static SummerRaceActivityMountPointContract[] BuildMountContracts(IList<SummerRaceMountPointDefConfig> mounts)
	{
		if (mounts == null || mounts.Count == 0)
		{
			return Array.Empty<SummerRaceActivityMountPointContract>();
		}
		List<SummerRaceActivityMountPointContract> list = new List<SummerRaceActivityMountPointContract>(mounts.Count);
		for (int i = 0; i < mounts.Count; i++)
		{
			SummerRaceMountPointDefConfig summerRaceMountPointDefConfig = mounts[i];
			if (summerRaceMountPointDefConfig != null)
			{
				list.Add(new SummerRaceActivityMountPointContract
				{
					SlotType = ((summerRaceMountPointDefConfig.slotType == SummerRaceMountSlotTypeConfig.Equip) ? SummerRaceActivityMountSlotType.Equip : SummerRaceActivityMountSlotType.Weapon),
					SlotIndex = Mathf.Max(0, summerRaceMountPointDefConfig.slotIndex),
					LocalPosition = summerRaceMountPointDefConfig.localPosition,
					LocalAngle = summerRaceMountPointDefConfig.localAngle
				});
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<SummerRaceActivityMountPointContract>();
		}
		return list.ToArray();
	}

	private static SummerRaceActivityMountPointContract[] BuildMountContracts(SummerRaceActivityMountPointSourceRecord[] mounts)
	{
		if (mounts == null || mounts.Length == 0)
		{
			return Array.Empty<SummerRaceActivityMountPointContract>();
		}
		SummerRaceActivityMountPointContract[] array = new SummerRaceActivityMountPointContract[mounts.Length];
		for (int i = 0; i < mounts.Length; i++)
		{
			SummerRaceActivityMountPointSourceRecord summerRaceActivityMountPointSourceRecord = mounts[i] ?? new SummerRaceActivityMountPointSourceRecord();
			array[i] = new SummerRaceActivityMountPointContract
			{
				SlotType = summerRaceActivityMountPointSourceRecord.SlotType,
				SlotIndex = Mathf.Max(0, summerRaceActivityMountPointSourceRecord.SlotIndex),
				LocalPosition = summerRaceActivityMountPointSourceRecord.LocalPosition,
				LocalAngle = summerRaceActivityMountPointSourceRecord.LocalAngle
			};
		}
		return array;
	}

	private static SummerRaceActivityWeaponContract[] BuildWeapons(SummerRaceBuildDatabaseSO database, SummerRaceActivityWeaponSourceRecord[] rows)
	{
		Dictionary<WeaponKind, SummerRaceActivityWeaponContract> dictionary = new Dictionary<WeaponKind, SummerRaceActivityWeaponContract>();
		if (database != null && database.weaponDefs != null)
		{
			for (int i = 0; i < database.weaponDefs.Count; i++)
			{
				SummerRaceWeaponDefSO summerRaceWeaponDefSO = database.weaponDefs[i];
				if (!(summerRaceWeaponDefSO == null))
				{
					WeaponKind weaponKind = MapWeaponKind(summerRaceWeaponDefSO.weaponType);
					dictionary[weaponKind] = new SummerRaceActivityWeaponContract
					{
						WeaponKind = weaponKind,
						DisplayName = (summerRaceWeaponDefSO.displayName ?? string.Empty),
						Cost = Mathf.Max(0, summerRaceWeaponDefSO.cost),
						EnergyCost = Mathf.Max(0f, summerRaceWeaponDefSO.energyCost),
						CooldownSeconds = Mathf.Max(0f, summerRaceWeaponDefSO.cooldown),
						Damage = Mathf.Max(0, summerRaceWeaponDefSO.damage),
						FireInterval = Mathf.Max(0.0001f, summerRaceWeaponDefSO.modularFireInterval),
						HasBurnOverride = false,
						BurnDps = Mathf.Max(0, summerRaceWeaponDefSO.burnDps),
						BurnDuration = Mathf.Max(0f, summerRaceWeaponDefSO.burnDuration),
						HasProjectileCountOverride = true,
						ProjectileCount = Mathf.Max(1, summerRaceWeaponDefSO.projectileCount),
						HasProjectileSpreadOverride = true,
						ProjectileSpreadDegrees = Mathf.Max(0f, summerRaceWeaponDefSO.modularOptionalSpread),
						HasProjectileSpeedOverride = true,
						ProjectileSpeed = Mathf.Max(0f, summerRaceWeaponDefSO.projectileSpeed),
						HasRotatingSawSpinSpeedScaleOverride = (weaponKind == WeaponKind.RotatingSaw),
						RotatingSawSpinSpeedScale = ((weaponKind == WeaponKind.RotatingSaw) ? Mathf.Clamp01(summerRaceWeaponDefSO.rotatingSawSpinSpeedScale) : 1f)
					};
				}
			}
		}
		if (rows != null)
		{
			foreach (SummerRaceActivityWeaponSourceRecord summerRaceActivityWeaponSourceRecord in rows)
			{
				if (summerRaceActivityWeaponSourceRecord != null)
				{
					WeaponKind weaponKind2 = MapWeaponKind(summerRaceActivityWeaponSourceRecord.WeaponType);
					bool flag = SummerRaceWeaponRuntimeOverrideUtility.TryResolveScatterShellProjectileParams(summerRaceActivityWeaponSourceRecord.WeaponType, summerRaceActivityWeaponSourceRecord.EffectParams, out var projectileCount, out var spreadDegrees, out var projectileSpeed);
					bool flag2 = SummerRaceWeaponRuntimeOverrideUtility.TryResolveRotatingSawSpinSpeedScale(summerRaceActivityWeaponSourceRecord.WeaponType, summerRaceActivityWeaponSourceRecord.EffectParams, out var scale);
					dictionary[weaponKind2] = new SummerRaceActivityWeaponContract
					{
						WeaponKind = weaponKind2,
						DisplayName = (summerRaceActivityWeaponSourceRecord.DisplayName ?? string.Empty),
						Cost = Mathf.Max(0, summerRaceActivityWeaponSourceRecord.Cost),
						EnergyCost = Mathf.Max(0f, summerRaceActivityWeaponSourceRecord.EnergyCost),
						CooldownSeconds = Mathf.Max(0f, summerRaceActivityWeaponSourceRecord.CooldownSeconds),
						Damage = Mathf.Max(0, summerRaceActivityWeaponSourceRecord.Damage),
						FireInterval = Mathf.Max(0.0001f, summerRaceActivityWeaponSourceRecord.FireInterval),
						HasBurnOverride = summerRaceActivityWeaponSourceRecord.HasBurnOverride,
						BurnDps = Mathf.Max(0, summerRaceActivityWeaponSourceRecord.BurnDps),
						BurnDuration = Mathf.Max(0f, summerRaceActivityWeaponSourceRecord.BurnDuration),
						HasProjectileCountOverride = flag,
						ProjectileCount = (flag ? projectileCount : 0),
						HasProjectileSpreadOverride = flag,
						ProjectileSpreadDegrees = (flag ? spreadDegrees : 0f),
						HasProjectileSpeedOverride = flag,
						ProjectileSpeed = (flag ? projectileSpeed : 0f),
						HasRotatingSawSpinSpeedScaleOverride = flag2,
						RotatingSawSpinSpeedScale = (flag2 ? scale : 1f),
						UnlockStageId = (summerRaceActivityWeaponSourceRecord.UnlockStageId ?? string.Empty)
					};
				}
			}
		}
		return ToArray(dictionary);
	}

	private static SummerRaceActivityEquipContract[] BuildEquips(SummerRaceBuildDatabaseSO database, SummerRaceActivityEquipSourceRecord[] rows)
	{
		Dictionary<EquipKind, SummerRaceActivityEquipContract> dictionary = new Dictionary<EquipKind, SummerRaceActivityEquipContract>();
		if (database != null && database.equipDefs != null)
		{
			for (int i = 0; i < database.equipDefs.Count; i++)
			{
				SummerRaceEquipDefSO summerRaceEquipDefSO = database.equipDefs[i];
				if (!(summerRaceEquipDefSO == null))
				{
					EquipKind equipKind = MapEquipKind(summerRaceEquipDefSO.equipType);
					dictionary[equipKind] = new SummerRaceActivityEquipContract
					{
						EquipKind = equipKind,
						DisplayName = (summerRaceEquipDefSO.displayName ?? string.Empty),
						Cost = Mathf.Max(0, summerRaceEquipDefSO.cost),
						EnergyCost = Mathf.Max(0f, summerRaceEquipDefSO.energyCost),
						CooldownSeconds = Mathf.Max(0f, summerRaceEquipDefSO.cooldown)
					};
				}
			}
		}
		if (rows != null)
		{
			foreach (SummerRaceActivityEquipSourceRecord summerRaceActivityEquipSourceRecord in rows)
			{
				if (summerRaceActivityEquipSourceRecord != null)
				{
					EquipKind equipKind2 = MapEquipKind(summerRaceActivityEquipSourceRecord.EquipType);
					dictionary[equipKind2] = new SummerRaceActivityEquipContract
					{
						EquipKind = equipKind2,
						DisplayName = (summerRaceActivityEquipSourceRecord.DisplayName ?? string.Empty),
						Cost = Mathf.Max(0, summerRaceActivityEquipSourceRecord.Cost),
						EnergyCost = Mathf.Max(0f, summerRaceActivityEquipSourceRecord.EnergyCost),
						CooldownSeconds = Mathf.Max(0f, summerRaceActivityEquipSourceRecord.CooldownSeconds),
						UnlockStageId = (summerRaceActivityEquipSourceRecord.UnlockStageId ?? string.Empty)
					};
				}
			}
		}
		return ToArray(dictionary);
	}

	private static SummerRaceActivityChallengePoolContract[] BuildChallengePools(SummerRaceActivityChallengePoolSourceRecord[] rows)
	{
		if (rows == null || rows.Length == 0)
		{
			return Array.Empty<SummerRaceActivityChallengePoolContract>();
		}
		SummerRaceActivityChallengePoolContract[] array = new SummerRaceActivityChallengePoolContract[rows.Length];
		for (int i = 0; i < rows.Length; i++)
		{
			SummerRaceActivityChallengePoolSourceRecord summerRaceActivityChallengePoolSourceRecord = rows[i];
			if (summerRaceActivityChallengePoolSourceRecord == null)
			{
				throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Challenge pool row is null at index " + i);
			}
			if (string.IsNullOrWhiteSpace(summerRaceActivityChallengePoolSourceRecord.Id))
			{
				throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Challenge pool id is empty at index " + i);
			}
			array[i] = new SummerRaceActivityChallengePoolContract
			{
				Id = summerRaceActivityChallengePoolSourceRecord.Id,
				DisplayName = (summerRaceActivityChallengePoolSourceRecord.DisplayName ?? string.Empty),
				MinWave = Mathf.Max(1, summerRaceActivityChallengePoolSourceRecord.MinWave),
				MaxWave = Mathf.Max(Mathf.Max(1, summerRaceActivityChallengePoolSourceRecord.MinWave), summerRaceActivityChallengePoolSourceRecord.MaxWave),
				Entries = BuildSpawns(summerRaceActivityChallengePoolSourceRecord.Entries)
			};
		}
		return array;
	}

	private static SummerRaceWeaponTypeConfig[] ToWeaponTypes(List<SummerRaceWeaponDefSO> defs)
	{
		if (defs == null || defs.Count == 0)
		{
			return Array.Empty<SummerRaceWeaponTypeConfig>();
		}
		List<SummerRaceWeaponTypeConfig> list = new List<SummerRaceWeaponTypeConfig>(defs.Count);
		for (int i = 0; i < defs.Count; i++)
		{
			if (defs[i] != null)
			{
				list.Add(defs[i].weaponType);
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<SummerRaceWeaponTypeConfig>();
		}
		return list.ToArray();
	}

	private static SummerRaceEquipTypeConfig[] ToEquipTypes(List<SummerRaceEquipDefSO> defs)
	{
		if (defs == null || defs.Count == 0)
		{
			return Array.Empty<SummerRaceEquipTypeConfig>();
		}
		List<SummerRaceEquipTypeConfig> list = new List<SummerRaceEquipTypeConfig>(defs.Count);
		for (int i = 0; i < defs.Count; i++)
		{
			if (defs[i] != null)
			{
				list.Add(defs[i].equipType);
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<SummerRaceEquipTypeConfig>();
		}
		return list.ToArray();
	}

	private static WeaponKind[] ToWeaponKinds(SummerRaceWeaponTypeConfig[] values)
	{
		if (values == null || values.Length == 0)
		{
			return Array.Empty<WeaponKind>();
		}
		WeaponKind[] array = new WeaponKind[values.Length];
		for (int i = 0; i < values.Length; i++)
		{
			array[i] = MapWeaponKind(values[i]);
		}
		return array;
	}

	private static WeaponKind[] ToWeaponKinds(List<SummerRaceWeaponDefSO> defs)
	{
		if (defs == null || defs.Count == 0)
		{
			return Array.Empty<WeaponKind>();
		}
		List<WeaponKind> list = new List<WeaponKind>(defs.Count);
		for (int i = 0; i < defs.Count; i++)
		{
			if (defs[i] != null)
			{
				list.Add(MapWeaponKind(defs[i].weaponType));
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<WeaponKind>();
		}
		return list.ToArray();
	}

	private static EquipKind[] ToEquipKinds(SummerRaceEquipTypeConfig[] values)
	{
		if (values == null || values.Length == 0)
		{
			return Array.Empty<EquipKind>();
		}
		EquipKind[] array = new EquipKind[values.Length];
		for (int i = 0; i < values.Length; i++)
		{
			array[i] = MapEquipKind(values[i]);
		}
		return array;
	}

	private static EquipKind[] ToEquipKinds(List<SummerRaceEquipDefSO> defs)
	{
		if (defs == null || defs.Count == 0)
		{
			return Array.Empty<EquipKind>();
		}
		List<EquipKind> list = new List<EquipKind>(defs.Count);
		for (int i = 0; i < defs.Count; i++)
		{
			if (defs[i] != null)
			{
				list.Add(MapEquipKind(defs[i].equipType));
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<EquipKind>();
		}
		return list.ToArray();
	}

	private static SummerRaceBodyType MapBodyType(SummerRaceBodyTypeConfig value)
	{
		return value switch
		{
			SummerRaceBodyTypeConfig.Light => SummerRaceBodyType.Light, 
			SummerRaceBodyTypeConfig.Medium => SummerRaceBodyType.Medium, 
			SummerRaceBodyTypeConfig.Heavy => SummerRaceBodyType.Heavy, 
			_ => throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Unsupported body type: " + value), 
		};
	}

	private static WeaponKind MapWeaponKind(SummerRaceWeaponTypeConfig value)
	{
		return value switch
		{
			SummerRaceWeaponTypeConfig.RocketLauncher => WeaponKind.RocketLauncher, 
			SummerRaceWeaponTypeConfig.Boomerang => WeaponKind.Boomerang, 
			SummerRaceWeaponTypeConfig.ScatterShell => WeaponKind.ScatterShell, 
			SummerRaceWeaponTypeConfig.LaserCannon => WeaponKind.LaserCannon, 
			SummerRaceWeaponTypeConfig.Drill => WeaponKind.Drill, 
			SummerRaceWeaponTypeConfig.RotatingSaw => WeaponKind.RotatingSaw, 
			SummerRaceWeaponTypeConfig.Shovel => WeaponKind.Shovel, 
			SummerRaceWeaponTypeConfig.MachineGun => WeaponKind.MachineGun, 
			_ => throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Unsupported weapon type: " + value), 
		};
	}

	private static EquipKind MapEquipKind(SummerRaceEquipTypeConfig value)
	{
		return value switch
		{
			SummerRaceEquipTypeConfig.BoxingGlove => EquipKind.BoxingGlove, 
			SummerRaceEquipTypeConfig.ElectricNet => EquipKind.ElectricNet, 
			SummerRaceEquipTypeConfig.Hook => EquipKind.Hook, 
			SummerRaceEquipTypeConfig.ShieldGenerator => EquipKind.ShieldGenerator, 
			SummerRaceEquipTypeConfig.Thruster => EquipKind.Thruster, 
			_ => throw new InvalidOperationException("[SummerRaceActivityConfigMapper] Unsupported equip type: " + value), 
		};
	}

	private static T[] ToArray<TKey, T>(Dictionary<TKey, T> map)
	{
		if (map.Count == 0)
		{
			return Array.Empty<T>();
		}
		T[] array = new T[map.Count];
		int num = 0;
		foreach (KeyValuePair<TKey, T> item in map)
		{
			array[num++] = item.Value;
		}
		return array;
	}

	private static string NormalizeId(string value, string fallback)
	{
		string text = (string.IsNullOrWhiteSpace(value) ? fallback : value.Trim());
		char[] array = new char[text.Length];
		int num = 0;
		for (int i = 0; i < text.Length; i++)
		{
			char c = char.ToLowerInvariant(text[i]);
			if ((c >= 'a' && c <= 'z') || (c >= '0' && c <= '9'))
			{
				array[num++] = c;
			}
			else if (num > 0 && array[num - 1] != '_')
			{
				array[num++] = '_';
			}
		}
		if (num == 0)
		{
			return fallback;
		}
		if (array[num - 1] == '_')
		{
			num--;
		}
		return new string(array, 0, num);
	}
}
