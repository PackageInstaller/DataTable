using System.Collections.Generic;
using PathologicalGames;
using UnityEngine;

public class SpecialEntityManager : SceneSingleton<SpecialEntityManager>
{
	private List<ISpecialEntity> _queryList;

	private List<LogicEntity> _specialEntities => ModuleController<AdventureModuleController>.Instance.specialEntities;

	public ISpecialEntity PlaySpecialProcess(AdventureActor owner, GameObject prefab, Vector3 spawnPosition, Quaternion spawnRotation)
	{
		ISpecialEntity component = Spawn(prefab, spawnPosition, spawnRotation).GetComponent<ISpecialEntity>();
		if (component == null)
		{
			return null;
		}
		component.Setup(owner);
		SpecialEntityBeginEvent specialEntityBeginEvent = SpecialEntityBeginEvent.Generate();
		specialEntityBeginEvent.entity = component;
		specialEntityBeginEvent.owner = owner;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(specialEntityBeginEvent);
		return component;
	}

	public ISpecialEntity GenerateSpecialEntity(GameObject prefab, Vector3 spawnPosition, Quaternion spawnRotation)
	{
		return Spawn(prefab, spawnPosition, spawnRotation).GetComponent<ISpecialEntity>();
	}

	public void StopSpecialEntity(long id)
	{
		if (id > 0 && _specialEntities.Find((LogicEntity entity) => entity.Id == id) is ISpecialEntity specialEntity)
		{
			specialEntity.Finish();
		}
	}

	public void StopAllSpecialEntity()
	{
		for (int i = 0; i < _specialEntities.Count; i++)
		{
			if (_specialEntities.get_Item(i) is ISpecialEntity specialEntity)
			{
				specialEntity.Finish();
			}
		}
	}

	public ISpecialEntity GetSpecialEntity(long id)
	{
		if (id <= 0)
		{
			return null;
		}
		return _specialEntities.Find((LogicEntity entity) => entity.Id == id) as ISpecialEntity;
	}

	public List<ISpecialEntity> GetSpecialEntitiesByOwner(AdventureActor owner)
	{
		if (_queryList == null)
		{
			_queryList = new List<ISpecialEntity>(10);
		}
		_queryList.Clear();
		List<LogicEntity> list = _specialEntities.FindAll((LogicEntity entity) => ((ISpecialEntity)entity).Owner == owner);
		for (int num = 0; num < list.Count; num++)
		{
			_queryList.Add(list.get_Item(num) as ISpecialEntity);
		}
		return _queryList;
	}

	protected Transform Spawn(GameObject fxPrefab, Vector3 spawnPosition, Quaternion spawnRotation)
	{
		SpawnPool spawnPool = PoolManager.Pools.get_Item("Effect");
		Transform transform = ((!(spawnPool != null)) ? Object.Instantiate(fxPrefab, spawnPosition, spawnRotation).transform : spawnPool.Spawn(fxPrefab.transform, spawnPosition, spawnRotation));
		transform.SetParent(ObjectPoolUtils.GetPoolRootNode("Effect"));
		return transform;
	}

	public void Despawn(Transform transform)
	{
		ISpecialEntity component = transform.GetComponent<ISpecialEntity>();
		if (component != null)
		{
			SpecialEntityFinishEvent specialEntityFinishEvent = SpecialEntityFinishEvent.Generate();
			specialEntityFinishEvent.entity = component;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(specialEntityFinishEvent);
			if (PoolManager.Pools.TryGetValue("Effect", out var spawnPool))
			{
				spawnPool.Despawn(transform, spawnPool.group);
			}
			transform.gameObject.SetActive(value: false);
		}
	}
}
