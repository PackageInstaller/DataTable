#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class EntityViewCacheSystem : BaseSystem
{
	private Dictionary<string, IObjectPool<GameObject>> entityPools = new Dictionary<string, IObjectPool<GameObject>>();

	protected override bool IsLogicSystem => false;

	public override async UniTask<bool> OnEnter(object data = null)
	{
		if (data is WorldData worldData)
		{
			if (worldData.PreloadBattleData == null)
			{
				return true;
			}
			foreach (KeyValuePair<string, GameObject> cacheHeroDatum in worldData.PreloadBattleData.CacheHeroData)
			{
				string entityAsset = AssetUtility.GetEntityAsset(cacheHeroDatum.Key);
				if (!entityPools.ContainsKey(entityAsset))
				{
					entityPools.Add(entityAsset, new ObjectPool<GameObject>(new EntityViewFactory(entityAsset, cacheHeroDatum.Value, world.EntityRoot), 1, 2));
				}
			}
			foreach (KeyValuePair<string, GameObject> cacheHeroSummonedView in worldData.PreloadBattleData.CacheHeroSummonedViewList)
			{
				string entityAsset2 = AssetUtility.GetEntityAsset(cacheHeroSummonedView.Key);
				if (!entityPools.ContainsKey(entityAsset2))
				{
					entityPools.Add(entityAsset2, new ObjectPool<GameObject>(new EntityViewFactory(entityAsset2, cacheHeroSummonedView.Value, world.EntityRoot), 3, 3));
				}
			}
			foreach (KeyValuePair<string, GameObject> cacheMonsterDatum in worldData.PreloadBattleData.CacheMonsterData)
			{
				string entityAsset3 = AssetUtility.GetEntityAsset(cacheMonsterDatum.Key);
				if (!entityPools.ContainsKey(entityAsset3))
				{
					entityPools.Add(entityAsset3, new ObjectPool<GameObject>(new EntityViewFactory(entityAsset3, cacheMonsterDatum.Value, world.EntityRoot), 1, 5));
				}
			}
			foreach (KeyValuePair<string, GameObject> cacheEffectDatum in worldData.PreloadBattleData.CacheEffectData)
			{
				string entityAsset4 = AssetUtility.GetEntityAsset(cacheEffectDatum.Key);
				entityPools.Add(entityAsset4, new ObjectPool<GameObject>(new EntityViewFactory(entityAsset4, cacheEffectDatum.Value, world.EntityRoot), 1, 12));
			}
			foreach (KeyValuePair<string, GameObject> cacheMapItemDatum in worldData.PreloadBattleData.CacheMapItemData)
			{
				string entityAsset5 = AssetUtility.GetEntityAsset(cacheMapItemDatum.Key);
				if (!entityPools.ContainsKey(entityAsset5))
				{
					entityPools.Add(entityAsset5, new ObjectPool<GameObject>(new EntityViewFactory(entityAsset5, cacheMapItemDatum.Value, world.EntityRoot), 5));
				}
			}
			foreach (KeyValuePair<string, GameObject> item in worldData.PreloadBattleData.CacheWarningIndicator)
			{
				string entityAsset6 = AssetUtility.GetEntityAsset(item.Key);
				if (!entityPools.ContainsKey(entityAsset6))
				{
					entityPools.Add(entityAsset6, new ObjectPool<GameObject>(new EntityViewFactory(entityAsset6, item.Value, world.EntityRoot), 10));
				}
			}
			foreach (KeyValuePair<string, GameObject> item2 in worldData.PreloadBattleData.CacheBattleEntity)
			{
				string entityAsset7 = AssetUtility.GetEntityAsset(item2.Key);
				if (!entityPools.ContainsKey(entityAsset7))
				{
					entityPools.Add(entityAsset7, new ObjectPool<GameObject>(new EntityViewFactory(entityAsset7, item2.Value, world.EntityRoot), 1, 5));
				}
			}
		}
		return true;
	}

	public async Task<GameObject> AsyncLoadEntityView(int entityId, string path)
	{
		if (!SystemIsNeedExecute)
		{
			return null;
		}
		if (entityPools == null)
		{
			return null;
		}
		string fullPath = AssetUtility.GetEntityAsset(path);
		entityPools.TryGetValue(fullPath, out var value);
		if (value == null)
		{
			if (!GameEntry.Resource.CheckLocationValid(fullPath))
			{
				return null;
			}
			GameObject template = await (GetSystem<GameResourceSystem>()?.LoadAssetAsync<GameObject>(fullPath) ?? default(UniTask<GameObject>));
			if (world == null)
			{
				return null;
			}
			if (entityPools == null)
			{
				return null;
			}
			if (!entityPools.ContainsKey(fullPath))
			{
				value = new ObjectPool<GameObject>(new EntityViewFactory(fullPath, template, world.EntityRoot), 2);
				entityPools.Add(fullPath, value);
			}
			else
			{
				value = entityPools[fullPath];
			}
		}
		return value?.Allocate();
	}

	public GameObject LoadEntityView(int entityId, string path)
	{
		if (!SystemIsNeedExecute)
		{
			return null;
		}
		if (entityPools == null)
		{
			return null;
		}
		string entityAsset = AssetUtility.GetEntityAsset(path);
		entityPools.TryGetValue(entityAsset, out var value);
		if (value == null)
		{
			GameObject template = null;
			if (GetSystem<GameResourceSystem>().CheckLocationValid(entityAsset))
			{
				template = GetSystem<GameResourceSystem>().LoadAsset<GameObject>(entityAsset);
			}
			else
			{
				Log.Error($"资源路径错误：{path} 资源!  ID : {entityId}");
			}
			if (!entityPools.ContainsKey(entityAsset))
			{
				value = new ObjectPool<GameObject>(new EntityViewFactory(entityAsset, template, world.EntityRoot), 2);
				entityPools.Add(entityAsset, value);
			}
			else
			{
				value = entityPools[entityAsset];
			}
		}
		return value.Allocate();
	}

	public void ClearAllEntityPools()
	{
		if (entityPools == null)
		{
			return;
		}
		foreach (KeyValuePair<string, IObjectPool<GameObject>> entityPool in entityPools)
		{
			if (entityPool.Value != null)
			{
				entityPool.Value.Dispose();
			}
		}
		entityPools.Clear();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		ClearAllEntityPools();
		entityPools = null;
	}
}
