using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT;

public static class CharacterPrecacheCollectUtility
{
	public static async UniTask CollectEnemyByMonsterPointIdAsync(int monsterPointId, PrecacheCollector collector, CancellationToken ct = default(CancellationToken), bool includeAI = false)
	{
		if (monsterPointId <= 0 || RuntimeConfigs.data?.enemySpawns == null || !RuntimeConfigs.data.enemySpawns.TryGetValue(monsterPointId, out var enemySpawn) || enemySpawn?.enemy == null)
		{
			return;
		}
		for (int i = 0; i < enemySpawn.enemy.Count; i++)
		{
			ct.ThrowIfCancellationRequested();
			Maybe maybe = enemySpawn.enemy[i];
			if (maybe != null && maybe.id > 0)
			{
				await CollectEnemyByEntityIdAsync(maybe.id, collector, ct, includeAI);
			}
		}
	}

	public static async UniTask CollectEnemyByEntityIdAsync(int entityId, PrecacheCollector collector, CancellationToken ct = default(CancellationToken), bool includeAI = false)
	{
		if (entityId <= 0 || RuntimeConfigs.data?.entityEnemyDatas == null || !RuntimeConfigs.data.entityEnemyDatas.TryGetValue(entityId, out var value) || string.IsNullOrEmpty(value.config))
		{
			return;
		}
		string configPath = value.config;
		AssetLoadHandle configHandle = AssetStationManager.BattleStation.LoadAsync<ConfigCharacter>(configPath);
		try
		{
			if (!configHandle.IsValid)
			{
				return;
			}
			await UniTask.WaitUntil(() => !configHandle.IsValid || configHandle.IsDone, PlayerLoopTiming.Update, ct);
			if (!configHandle.IsDone)
			{
				return;
			}
			object result = configHandle.Result;
			if (!(result is ConfigCharacter config))
			{
				return;
			}
			int skinId = 0;
			if (!EffectPrewarmManager.Enabled)
			{
				CollectConfigCharacter(configPath, config, entityId, skinId, collector, includeAI);
				return;
			}
			string battleMappingAssetId = CharacterSkinRuntimeUtility.GetBattleMappingAssetId(skinId);
			if (string.IsNullOrEmpty(battleMappingAssetId))
			{
				CollectConfigCharacter(configPath, config, entityId, skinId, collector, includeAI);
				return;
			}
			AssetLoadHandle mappingHandle = AssetStationManager.BattleStation.LoadAsync<ConfigSkinBattleMapping>(battleMappingAssetId);
			try
			{
				if (mappingHandle.IsValid)
				{
					await UniTask.WaitUntil(() => !mappingHandle.IsValid || mappingHandle.IsDone, PlayerLoopTiming.Update, ct);
				}
				ConfigSkinBattleMapping mapping = (mappingHandle.IsDone ? mappingHandle.As<ConfigSkinBattleMapping>() : null);
				CollectConfigCharacter(configPath, config, entityId, skinId, collector, includeAI, mapping);
			}
			finally
			{
				if (mappingHandle.IsValid)
				{
					AssetStationManager.BattleStation.Release(mappingHandle);
				}
			}
		}
		finally
		{
			if (configHandle.IsValid)
			{
				AssetStationManager.BattleStation.Release(configHandle);
			}
		}
	}

	public static void CollectConfigCharacter(string configPath, ConfigCharacter config, int characterId, int skinId, PrecacheCollector collector, bool includeAI = false, ConfigSkinBattleMapping mapping = null)
	{
		if (config == null)
		{
			return;
		}
		collector.AddConfigCharacter(configPath);
		string modelPath = CharacterSkinRuntimeUtility.GetModelPath(characterId, skinId, CharacterModelUsage.Battle);
		if (!string.IsNullOrEmpty(modelPath))
		{
			collector.AddModel(modelPath);
		}
		string battleMappingAssetId = CharacterSkinRuntimeUtility.GetBattleMappingAssetId(skinId);
		if (!string.IsNullOrEmpty(battleMappingAssetId))
		{
			collector.AddBattleMapping(battleMappingAssetId);
		}
		List<YooAssetReference> list = new List<YooAssetReference>();
		config.Precache(list);
		for (int i = 0; i < list.Count; i++)
		{
			collector.AddPreload(list[i]);
		}
		if (EffectPrewarmManager.Enabled)
		{
			config.CollectEffectPrewarm(collector.EffectPrewarm, mapping);
		}
		if (includeAI && config.AIConfig != null)
		{
			for (int j = 0; j < config.AIConfig.Length; j++)
			{
				collector.AddPreload(config.AIConfig[j].behaviorTreeAssetID);
			}
		}
	}

	public static int ResolveWorldMonsterPointId(WorldMonsterPointData data)
	{
		if (data == null || !data.HasMonster())
		{
			return 0;
		}
		int activeWorldId = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
		if (RuntimeConfigs.data?.worldMonsterPoints == null || !RuntimeConfigs.data.worldMonsterPoints.TryGetValue(activeWorldId, out var value) || value?.spawnPoint == null)
		{
			return 0;
		}
		for (int i = 0; i < value.spawnPoint.Count; i++)
		{
			ItemKv itemKv = value.spawnPoint[i];
			if (itemKv.id == data.uniqueIndex)
			{
				return itemKv.count;
			}
		}
		return 0;
	}
}
