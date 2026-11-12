using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using PathologicalGames;
using TrueSync;
using UnityEngine;

public class AreaEffectManager : SceneSingleton<AreaEffectManager>
{
	private LogManager.Logger _logger;

	private readonly Dictionary<int, (int MaxCount, int OverLimitType)> areaConfigDic = new Dictionary<int, (int, int)>();

	private List<AreaEffectEntity> _queryList;

	private readonly Dictionary<int, Dictionary<long, FP>> _hittedEntitiesGroupDic = new Dictionary<int, Dictionary<long, FP>>();

	private List<LogicEntity> _areaEffectList => ModuleController<AdventureModuleController>.Instance.areaEffects;

	protected override void Awake()
	{
		base.Awake();
		_logger = Singleton<LogManager>.Instance.get_Item("AreaEffectManager");
		foreach (AreaEffect areaEffectDatum in Singleton<HotfixDataController>.Instance.AreaEffectData)
		{
			areaConfigDic.TryAdd(areaEffectDatum.AreaTag, (areaEffectDatum.MaxCount, areaEffectDatum.OverLimitType));
		}
	}

	public long PlayAreaEffect(AdventureActor owner, GameObject areaEffectPrefab, Vector3 spawnPosition, Quaternion spawnRotation, bool isAssemble = false, Action<AreaEffectEntity> onBeforeSetup = null, Action<AreaEffectEntity> onAfterSetup = null)
	{
		if (!areaEffectPrefab.TryGetComponent<AreaEffectEntity>(out var component))
		{
			Debug.LogError("未找到区域效果组件,预制体名称:" + areaEffectPrefab.name);
			return 0L;
		}
		if (!CheckMaxCount(component.areaHashCode))
		{
			Debug.Log("区域效果超出总数限制或标签数量限制,释放失败,区域效果名称:" + areaEffectPrefab.name);
			return 0L;
		}
		AreaEffectEntity areaEffectEntity = Spawn(areaEffectPrefab, spawnPosition, spawnRotation, isAssemble);
		onBeforeSetup?.Invoke(areaEffectEntity);
		if (areaEffectEntity.Id <= 0)
		{
			Debug.LogError(areaEffectEntity.name);
		}
		areaEffectEntity.Setup(owner);
		onAfterSetup?.Invoke(areaEffectEntity);
		return areaEffectEntity.Id;
	}

	private bool CheckMaxCount(int areaHashCode)
	{
		if (areaHashCode == 0)
		{
			return true;
		}
		if (!areaConfigDic.TryGetValue(areaHashCode, out (int, int) value))
		{
			return true;
		}
		List<AreaEffectEntity> areaEffectsByTag = GetAreaEffectsByTag(areaHashCode);
		if (areaEffectsByTag == null)
		{
			return true;
		}
		if (areaEffectsByTag.Count < value.Item1)
		{
			return true;
		}
		switch (value.Item2)
		{
		case 1:
		{
			AreaEffectEntity areaEffectEntity = _areaEffectList.First((LogicEntity areaEffect) => ((AreaEffectEntity)areaEffect).CheckTag(areaHashCode)) as AreaEffectEntity;
			if (areaEffectEntity != null)
			{
				areaEffectEntity.Finish();
			}
			return true;
		}
		case 2:
			return false;
		default:
			return true;
		}
	}

	public void StopAreaEffect(long id)
	{
		if (id > 0)
		{
			AreaEffectEntity areaEffectEntity = _areaEffectList.Find((LogicEntity areaEffect) => areaEffect.Id == id) as AreaEffectEntity;
			if (areaEffectEntity != null)
			{
				areaEffectEntity.Finish();
			}
		}
	}

	public void StopAreaEffectByTag(string tag1)
	{
		if (tag1 != null)
		{
			int tagHashCode = CommonHelper.StringToHash(tag1);
			StopAreaEffectByTag(tagHashCode);
		}
	}

	public void StopAreaEffectByTag(int tagHashCode)
	{
		List<LogicEntity> list = _areaEffectList.FindAll((LogicEntity areaEffect) => ((AreaEffectEntity)areaEffect).CheckTag(tagHashCode));
		for (int num = 0; num < list.Count; num++)
		{
			(list.get_Item(num) as AreaEffectEntity)?.Finish();
		}
	}

	public void StopAllAreaEffect()
	{
		for (int i = 0; i < _areaEffectList.Count; i++)
		{
			(_areaEffectList.get_Item(i) as AreaEffectEntity)?.Finish();
		}
	}

	public void FixMaxCountByTag(string areaTag, int fixCount)
	{
		if (!string.IsNullOrEmpty(areaTag))
		{
			int areaHashCode = CommonHelper.StringToHash(areaTag);
			FixMaxCountByTag(areaHashCode, fixCount);
		}
	}

	public void FixMaxCountByTag(int areaHashCode, int fixCount)
	{
		if (areaHashCode != 0)
		{
			if (areaConfigDic.ContainsKey(areaHashCode))
			{
				areaConfigDic.set_Item(areaHashCode, (areaConfigDic.get_Item(areaHashCode).Item1 + fixCount, areaConfigDic.get_Item(areaHashCode).Item2));
			}
			else
			{
				areaConfigDic.Add(areaHashCode, (fixCount, 2));
			}
		}
	}

	public List<AreaEffectEntity> GetAllAreaEffect()
	{
		if (_queryList == null)
		{
			_queryList = new List<AreaEffectEntity>(10);
		}
		_queryList.Clear();
		for (int i = 0; i < _areaEffectList.Count; i++)
		{
			_queryList.Add(_areaEffectList.get_Item(i) as AreaEffectEntity);
		}
		return _queryList;
	}

	public AreaEffectEntity GetAreaEffect(long id)
	{
		if (id <= 0)
		{
			return null;
		}
		return _areaEffectList.Find((LogicEntity x) => x.Id == id) as AreaEffectEntity;
	}

	public List<AreaEffectEntity> GetAreaEffectsByTag(string tag1)
	{
		if (tag1 == null)
		{
			return null;
		}
		int tagHashCode = CommonHelper.StringToHash(tag1);
		return GetAreaEffectsByTag(tagHashCode);
	}

	public List<AreaEffectEntity> GetAreaEffectsByTag(int tagHashCode)
	{
		if (_queryList == null)
		{
			_queryList = new List<AreaEffectEntity>(10);
		}
		_queryList.Clear();
		List<LogicEntity> list = _areaEffectList.FindAll((LogicEntity areaEffect) => ((AreaEffectEntity)areaEffect).CheckTag(tagHashCode));
		for (int num = 0; num < list.Count; num++)
		{
			_queryList.Add(list.get_Item(num) as AreaEffectEntity);
		}
		return _queryList;
	}

	public List<AreaEffectEntity> GetAreaEffectsByOwner(AdventureActor owner)
	{
		if (_queryList == null)
		{
			_queryList = new List<AreaEffectEntity>(10);
		}
		_queryList.Clear();
		List<LogicEntity> list = _areaEffectList.FindAll((LogicEntity areaEffect) => ((AreaEffectEntity)areaEffect).owner == owner);
		for (int num = 0; num < list.Count; num++)
		{
			_queryList.Add(list.get_Item(num) as AreaEffectEntity);
		}
		return _queryList;
	}

	internal void SetActorHitedTimeToGroup(AreaEffectEntity areaEffect, long entityId, FP time)
	{
		if (!(areaEffect == null) && areaEffect.areaHashCode != 0)
		{
			_hittedEntitiesGroupDic.TryAdd(areaEffect.areaHashCode, new Dictionary<long, FP>(10));
			_hittedEntitiesGroupDic.get_Item(areaEffect.areaHashCode).set_Item(entityId, time);
		}
	}

	internal bool QueryActorHitedTimeoutByGroup(AreaEffectEntity areaEffect, long entityId, out FP hitTime)
	{
		hitTime = 0;
		if (areaEffect == null || areaEffect.areaHashCode == 0)
		{
			return false;
		}
		if (_hittedEntitiesGroupDic.TryGetValue(areaEffect.areaHashCode, out var value) && value != null && value.TryGetValue(entityId, out hitTime))
		{
			return true;
		}
		return false;
	}

	protected AreaEffectEntity Spawn(GameObject fxPrefab, Vector3 spawnPosition, Quaternion spawnRotation, bool isAssemble = false)
	{
		SpawnPool spawnPool = PoolManager.Pools.get_Item("Effect");
		Transform transform = ((spawnPool != null) ? spawnPool.Spawn(fxPrefab.transform, spawnPosition, spawnRotation, isAssemble) : UnityEngine.Object.Instantiate(fxPrefab, spawnPosition, spawnRotation).transform);
		transform.SetParent(ObjectPoolUtils.GetPoolRootNode("Effect"));
		if (transform.TryGetComponent<AreaEffectEntity>(out var component))
		{
			return component;
		}
		spawnPool.Despawn(transform, spawnPool.group);
		return null;
	}

	public void Despawn(AreaEffectEntity entity)
	{
		if (PoolManager.Pools.TryGetValue("Effect", out var spawnPool))
		{
			spawnPool.Despawn(entity.transform, spawnPool.group);
		}
	}
}
