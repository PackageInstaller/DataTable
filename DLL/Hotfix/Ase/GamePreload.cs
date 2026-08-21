#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using Newtonsoft.Json;
using NodeCanvas.Framework;
using UnityEngine;

namespace Ase;

public class GamePreload
{
	private LoadingProgressBar _progress;

	private const string PreloadProgressBarKey = "PreloadAssets";

	public GamePreload(LoadingProgressBar progressBar)
	{
		_progress = progressBar;
	}

	public async Task<bool> CheckGameAsset(List<PeripheryHeroData> heroModelList, int copyId, List<int> bossIds, Dictionary<int, int> battlePropList, int levelId, PreloadBattleData preloadBattleData, bool isSingle = true, Dictionary<int, int> monsterCountDic = null)
	{
		string path = AssetUtility.GetConfigAsset("PreloadConfig", LoadType.Bytes);
		TextAsset textAsset = await GameEntry.Resource.LoadAssetAsync<TextAsset>(path);
		if (textAsset == null)
		{
			Toast.ShowError("没有找到战斗预加载配置'PreloadConfig'.");
			return false;
		}
		PreloadConfig preloadConfig;
		try
		{
			preloadConfig = JsonConvert.DeserializeObject<PreloadConfig>(textAsset.text);
			GameEntry.Resource.UnloadAsset(path);
		}
		catch (Exception)
		{
			GameEntry.Resource.UnloadAsset(path);
			throw new Exception("序列化预加载配置'PreloadConfig'出错. 请确认资源格式.");
		}
		StatisticsPreloadList(heroModelList, copyId, bossIds, battlePropList, levelId, preloadConfig, preloadBattleData, isSingle, monsterCountDic);
		_progress?.AddLoadingData("PreloadAssets", preloadBattleData.HeroSkinList.Count + preloadBattleData.MonsterIdDic.Count + preloadBattleData.NpcList.Count + preloadBattleData.EffectIdList.Count + preloadBattleData.ParadoxIdDic.Count + preloadBattleData.MapItemIdList.Count + preloadBattleData.CacheWarningIndicatorNumber + preloadBattleData.BattleEntityList.Count + preloadBattleData.HeroTimelineList.Count);
		return true;
	}

	private void StatisticsPreloadList(List<PeripheryHeroData> heroModelList, int copyId, List<int> bossIds, Dictionary<int, int> battlePropList, int levelId, PreloadConfig preloadConfig, PreloadBattleData preloadBattleData, bool isSingle, Dictionary<int, int> monsterCountDic = null)
	{
		foreach (PeripheryHeroData heroModel in heroModelList)
		{
			if (heroModel.IsSkin)
			{
				preloadBattleData.AddSkin(heroModel.SkinConfigId);
			}
			else
			{
				preloadBattleData.AddHero(heroModel.Id);
			}
			CollectHeroRuntimeExtraEffects(heroModel, preloadBattleData);
		}
		foreach (int heroSkin in preloadBattleData.HeroSkinList)
		{
			DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(heroSkin);
			DRHeroSkin dataRow2 = GameEntry.DataTable.GetDataRow<DRHeroSkin>(heroSkin);
			if (dataRow != null)
			{
				if (dataRow.SummonedID.Count != dataRow.SummonedMaxNumber.Count)
				{
					for (int i = 0; i < dataRow.SummonedID.Count; i++)
					{
						preloadBattleData.AddSummoned(dataRow.SummonedID[i], 2);
					}
				}
				else
				{
					for (int j = 0; j < dataRow.SummonedID.Count; j++)
					{
						preloadBattleData.AddSummoned(dataRow.SummonedID[j], dataRow.SummonedMaxNumber[j]);
					}
				}
			}
			else if (dataRow2 != null)
			{
				for (int k = 0; k < dataRow2.SummonedConfigID.Count; k++)
				{
					preloadBattleData.AddSummoned(dataRow2.SummonedConfigID[k], 3);
				}
			}
		}
		foreach (KeyValuePair<int, int> battleProp in battlePropList)
		{
			preloadBattleData.AddBattleProp(battleProp.Key, battleProp.Value);
		}
		for (int l = 0; l < bossIds.Count; l++)
		{
			DRMonsterAttr dataRow3 = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(bossIds[l]);
			DRMonster dataRow4 = GameEntry.DataTable.GetDataRow<DRMonster>(dataRow3?.MonsterType ?? 0);
			if (dataRow3 == null || dataRow4 == null)
			{
				continue;
			}
			int num = ((monsterCountDic != null && monsterCountDic.TryGetValue(dataRow3.Id, out var value)) ? value : (dataRow4.IsBoss ? 1 : GetMinionMaxNumber(copyId, levelId, dataRow3.MonsterType)));
			preloadBattleData.AddMonster(dataRow3.Id, num);
			if (dataRow3.SummonMonster.Count == dataRow3.SummonedMaxNumber.Count)
			{
				for (int m = 0; m < dataRow3.SummonMonster.Count; m++)
				{
					preloadBattleData.AddMonster(dataRow3.SummonMonster[m], dataRow3.SummonedMaxNumber[m] * num, monsterCountDic != null);
				}
				continue;
			}
			foreach (int item in dataRow3.SummonMonster)
			{
				Log.Error($"预加载数量默认3个，召唤物ID：{item} ");
				preloadBattleData.AddMonster(item, 3 * num, monsterCountDic != null);
			}
		}
		CollectAllIndicatorRingEffects(preloadBattleData);
		foreach (int heroSkin2 in preloadBattleData.HeroSkinList)
		{
			preloadConfig.collectEffectIdDic.TryGetValue(heroSkin2, out var value2);
			if (value2 != null && value2.Count > 0)
			{
				foreach (int item2 in value2)
				{
					preloadBattleData.AddEffect(item2);
				}
			}
			preloadConfig.collectBattleEntityDic.TryGetValue(heroSkin2, out var value3);
			if (value3 != null && value3.Count > 0)
			{
				foreach (string item3 in value3)
				{
					preloadBattleData.AddBattleEntityView(item3);
				}
			}
			preloadConfig.collectTimelineDic.TryGetValue(heroSkin2, out var value4);
			if (value4 != null && value4.Count > 0)
			{
				foreach (string item4 in value4)
				{
					preloadBattleData.AddHeroTimelineView(item4);
				}
			}
			preloadConfig.collectBehaviourTreeIdDic.TryGetValue(heroSkin2, out var value5);
			if (value5 != null && value5.Count > 0)
			{
				foreach (int item5 in value5)
				{
					DRBattleEntityConfig dataRow5 = GameEntry.DataTable.GetDataRow<DRBattleEntityConfig>(item5);
					if (dataRow5 != null)
					{
						preloadBattleData.AddParadox(item5, dataRow5.Count, add: true);
					}
					else
					{
						preloadBattleData.AddParadox(item5, 1);
					}
				}
			}
			preloadConfig.collectSummonedEntityDic.TryGetValue(heroSkin2, out var value6);
			if (value6 == null || value6.Count <= 0)
			{
				continue;
			}
			foreach (string item6 in value6)
			{
				preloadBattleData.AddBattleEntityView(item6);
			}
		}
		foreach (KeyValuePair<int, int> item7 in preloadBattleData.SummonedIdDic)
		{
			CollectHitBoxEffects(GameEntry.DataTable.GetDataRow<DRSummonedEntityConfig>(item7.Key)?.HitBoxId ?? 0, preloadBattleData);
			preloadConfig.collectEffectIdDic.TryGetValue(item7.Key, out var value7);
			if (value7 != null && value7.Count > 0)
			{
				foreach (int item8 in value7)
				{
					preloadBattleData.AddEffect(item8);
				}
			}
			preloadConfig.collectBehaviourTreeIdDic.TryGetValue(item7.Key, out var value8);
			if (value8 == null || value8.Count <= 0)
			{
				continue;
			}
			foreach (int item9 in value8)
			{
				preloadBattleData.AddParadox(item9, item7.Value);
			}
		}
		foreach (KeyValuePair<int, int> item10 in preloadBattleData.MonsterIdDic)
		{
			DRMonsterAttr dataRow6 = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(item10.Key);
			CollectHitBoxEffects(GameEntry.DataTable.GetDataRow<DRMonster>(dataRow6?.MonsterType ?? 0)?.HitBoxId ?? 0, preloadBattleData);
			preloadConfig.collectEffectIdDic.TryGetValue(item10.Key, out var value9);
			if (value9 != null && value9.Count > 0)
			{
				foreach (int item11 in value9)
				{
					preloadBattleData.AddEffect(item11);
				}
			}
			preloadConfig.collectBattleEntityDic.TryGetValue(item10.Key, out var value10);
			if (value10 != null && value10.Count > 0)
			{
				foreach (string item12 in value10)
				{
					preloadBattleData.AddBattleEntityView(item12);
				}
			}
			preloadConfig.collectBehaviourTreeIdDic.TryGetValue(item10.Key, out var value11);
			if (value11 == null || value11.Count <= 0)
			{
				continue;
			}
			foreach (int item13 in value11)
			{
				preloadBattleData.AddParadox(item13, item10.Value, monsterCountDic != null);
			}
		}
		if (preloadConfig.collectCopyMapItemDic.TryGetValue(copyId, out var value12))
		{
			int key = 0;
			int key2 = 1;
			if (isSingle)
			{
				if (value12.ContainsKey(key))
				{
					foreach (int item14 in value12[key])
					{
						preloadBattleData.AddMapItem(item14);
					}
				}
			}
			else if (value12.ContainsKey(key2))
			{
				foreach (int item15 in value12[key2])
				{
					preloadBattleData.AddMapItem(item15);
				}
			}
		}
		foreach (KeyValuePair<int, int> battleProp2 in preloadBattleData.BattlePropList)
		{
			preloadConfig.collectEffectIdDic.TryGetValue(battleProp2.Key, out var value13);
			if (value13 != null && value13.Count > 0)
			{
				foreach (int item16 in value13)
				{
					preloadBattleData.AddEffect(item16);
				}
			}
			preloadConfig.collectBehaviourTreeIdDic.TryGetValue(battleProp2.Key, out var value14);
			if (value14 == null || value14.Count <= 0)
			{
				continue;
			}
			foreach (int item17 in value14)
			{
				preloadBattleData.AddParadox(item17, battleProp2.Value, add: true);
			}
		}
		foreach (int mapItemId in preloadBattleData.MapItemIdList)
		{
			preloadConfig.collectEffectIdDic.TryGetValue(mapItemId, out var value15);
			if (value15 == null || value15.Count <= 0)
			{
				continue;
			}
			foreach (int item18 in value15)
			{
				preloadBattleData.AddEffect(item18);
			}
		}
		if (preloadConfig.collectCopyTreeDic.TryGetValue(copyId, out var value16))
		{
			for (int n = 0; n < value16.Count; n++)
			{
				preloadBattleData.AddParadox(value16[n], 1);
			}
		}
		foreach (int mapItemId2 in preloadBattleData.MapItemIdList)
		{
			preloadConfig.collectBehaviourTreeIdDic.TryGetValue(mapItemId2, out var value17);
			if (value17 == null || value17.Count <= 0)
			{
				continue;
			}
			foreach (int item19 in value17)
			{
				int mapItemMaxNumber = GetMapItemMaxNumber(copyId, levelId, mapItemId2);
				preloadBattleData.AddParadox(item19, mapItemMaxNumber);
			}
		}
		foreach (int npc in preloadBattleData.NpcList)
		{
			preloadConfig.collectBehaviourTreeIdDic.TryGetValue(npc, out var value18);
			if (value18 == null || value18.Count <= 0)
			{
				continue;
			}
			foreach (int item20 in value18)
			{
				preloadBattleData.AddParadox(item20, 1);
			}
		}
		preloadBattleData.CacheWarningIndicatorNumber = GameEntry.DataTable.GetAllDataRow<DRWarningIndicator>().Length;
	}

	public async Task<bool> LoadGameBackAsset(PreloadBattleData battleData)
	{
		try
		{
			await CacheParadoxTree(battleData);
		}
		catch (Exception ex)
		{
			Log.Error("预加载异常 ： " + ex.Message);
			return false;
		}
		return true;
	}

	public async Task<bool> LoadGameAsset(PreloadBattleData battleData)
	{
		try
		{
			await PreloadGameUsedRes(battleData);
		}
		catch (Exception ex)
		{
			Log.Error("预加载异常 ： " + ex.Message);
			return false;
		}
		return true;
	}

	private async System.Threading.Tasks.Task PreloadGameUsedRes(PreloadBattleData preloadBattleData)
	{
		System.Threading.Tasks.Task task = CacheHeroView(preloadBattleData);
		System.Threading.Tasks.Task task2 = CacheMonsterView(preloadBattleData);
		System.Threading.Tasks.Task task3 = CacheBattleEffect(preloadBattleData);
		System.Threading.Tasks.Task task4 = CacheParadoxTree(preloadBattleData);
		System.Threading.Tasks.Task task5 = CacheMapItemView(preloadBattleData);
		System.Threading.Tasks.Task task6 = CacheWarningIndicator(preloadBattleData);
		System.Threading.Tasks.Task task7 = CacheNpc(preloadBattleData);
		System.Threading.Tasks.Task task8 = CacheBattleEntity(preloadBattleData);
		System.Threading.Tasks.Task task10 = CacheHeroTimeline(preloadBattleData);
		await task;
		await task2;
		await task3;
		await task4;
		await task5;
		await task6;
		await task7;
		await task8;
		await task10;
	}

	private async System.Threading.Tasks.Task CacheHeroView(PreloadBattleData preloadBattleData)
	{
		foreach (int heroId in preloadBattleData.HeroSkinList)
		{
			DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(heroId);
			string AssetPath = ((dataRow == null) ? GameEntry.DataTable.GetDataRow<DRHeroSkin>(heroId)?.AssetPath : dataRow.AssetPath);
			if (string.IsNullOrEmpty(AssetPath))
			{
				Log.Error($"根据预加载配置没有找到Id = {heroId}的英雄配置.");
				_progress?.UpdateLoadingData("PreloadAssets");
				continue;
			}
			if (preloadBattleData.ContainsHeroView(AssetPath))
			{
				_progress?.UpdateLoadingData("PreloadAssets");
				continue;
			}
			GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetEntityAsset(AssetPath));
			if (gameObject == null)
			{
				Log.Error($"根据预加载配置没有找到Id = {heroId}的英雄资源. 资源路径 = {AssetPath}");
				_progress?.UpdateLoadingData("PreloadAssets");
			}
			else
			{
				_progress?.UpdateLoadingData("PreloadAssets");
				preloadBattleData.AddHeroView(AssetPath, gameObject);
			}
		}
	}

	private async System.Threading.Tasks.Task CacheHeroSummonedView(PreloadBattleData preloadBattleData)
	{
		foreach (int heroId in preloadBattleData.HeroIdList)
		{
			DRHeroSkin dRHeroSkin = GameEntry.DataTable.GetDataRow<DRHeroSkin>(heroId);
			if (dRHeroSkin == null)
			{
				continue;
			}
			for (int i = 0; i < dRHeroSkin.SummonedSkinPath.Count; i++)
			{
				string AssetPath = dRHeroSkin.SummonedSkinPath[i];
				if (string.IsNullOrEmpty(AssetPath))
				{
					Log.Error($"根据预加载配置没有找到Id = {dRHeroSkin.SummonedSkinID[i]}的召唤物配置.");
					_progress?.UpdateLoadingData("PreloadAssets");
					continue;
				}
				if (preloadBattleData.ContainsHeroSummonedView(AssetPath))
				{
					_progress?.UpdateLoadingData("PreloadAssets");
					continue;
				}
				GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetEntityAsset(AssetPath));
				if (gameObject == null)
				{
					Log.Error($"根据预加载配置没有找到Id = {dRHeroSkin.SummonedSkinID[i]}的英雄资源. 资源路径 = {AssetPath}");
					_progress?.UpdateLoadingData("PreloadAssets");
				}
				else
				{
					_progress?.UpdateLoadingData("PreloadAssets");
					preloadBattleData.AddHeroSummonedView(AssetPath, gameObject);
				}
			}
		}
	}

	private async System.Threading.Tasks.Task CacheMonsterView(PreloadBattleData preloadBattleData)
	{
		foreach (KeyValuePair<int, int> monsterId in preloadBattleData.MonsterIdDic)
		{
			DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(monsterId.Key);
			DRMonster drMonster = GameEntry.DataTable.GetDataRow<DRMonster>(dataRow?.MonsterType ?? 0);
			if (drMonster == null)
			{
				Log.Error($"根据预加载配置没有找到Id = {monsterId}的怪物配置.");
				_progress?.UpdateLoadingData("PreloadAssets");
				continue;
			}
			if (preloadBattleData.ContainsMonsterView(drMonster.AssetPath))
			{
				_progress?.UpdateLoadingData("PreloadAssets");
				continue;
			}
			GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetEntityAsset(drMonster.AssetPath));
			if (gameObject == null)
			{
				Log.Error($"根据预加载配置没有找到Id = {monsterId} 资源路径 = {drMonster.AssetPath}的怪物资源.");
				_progress?.UpdateLoadingData("PreloadAssets");
			}
			else
			{
				preloadBattleData.AddMonsterView(drMonster.AssetPath, gameObject);
				_progress?.UpdateLoadingData("PreloadAssets");
			}
		}
	}

	private async System.Threading.Tasks.Task CacheBattleEffect(PreloadBattleData preloadBattleData)
	{
		foreach (int effectId in preloadBattleData.EffectIdList)
		{
			DREffect dataRow = GameEntry.DataTable.GetDataRow<DREffect>(effectId);
			if (dataRow == null)
			{
				_progress?.UpdateLoadingData("PreloadAssets");
				continue;
			}
			string path = GetEffectAssetPathByLevel(dataRow);
			if (preloadBattleData.ContainsEffectView(path))
			{
				_progress?.UpdateLoadingData("PreloadAssets");
				continue;
			}
			GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetEntityAsset(path));
			if (gameObject == null)
			{
				_progress?.UpdateLoadingData("PreloadAssets");
				Log.Error($"根据预加载配置没有找到Id = {effectId} 资源路径 = {path}的特效资源.");
			}
			else
			{
				preloadBattleData.AddEffectView(path, gameObject);
				_progress?.UpdateLoadingData("PreloadAssets");
			}
		}
	}

	private async System.Threading.Tasks.Task CacheParadoxTree(PreloadBattleData preloadBattleData)
	{
		foreach (KeyValuePair<int, int> data in preloadBattleData.ParadoxIdDic)
		{
			_ = data.Value;
			_ = 1;
			DRParadox drParadox = GameEntry.DataTable.GetDataRow<DRParadox>(data.Key);
			if (drParadox == null)
			{
				Log.Error($"根据预加载配置未找到 ID = {data}的行为树配置配置");
				_progress?.UpdateLoadingData("PreloadAssets");
				continue;
			}
			if (preloadBattleData.ContainsParadoxView(drParadox.Id))
			{
				_progress?.UpdateLoadingData("PreloadAssets");
				continue;
			}
			GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetParadoxAsset(drParadox.AssetPath), "Paradoxs");
			if (gameObject == null)
			{
				Log.Error($"根据预加载配置没有找到Id = {data} 资源路径 = {drParadox.AssetPath}的行为树资源.");
				_progress?.UpdateLoadingData("PreloadAssets");
				continue;
			}
			GraphOwner component = gameObject.GetComponent<GraphOwner>();
			if (component == null)
			{
				Log.Error("初始化行为树失败:" + gameObject.name + " 缺少BehaviourTreeOwner脚本!");
			}
			else
			{
				component.Initialize(data.Value);
			}
			preloadBattleData.AddParadoxView(drParadox.Id, gameObject);
			_progress?.UpdateLoadingData("PreloadAssets");
		}
	}

	private async System.Threading.Tasks.Task CacheMapItemView(PreloadBattleData preloadBattleData)
	{
		foreach (int mapItemId in preloadBattleData.MapItemIdList)
		{
			DRMapItem drMapItem = GameEntry.DataTable.GetDataRow<DRMapItem>(mapItemId);
			if (drMapItem == null)
			{
				Log.Error($"根据预加载配置未找到 ID = {mapItemId}的地图交互物配置");
				_progress?.UpdateLoadingData("PreloadAssets");
				continue;
			}
			if (preloadBattleData.ContainsMapItemView(drMapItem.AssetPath))
			{
				_progress?.UpdateLoadingData("PreloadAssets");
				continue;
			}
			GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetEntityAsset(drMapItem.AssetPath));
			if (gameObject == null)
			{
				Log.Error($"根据预加载配置没有找到Id = {mapItemId} 资源路径 = {drMapItem.AssetPath}的交互物资源.");
				_progress?.UpdateLoadingData("PreloadAssets");
			}
			else
			{
				preloadBattleData.AddMapItemView(drMapItem.AssetPath, gameObject);
				_progress?.UpdateLoadingData("PreloadAssets");
			}
		}
	}

	private async System.Threading.Tasks.Task CacheWarningIndicator(PreloadBattleData preloadBattleData)
	{
		DRWarningIndicator[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRWarningIndicator>();
		DRWarningIndicator[] array = allDataRow;
		foreach (DRWarningIndicator drWarningIndicator in array)
		{
			GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetEntityAsset(drWarningIndicator.AssetsPath));
			if (gameObject == null)
			{
				Log.Error($"根据预加载配置没有找到Id = {drWarningIndicator.Id} 资源路径 = {drWarningIndicator.AssetsPath}的预警圈资源.");
				_progress?.UpdateLoadingData("PreloadAssets");
			}
			else
			{
				preloadBattleData.AddWarningIndicator(drWarningIndicator.AssetsPath, gameObject);
				_progress?.UpdateLoadingData("PreloadAssets");
			}
		}
	}

	private async System.Threading.Tasks.Task CacheNpc(PreloadBattleData preloadBattleData)
	{
		foreach (int npc in preloadBattleData.NpcList)
		{
			DRNPC drnpc = GameEntry.DataTable.GetDataRow<DRNPC>(npc);
			if (drnpc == null)
			{
				Log.Error($"根据预加载配置没有找到id ={npc} 的Npc配置!");
				_progress?.UpdateLoadingData("PreloadAssets");
				continue;
			}
			GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetEntityAsset(drnpc.AssetPath));
			if (gameObject == null)
			{
				Log.Error($"根据预加载配置没有找到Id = {drnpc.Id} 资源路径 = {drnpc.AssetPath}的预警圈资源.");
				_progress?.UpdateLoadingData("PreloadAssets");
			}
			else if (preloadBattleData.ContainsNpcView(drnpc.AssetPath))
			{
				_progress?.UpdateLoadingData("PreloadAssets");
			}
			else
			{
				preloadBattleData.AddWarningIndicator(drnpc.AssetPath, gameObject);
				_progress?.UpdateLoadingData("PreloadAssets");
			}
		}
	}

	private async System.Threading.Tasks.Task CacheBattleEntity(PreloadBattleData preloadBattleData)
	{
		foreach (string path in preloadBattleData.BattleEntityList)
		{
			GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetEntityAsset(path));
			if (gameObject == null)
			{
				Log.Error("根据预加载配置资源路径 = " + path + "的战斗实体资源资源.");
				_progress?.UpdateLoadingData("PreloadAssets");
			}
			else
			{
				preloadBattleData.AddBattleEntityView(path, gameObject);
				_progress?.UpdateLoadingData("PreloadAssets");
			}
		}
	}

	private async System.Threading.Tasks.Task CacheHeroTimeline(PreloadBattleData preloadBattleData)
	{
		foreach (string path in preloadBattleData.HeroTimelineList)
		{
			GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetTimeLineAsset(path));
			if (gameObject == null)
			{
				Log.Error("根据预加载配置资源路径 = " + path + "的战斗实体资源资源.");
				_progress?.UpdateLoadingData("PreloadAssets");
			}
			else
			{
				preloadBattleData.AddHeroTimelineView(path, gameObject);
				_progress?.UpdateLoadingData("PreloadAssets");
			}
		}
	}

	private int GetMinionMaxNumber(int copyId, int levelId, int monsterConfigId)
	{
		if (copyId == 0)
		{
			return GameEntry.DataTable.GetDataRow((DRMonsterPreloadConfig data) => data.MonsterId == monsterConfigId && data.LevelId == levelId)?.LevelMaxNumber ?? 3;
		}
		return GameEntry.DataTable.GetDataRow((DRMonsterPreloadConfig data) => data.MonsterId == monsterConfigId && data.CopyId == copyId)?.CopyMaxNumber ?? 3;
	}

	private int GetMapItemMaxNumber(int copyId, int levelId, int mapItemId)
	{
		if (copyId == 0)
		{
			return GameEntry.DataTable.GetDataRow((DRMapItemPreloadConfig data) => data.MapItemId == mapItemId && data.LevelId == levelId)?.LevelMaxNumber ?? 3;
		}
		return GameEntry.DataTable.GetDataRow((DRMapItemPreloadConfig data) => data.MapItemId == mapItemId && data.CopyId == copyId)?.CopyMaxNumber ?? 3;
	}

	private void CollectHeroRuntimeExtraEffects(PeripheryHeroData heroModel, PreloadBattleData preloadBattleData)
	{
		if (heroModel != null)
		{
			CollectIndicatorRingEffect(heroModel.Indicator, preloadBattleData);
			DRHero dRHero = null;
			if (heroModel.IsSkin)
			{
				DRHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRHeroSkin>(heroModel.SkinConfigId);
				dRHero = GameEntry.DataTable.GetDataRow<DRHero>(dataRow?.HeroConfigId ?? 0);
			}
			else
			{
				dRHero = GameEntry.DataTable.GetDataRow<DRHero>(heroModel.Id);
			}
			CollectHitBoxEffects(dRHero?.HitBoxId ?? 0, preloadBattleData);
		}
	}

	private void CollectIndicatorRingEffect(int indicatorRingId, PreloadBattleData preloadBattleData)
	{
		if (indicatorRingId > 0)
		{
			DRIndicatorRing dataRow = GameEntry.DataTable.GetDataRow<DRIndicatorRing>(indicatorRingId);
			if (dataRow != null)
			{
				preloadBattleData.AddEffect(dataRow.ResPath);
			}
		}
	}

	private void CollectAllIndicatorRingEffects(PreloadBattleData preloadBattleData)
	{
		DRIndicatorRing[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRIndicatorRing>();
		if (allDataRow == null)
		{
			return;
		}
		DRIndicatorRing[] array = allDataRow;
		foreach (DRIndicatorRing dRIndicatorRing in array)
		{
			if (dRIndicatorRing != null)
			{
				preloadBattleData.AddEffect(dRIndicatorRing.ResPath);
			}
		}
	}

	private void CollectHitBoxEffects(int hitBoxId, PreloadBattleData preloadBattleData)
	{
		if (hitBoxId <= 0)
		{
			return;
		}
		DRHitBox dataRow = GameEntry.DataTable.GetDataRow<DRHitBox>(hitBoxId);
		if (dataRow?.KeysEffect == null)
		{
			return;
		}
		foreach (int item in dataRow.KeysEffect)
		{
			CollectGeneralHitEffects(item, preloadBattleData);
		}
	}

	private void CollectGeneralHitEffects(int generalHitId, PreloadBattleData preloadBattleData)
	{
		if (generalHitId <= 0)
		{
			return;
		}
		DRGeneralHit dataRow = GameEntry.DataTable.GetDataRow<DRGeneralHit>(generalHitId);
		if (dataRow != null)
		{
			for (int i = 0; i < dataRow.HitEffectCount; i++)
			{
				CollectEffectGroup(dataRow.GetHitEffectAt(i), preloadBattleData);
			}
			for (int j = 0; j < dataRow.HitEffectAfterCount; j++)
			{
				CollectEffectGroup(dataRow.GetHitEffectAfterAt(j), preloadBattleData);
			}
		}
	}

	private void CollectEffectGroup(List<List<int>> effectGroup, PreloadBattleData preloadBattleData)
	{
		if (effectGroup == null)
		{
			return;
		}
		foreach (List<int> item in effectGroup)
		{
			if (item == null)
			{
				continue;
			}
			foreach (int item2 in item)
			{
				preloadBattleData.AddEffect(item2);
			}
		}
	}

	private string GetEffectAssetPathByLevel(DREffect drEffect)
	{
		int intRawValue = GameSettingExtension.GetIntRawValue("特效等级");
		string result = "";
		switch (intRawValue)
		{
		case 0:
			result = drEffect.LowLevelAssetPath;
			break;
		case 1:
			result = drEffect.MidLevelAssetPath;
			break;
		case 2:
			result = drEffect.HighLevelAssetPath;
			break;
		default:
			Log.Error($"特效等级设置错误： 没有对应的等级 ： {intRawValue}");
			return result;
		}
		if (string.IsNullOrEmpty(result))
		{
			result = drEffect.MidLevelAssetPath;
		}
		return result;
	}
}
