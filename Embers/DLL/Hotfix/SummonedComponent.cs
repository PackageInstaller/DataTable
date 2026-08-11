using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine.Pool;

public class SummonedComponent : BaseComponent
{
	private Dictionary<int, SummonedEntityData> _summonedEntityDic = new Dictionary<int, SummonedEntityData>();

	public void RegisterSummonedEntity(SummonedEntity summonedEntity, bool isSyncEntityCommand)
	{
		if (!_summonedEntityDic.ContainsKey(summonedEntity.Id))
		{
			SummonedEntityData summonedEntityData = ReferencePool.Acquire<SummonedEntityData>();
			summonedEntityData.IsSyncEntityCommand = isSyncEntityCommand;
			summonedEntityData.Summoned = summonedEntity;
			_summonedEntityDic.Add(summonedEntity.Id, summonedEntityData);
		}
	}

	public void RemoveSummonedEntity(SummonedEntity battleEntity)
	{
		if (_summonedEntityDic.ContainsKey(battleEntity.Id))
		{
			ReferencePool.Release(_summonedEntityDic[battleEntity.Id]);
			_summonedEntityDic.Remove(battleEntity.Id);
		}
	}

	public List<SummonedEntity> GetSummonedEntities()
	{
		List<SummonedEntity> list = CollectionPool<List<SummonedEntity>, SummonedEntity>.Get();
		foreach (SummonedEntityData value in _summonedEntityDic.Values)
		{
			list.Add(value.Summoned);
		}
		return list;
	}

	public void UpdateSummonedEntityUv<T>(string key, T value)
	{
		if (_summonedEntityDic == null)
		{
			return;
		}
		foreach (SummonedEntityData value2 in _summonedEntityDic.Values)
		{
			if (value2.IsSyncEntityCommand && value2.Summoned != null && value2.Summoned.IsSyncEntity)
			{
				value2.Summoned.GetComponent<AIParadoxComponent>().SetVariableValues(key, value);
			}
		}
	}

	public override void OnDispose()
	{
		foreach (SummonedEntityData value in _summonedEntityDic.Values)
		{
			ReferencePool.Release(value);
		}
		_summonedEntityDic.Clear();
		_summonedEntityDic = null;
		base.OnDispose();
	}
}
