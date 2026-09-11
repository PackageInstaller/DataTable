using System;
using System.Collections.Generic;

public static class SummerRaceActivityRuntimeResolver
{
	private sealed class StaticActivityConfigSourceLoader : ISummerRaceActivityConfigSourceLoader
	{
		private readonly SummerRaceActivityCatalogSourceData source;

		public StaticActivityConfigSourceLoader(SummerRaceActivityCatalogSourceData source)
		{
			this.source = source ?? throw new ArgumentNullException("source");
		}

		public SummerRaceActivityCatalogSourceData LoadSourceData(SummerRaceActivityLoadContext context)
		{
			return source;
		}
	}

	public static SummerRaceResolvedActivityRuntime Resolve(string activityId, SummerRaceBuildDatabaseSO buildDatabase, SummerRaceActivityStageSourceRecord[] stages, SummerRaceActivityMode mode, SummerRaceActivityLoadContext loadContext = null, SummerRaceActivityEnemySourceRecord[] explicitEnemySources = null, SummerRaceActivityWeaponSourceRecord[] explicitWeaponSources = null, SummerRaceActivityEquipSourceRecord[] explicitEquipSources = null)
	{
		if (buildDatabase == null)
		{
			throw new InvalidOperationException("Activity catalog unavailable: SummerRaceBuildDatabase missing.");
		}
		if (stages == null || stages.Length == 0)
		{
			throw new InvalidOperationException("Activity catalog unavailable: activityStageSource must be assigned explicitly.");
		}
		SummerRaceActivityCatalogSourceData summerRaceActivityCatalogSourceData = SummerRaceActivityCatalogSourceData.FromBuildDatabase(buildDatabase, activityId);
		SummerRaceActivityLoadContext summerRaceActivityLoadContext = loadContext ?? new SummerRaceActivityLoadContext();
		summerRaceActivityLoadContext.ActivityId = (string.IsNullOrEmpty(activityId) ? "tank" : activityId);
		SummerRaceActivityStageSourceRecord summerRaceActivityStageSourceRecord = ResolveSelectedStageSource(stages, mode, summerRaceActivityLoadContext.RequestedStageId);
		SummerRaceActivityChallengePoolSourceRecord[] array = ProjectChallengePools(summerRaceActivityStageSourceRecord);
		summerRaceActivityCatalogSourceData.Stages = new SummerRaceActivityStageSourceRecord[1] { summerRaceActivityStageSourceRecord };
		summerRaceActivityCatalogSourceData.ChallengePools = array;
		if (explicitEnemySources != null)
		{
			summerRaceActivityCatalogSourceData.Enemies = explicitEnemySources;
		}
		if (explicitWeaponSources != null && explicitWeaponSources.Length != 0)
		{
			summerRaceActivityCatalogSourceData.Weapons = explicitWeaponSources;
		}
		if (explicitEquipSources != null && explicitEquipSources.Length != 0)
		{
			summerRaceActivityCatalogSourceData.Equips = explicitEquipSources;
		}
		summerRaceActivityCatalogSourceData.Enemies = ResolveSelectedEnemySources(summerRaceActivityCatalogSourceData.Enemies, summerRaceActivityStageSourceRecord, array);
		SummerRaceActivityConfigCatalogProvider summerRaceActivityConfigCatalogProvider = new SummerRaceActivityConfigCatalogProvider(new SummerRaceActivityConfigCatalogLoader(new StaticActivityConfigSourceLoader(summerRaceActivityCatalogSourceData)), summerRaceActivityLoadContext);
		SummerRaceActivityRuntimeCatalog summerRaceActivityRuntimeCatalog = summerRaceActivityConfigCatalogProvider.Reload(summerRaceActivityLoadContext);
		SummerRaceActivityStageContract summerRaceActivityStageContract = ResolveRequestedStage(summerRaceActivityRuntimeCatalog, mode, summerRaceActivityLoadContext.RequestedStageId);
		if (summerRaceActivityStageContract == null)
		{
			throw new InvalidOperationException("Activity catalog unavailable: requested stage '" + summerRaceActivityLoadContext.RequestedStageId + "' could not be resolved.");
		}
		SummerRaceActivityChallengePoolContract pool = null;
		if (mode == SummerRaceActivityMode.Challenge)
		{
			if (string.IsNullOrWhiteSpace(summerRaceActivityStageContract.ChallengePoolId))
			{
				throw new InvalidOperationException("Challenge mode requires an explicit challenge pool binding on the active stage.");
			}
			if (!summerRaceActivityRuntimeCatalog.TryGetChallengePool(summerRaceActivityStageContract.ChallengePoolId, out pool) || pool == null)
			{
				throw new InvalidOperationException("Challenge mode requires projected challenge pool '" + summerRaceActivityStageContract.ChallengePoolId + "'.");
			}
		}
		return new SummerRaceResolvedActivityRuntime
		{
			Provider = summerRaceActivityConfigCatalogProvider,
			Catalog = summerRaceActivityRuntimeCatalog,
			ActiveStage = summerRaceActivityStageContract,
			ActiveChallengePool = pool
		};
	}

	private static SummerRaceActivityStageSourceRecord ResolveSelectedStageSource(SummerRaceActivityStageSourceRecord[] stages, SummerRaceActivityMode mode, string requestedStageId)
	{
		if (!string.IsNullOrWhiteSpace(requestedStageId))
		{
			foreach (SummerRaceActivityStageSourceRecord summerRaceActivityStageSourceRecord in stages)
			{
				if (summerRaceActivityStageSourceRecord != null && string.Equals(summerRaceActivityStageSourceRecord.Id, requestedStageId, StringComparison.Ordinal))
				{
					if (mode != SummerRaceActivityMode.Unknown && summerRaceActivityStageSourceRecord.Mode != mode)
					{
						throw new InvalidOperationException("Requested stage '" + requestedStageId + "' does not match fight mode " + mode.ToString() + ".");
					}
					return summerRaceActivityStageSourceRecord;
				}
			}
			throw new InvalidOperationException("Activity catalog unavailable: requested stage '" + requestedStageId + "' is not present in activityStageSource.");
		}
		throw new InvalidOperationException("Activity catalog unavailable: requested stageId must be provided explicitly.");
	}

	private static SummerRaceActivityChallengePoolSourceRecord[] ProjectChallengePools(SummerRaceActivityStageSourceRecord selectedStageSource)
	{
		if (selectedStageSource == null || selectedStageSource.Mode != SummerRaceActivityMode.Challenge)
		{
			return Array.Empty<SummerRaceActivityChallengePoolSourceRecord>();
		}
		if (string.IsNullOrWhiteSpace(selectedStageSource.ChallengePoolId))
		{
			throw new InvalidOperationException("Challenge mode requires stage.ChallengePoolId.");
		}
		SummerRaceActivityEnemySpawnSourceRecord[] array = selectedStageSource.ChallengeRandomPool ?? Array.Empty<SummerRaceActivityEnemySpawnSourceRecord>();
		if (array.Length == 0)
		{
			throw new InvalidOperationException("Challenge mode requires stage.ChallengeRandomPool on '" + selectedStageSource.Id + "'.");
		}
		return new SummerRaceActivityChallengePoolSourceRecord[1]
		{
			new SummerRaceActivityChallengePoolSourceRecord
			{
				Id = selectedStageSource.ChallengePoolId,
				DisplayName = selectedStageSource.DisplayName,
				Entries = array
			}
		};
	}

	private static SummerRaceActivityEnemySourceRecord[] ResolveSelectedEnemySources(SummerRaceActivityEnemySourceRecord[] enemySources, SummerRaceActivityStageSourceRecord selectedStageSource, SummerRaceActivityChallengePoolSourceRecord[] selectedChallengePools)
	{
		SummerRaceActivityEnemySourceRecord[] array = enemySources ?? Array.Empty<SummerRaceActivityEnemySourceRecord>();
		HashSet<string> hashSet = CollectReferencedEnemyIds(selectedStageSource, selectedChallengePools);
		if (hashSet.Count == 0)
		{
			return Array.Empty<SummerRaceActivityEnemySourceRecord>();
		}
		List<SummerRaceActivityEnemySourceRecord> list = new List<SummerRaceActivityEnemySourceRecord>(hashSet.Count);
		foreach (SummerRaceActivityEnemySourceRecord summerRaceActivityEnemySourceRecord in array)
		{
			if (summerRaceActivityEnemySourceRecord != null && !string.IsNullOrWhiteSpace(summerRaceActivityEnemySourceRecord.Id) && hashSet.Contains(summerRaceActivityEnemySourceRecord.Id))
			{
				list.Add(summerRaceActivityEnemySourceRecord);
			}
		}
		if (list.Count != hashSet.Count)
		{
			foreach (string item in hashSet)
			{
				bool flag = false;
				for (int j = 0; j < list.Count; j++)
				{
					if (string.Equals(list[j].Id, item, StringComparison.Ordinal))
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					throw new InvalidOperationException("Activity catalog unavailable: enemy '" + item + "' is referenced by the selected stage/pool but not present in activity enemy sources.");
				}
			}
		}
		return list.ToArray();
	}

	private static HashSet<string> CollectReferencedEnemyIds(SummerRaceActivityStageSourceRecord selectedStageSource, SummerRaceActivityChallengePoolSourceRecord[] selectedChallengePools)
	{
		HashSet<string> hashSet = new HashSet<string>(StringComparer.Ordinal);
		ValidateSelectedStageSource(selectedStageSource);
		SummerRaceActivityWaveSourceRecord[] array = ((selectedStageSource != null) ? (selectedStageSource.Waves ?? Array.Empty<SummerRaceActivityWaveSourceRecord>()) : Array.Empty<SummerRaceActivityWaveSourceRecord>());
		foreach (SummerRaceActivityWaveSourceRecord summerRaceActivityWaveSourceRecord in array)
		{
			if (summerRaceActivityWaveSourceRecord == null || summerRaceActivityWaveSourceRecord.Enemies == null)
			{
				continue;
			}
			for (int j = 0; j < summerRaceActivityWaveSourceRecord.Enemies.Length; j++)
			{
				SummerRaceActivityEnemySpawnSourceRecord summerRaceActivityEnemySpawnSourceRecord = summerRaceActivityWaveSourceRecord.Enemies[j];
				if (summerRaceActivityEnemySpawnSourceRecord != null && !string.IsNullOrWhiteSpace(summerRaceActivityEnemySpawnSourceRecord.EnemyId))
				{
					hashSet.Add(summerRaceActivityEnemySpawnSourceRecord.EnemyId);
				}
			}
		}
		SummerRaceActivityEnemySpawnSourceRecord[] array2 = ((selectedStageSource != null) ? (selectedStageSource.SurvivalRandomPool ?? Array.Empty<SummerRaceActivityEnemySpawnSourceRecord>()) : Array.Empty<SummerRaceActivityEnemySpawnSourceRecord>());
		foreach (SummerRaceActivityEnemySpawnSourceRecord summerRaceActivityEnemySpawnSourceRecord2 in array2)
		{
			if (summerRaceActivityEnemySpawnSourceRecord2 != null && !string.IsNullOrWhiteSpace(summerRaceActivityEnemySpawnSourceRecord2.EnemyId))
			{
				hashSet.Add(summerRaceActivityEnemySpawnSourceRecord2.EnemyId);
			}
		}
		SummerRaceActivityChallengePoolSourceRecord[] array3 = selectedChallengePools ?? Array.Empty<SummerRaceActivityChallengePoolSourceRecord>();
		foreach (SummerRaceActivityChallengePoolSourceRecord summerRaceActivityChallengePoolSourceRecord in array3)
		{
			if (summerRaceActivityChallengePoolSourceRecord == null || summerRaceActivityChallengePoolSourceRecord.Entries == null)
			{
				continue;
			}
			for (int m = 0; m < summerRaceActivityChallengePoolSourceRecord.Entries.Length; m++)
			{
				SummerRaceActivityEnemySpawnSourceRecord summerRaceActivityEnemySpawnSourceRecord3 = summerRaceActivityChallengePoolSourceRecord.Entries[m];
				if (summerRaceActivityEnemySpawnSourceRecord3 != null && !string.IsNullOrWhiteSpace(summerRaceActivityEnemySpawnSourceRecord3.EnemyId))
				{
					hashSet.Add(summerRaceActivityEnemySpawnSourceRecord3.EnemyId);
				}
			}
		}
		return hashSet;
	}

	private static void ValidateSelectedStageSource(SummerRaceActivityStageSourceRecord selectedStageSource)
	{
		if (selectedStageSource == null)
		{
			throw new InvalidOperationException("Activity catalog unavailable: selected stage source is null.");
		}
		SummerRaceActivityWaveSourceRecord[] array = selectedStageSource.Waves ?? Array.Empty<SummerRaceActivityWaveSourceRecord>();
		SummerRaceActivityEnemySpawnSourceRecord[] array2 = selectedStageSource.SurvivalRandomPool ?? Array.Empty<SummerRaceActivityEnemySpawnSourceRecord>();
		SummerRaceActivityEnemySpawnSourceRecord[] obj = selectedStageSource.ChallengeRandomPool ?? Array.Empty<SummerRaceActivityEnemySpawnSourceRecord>();
		bool flag = array.Length != 0;
		bool flag2 = array2.Length != 0;
		bool flag3 = obj.Length != 0;
		bool flag4 = !string.IsNullOrWhiteSpace(selectedStageSource.ChallengePoolId);
		switch (selectedStageSource.Mode)
		{
		case SummerRaceActivityMode.Tournament:
		case SummerRaceActivityMode.OneVsTwoPractice:
			if (!flag)
			{
				throw new InvalidOperationException("Stage '" + selectedStageSource.Id + "' requires Waves for mode " + selectedStageSource.Mode.ToString() + ".");
			}
			if (flag2 | flag3 | flag4)
			{
				throw new InvalidOperationException("Stage '" + selectedStageSource.Id + "' has incompatible random pool data for mode " + selectedStageSource.Mode.ToString() + ".");
			}
			break;
		case SummerRaceActivityMode.SurvivalPractice:
			if (!flag2)
			{
				throw new InvalidOperationException("Stage '" + selectedStageSource.Id + "' requires SurvivalRandomPool for survival mode.");
			}
			if (flag | flag3 | flag4)
			{
				throw new InvalidOperationException("Stage '" + selectedStageSource.Id + "' contains incompatible wave/challenge data for survival mode.");
			}
			break;
		case SummerRaceActivityMode.Challenge:
			if (!flag4 || !flag3)
			{
				throw new InvalidOperationException("Stage '" + selectedStageSource.Id + "' requires ChallengePoolId and ChallengeRandomPool for challenge mode.");
			}
			if (flag | flag2)
			{
				throw new InvalidOperationException("Stage '" + selectedStageSource.Id + "' contains incompatible wave/survival data for challenge mode.");
			}
			break;
		default:
			throw new InvalidOperationException("Stage '" + selectedStageSource.Id + "' has unsupported mode " + selectedStageSource.Mode.ToString() + ".");
		}
	}

	public static SummerRaceActivityStageContract ResolveRequestedStage(SummerRaceActivityRuntimeCatalog catalog, SummerRaceActivityMode mode, string requestedStageId)
	{
		if (!string.IsNullOrWhiteSpace(requestedStageId) && catalog != null && catalog.TryGetStage(requestedStageId, out var stage) && stage != null && stage.Mode == mode)
		{
			return stage;
		}
		return null;
	}
}
