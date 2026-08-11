using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine.Pool;

namespace Ase;

public class BattleRoom : IReference
{
	public int RoomID;

	private RoomSystem roomSystem;

	private Dictionary<int, float> _originalHoldTime;

	private Dictionary<int, float> _holdTime;

	private bool triggerTrap;

	public List<IEntityRoom> roomHeroEntities { get; private set; }

	public List<IEntityRoom> roomMonsterEntities { get; private set; }

	public List<IEntityRoom> roomTrapEntities { get; private set; }

	public List<IEntityRoom> roomInteractiveEntities { get; private set; }

	public BattleRoom(RoomSystem roomSystem)
	{
		this.roomSystem = roomSystem;
		roomHeroEntities = CollectionPool<List<IEntityRoom>, IEntityRoom>.Get();
		roomMonsterEntities = CollectionPool<List<IEntityRoom>, IEntityRoom>.Get();
		roomTrapEntities = CollectionPool<List<IEntityRoom>, IEntityRoom>.Get();
		roomInteractiveEntities = CollectionPool<List<IEntityRoom>, IEntityRoom>.Get();
		_holdTime = CollectionPool<Dictionary<int, float>, KeyValuePair<int, float>>.Get();
		_originalHoldTime = CollectionPool<Dictionary<int, float>, KeyValuePair<int, float>>.Get();
	}

	public void AddEntity(IEntityRoom entity)
	{
		if (entity is HeroEntity)
		{
			roomHeroEntities.Add(entity);
		}
		else if (entity is MonsterEntity)
		{
			roomMonsterEntities.Add(entity);
		}
		else if (entity is InteractiveEntity || entity is SyncBattleInteractiveEntity)
		{
			roomInteractiveEntities.Add(entity);
		}
		else if (entity is ActivityTrapEntity activityTrapEntity)
		{
			roomTrapEntities.Add(entity);
			_holdTime.TryAdd(entity.ID, activityTrapEntity.GetTriggerTime());
			_originalHoldTime.TryAdd(entity.ID, activityTrapEntity.GetTriggerTime());
		}
	}

	public void RemoveEntity(IEntityRoom entity)
	{
		if (entity is HeroEntity)
		{
			roomHeroEntities.Remove(entity);
		}
		else if (entity is MonsterEntity)
		{
			roomMonsterEntities.Remove(entity);
		}
		else if (entity is InteractiveEntity || entity is SyncBattleInteractiveEntity)
		{
			roomInteractiveEntities.Remove(entity);
		}
		else if (entity is ActivityTrapEntity)
		{
			roomTrapEntities.Remove(entity);
		}
	}

	public void ReleaseEntity(IEntityRoom entity)
	{
		RemoveEntity(entity);
		(entity as BaseEntity).DoEntityRelease();
	}

	public void ReleaseAllEntity()
	{
		for (int i = 0; i < roomMonsterEntities.Count; i++)
		{
			(roomMonsterEntities[i] as BaseEntity).DoEntityRelease();
		}
		for (int j = 0; j < roomInteractiveEntities.Count; j++)
		{
			(roomInteractiveEntities[j] as BaseEntity).DoEntityRelease();
		}
		for (int k = 0; k < roomTrapEntities.Count; k++)
		{
			(roomTrapEntities[k] as BaseEntity).DoEntityRelease();
		}
		roomMonsterEntities.Clear();
		roomInteractiveEntities.Clear();
		roomTrapEntities.Clear();
	}

	public bool OnMonsterEntityDead(IEntityRoom entity)
	{
		roomMonsterEntities.Remove(entity);
		int num = 0;
		for (int i = 0; i < roomMonsterEntities.Count; i++)
		{
			if (roomMonsterEntities[i] is MonsterEntity { IsBoss: not false })
			{
				num++;
			}
		}
		return num <= 0;
	}

	public void OnCheckTrap(float deltaTime)
	{
		if (roomHeroEntities.Count == 0 || roomTrapEntities.Count == 0)
		{
			return;
		}
		triggerTrap = false;
		for (int i = 0; i < roomTrapEntities.Count; i++)
		{
			_holdTime.TryGetValue(roomTrapEntities[i].ID, out var value);
			for (int j = 0; j < roomHeroEntities.Count; j++)
			{
				if (j < roomHeroEntities.Count && i < roomTrapEntities.Count && roomSystem.volumeSystem.IsIntersect(roomHeroEntities[j].ID, roomTrapEntities[i].ID))
				{
					if (value >= 0f)
					{
						_holdTime[roomTrapEntities[i].ID] -= deltaTime;
					}
					else
					{
						roomSystem.ActionTrapTrigger?.Invoke(roomHeroEntities[j], RoomID, roomTrapEntities[i]);
					}
					triggerTrap = true;
					break;
				}
				triggerTrap = false;
			}
			if (!triggerTrap && value < _originalHoldTime[roomTrapEntities[i].ID])
			{
				_holdTime[roomTrapEntities[i].ID] = _originalHoldTime[roomTrapEntities[i].ID];
			}
		}
	}

	public void Clear()
	{
		CollectionPool<List<IEntityRoom>, IEntityRoom>.Release(roomHeroEntities);
		CollectionPool<List<IEntityRoom>, IEntityRoom>.Release(roomMonsterEntities);
		CollectionPool<List<IEntityRoom>, IEntityRoom>.Release(roomInteractiveEntities);
		CollectionPool<List<IEntityRoom>, IEntityRoom>.Release(roomTrapEntities);
		CollectionPool<Dictionary<int, float>, KeyValuePair<int, float>>.Release(_originalHoldTime);
		CollectionPool<Dictionary<int, float>, KeyValuePair<int, float>>.Release(_holdTime);
	}
}
