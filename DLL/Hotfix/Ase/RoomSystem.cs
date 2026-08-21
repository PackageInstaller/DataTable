using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class RoomSystem : BaseSystem, IObserverHandler
{
	public int CurRoomID;

	public Action<IEntityRoom, int, IEntityRoom> ActionTrapTrigger;

	private ConcurrentDictionary<int, BattleRoom> entitiesRoom = new ConcurrentDictionary<int, BattleRoom>();

	private IEntityRoom localActor;

	public VolumeSystem volumeSystem { get; private set; }

	protected override bool IsLogicSystem => true;

	public override void OnAwake(object data = null)
	{
		GetSystem<BattleObserverSystem>()?.Attach(BattleObserverEventEnum.ChangeRoom, this);
		volumeSystem = world.GetSystem<VolumeSystem>();
	}

	public IEntityRoom GetLocalActor()
	{
		return localActor;
	}

	public void AddToRoomEntity(IEntityRoom entity, int roomID = 0)
	{
		entity.RoomId = roomID;
		if (!entitiesRoom.TryGetValue(roomID, out var value))
		{
			value = new BattleRoom(this);
			entitiesRoom.TryAdd(roomID, value);
		}
		value.RoomID = roomID;
		value.AddEntity(entity);
		if (entity is HeroEntity)
		{
			if (entity is HeroEntity heroEntity && heroEntity.BattleHeroData.IsSelf)
			{
				localActor = entity;
			}
		}
		else if (entity is MonsterEntity entity2)
		{
			UpdateBossBloodBarData(entity2, roomID);
		}
	}

	public void RemoveRoomEntity(IEntityRoom entity)
	{
		if (entitiesRoom.TryGetValue(entity.RoomId, out var value))
		{
			value.RemoveEntity(entity);
		}
	}

	public void ReleseAllRoomEntityExHero()
	{
		for (int i = 0; i < entitiesRoom.Count; i++)
		{
			entitiesRoom[i].ReleaseAllEntity();
		}
	}

	public List<BaseEntity> GetRoomEntity(BaseEntity targetEntity)
	{
		List<BaseEntity> list = new List<BaseEntity>();
		if (targetEntity != null && entitiesRoom.TryGetValue(((IEntityRoom)targetEntity).RoomId, out var value))
		{
			List<IEntityRoom> list2 = new List<IEntityRoom>();
			if (targetEntity is HeroEntity)
			{
				list2 = value.roomHeroEntities;
			}
			else if (targetEntity is MonsterEntity)
			{
				list2 = value.roomMonsterEntities;
			}
			for (int i = 0; i < list2.Count; i++)
			{
				list.Add(list2[i] as BaseEntity);
			}
		}
		return list;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		for (int i = 0; i < entitiesRoom.Count; i++)
		{
			entitiesRoom[i].OnCheckTrap(deltaTime);
		}
	}

	public void OnNotify(IObserverParams param)
	{
		if (param is ObserverChangeRoomParams observerChangeRoomParams)
		{
			if (localActor.ID == observerChangeRoomParams.Trigger.Id)
			{
				CurRoomID = observerChangeRoomParams.RoomID;
			}
			EntityChangeRoom(observerChangeRoomParams.Trigger, observerChangeRoomParams.RoomID);
		}
		UpdateBossBloodBarData();
	}

	private void EntityChangeRoom(BaseEntity entity, int toRoomID)
	{
		if (entity != null)
		{
			entitiesRoom.TryGetValue(((IEntityRoom)entity).RoomId, out var value);
			value.RemoveEntity(entity);
			AddToRoomEntity(entity, toRoomID);
		}
	}

	public void OnMonsterEntityDead(BaseEntity entity)
	{
		if (entity != null && entitiesRoom.TryGetValue(((IEntityRoom)entity).RoomId, out var value) && value.OnMonsterEntityDead(entity) && ((IEntityRoom)entity).RoomId == CurRoomID)
		{
			GetSystem<BattleSystem>().ShowBossBarWindow(isShow: false);
		}
	}

	private void UpdateBossBloodBarData(BaseEntity entity = null, int roomID = 0)
	{
		if (entity != null || !entitiesRoom.TryGetValue(CurRoomID, out var value))
		{
			return;
		}
		for (int i = 0; i < value.roomMonsterEntities.Count; i++)
		{
			if (value.roomMonsterEntities[i] is MonsterEntity { IsBoss: not false })
			{
				GetSystem<BattleSystem>().SetMonsterBloodDelay(0f);
				GetSystem<BattleSystem>().SetBossMode(bossModel: true);
				GetSystem<BattleSystem>().UpdateBossBloodBarData((BattleMonsterData)(value.roomMonsterEntities[i] as BaseEntity).EntityViewModel);
			}
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		ActionTrapTrigger = null;
		if (entitiesRoom != null)
		{
			for (int i = 0; i < entitiesRoom.Count; i++)
			{
				entitiesRoom[i].Clear();
			}
			entitiesRoom.Clear();
			entitiesRoom = null;
		}
	}
}
