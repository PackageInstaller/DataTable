using System;
using Ase.ECS;
using UnityEngine;

namespace Ase;

public class LevelArea : MonoBehaviour, IInit, IStart, IMathTriggerEventHandler
{
	public int areaId;

	public LevelAreaTriggerType levelAreaTriggerType = LevelAreaTriggerType.Box;

	public MonsterGroupCtrl monsterGroupCtrl;

	public MapItemGroup mapItemGroup;

	public MechanismGroup mechanismGroup;

	public NPCGroup npcGroup;

	public EventGroup eventGroup;

	public TriggerAreaGroup triggerAreaGroup;

	public LevelAreaCtrl controller;

	public LevelAreaType areaType;

	public LevelAreaRefreshType refreshType = LevelAreaRefreshType.All;

	public LevelAreaAddtiveType addtiveType = LevelAreaAddtiveType.All;

	public bool addtiveMonster;

	private bool activeState;

	private SceneSystem sceneSystem;

	public EventHandler<LevelArea> OnEnterArea;

	public EventHandler<LevelArea> OnExitArea;

	public MonsterGroupCtrl MonsterGroupCtrl => monsterGroupCtrl;

	public MapItemGroup MapItemGroup => mapItemGroup;

	public MechanismGroup MechanismGroup => mechanismGroup;

	public NPCGroup NPCGroup => npcGroup;

	public EventGroup EventGroup => eventGroup;

	public TriggerAreaGroup TriggerAreaGroup => triggerAreaGroup;

	public bool ActiveState => activeState;

	public void OnInit(object data = null)
	{
		sceneSystem = (SceneSystem)data;
		MonsterGroupCtrl.OnInit(sceneSystem);
		MapItemGroup.OnInit(sceneSystem);
		MechanismGroup.OnInit(sceneSystem);
		NPCGroup.OnInit(sceneSystem);
		EventGroup.OnInit(sceneSystem);
		TriggerAreaGroup.OnInit(sceneSystem);
		activeState = false;
	}

	public void OnStart(object data = null)
	{
		MonsterGroupCtrl.OnStart(sceneSystem);
		MapItemGroup.OnStart(sceneSystem);
		MechanismGroup.OnStart(sceneSystem);
		NPCGroup.OnStart(sceneSystem);
		EventGroup.OnStart(sceneSystem);
		TriggerAreaGroup.OnStart(sceneSystem);
	}

	public void RefreshArea(bool forceRefresh = false)
	{
		BaseEntity entity = sceneSystem.GetSystem<EntitySystem>().GetEntity(sceneSystem.GetWorld().ActorId);
		if (activeState)
		{
			if (forceRefresh)
			{
				MonsterGroupCtrl.ReceiveMapDataEvent(LevelMapDataEvent.EnterArea, entity);
			}
			MapItemGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterArea, entity);
			MechanismGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterArea, entity);
			NPCGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterArea, entity);
			EventGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterArea, entity);
			TriggerAreaGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterArea, entity);
		}
	}

	public void OnMathTriggerEnter(MathTriggerEventData eventData)
	{
		if (!activeState && eventData.Other.TryGetComponent<EntityView>(out var component) && component.Entity != null && component.Entity.IsActorEntity)
		{
			OnEntityTriggerEnter(component.Entity);
		}
	}

	public void OnMathTriggerStay(MathTriggerEventData eventData)
	{
		if (!activeState && eventData.Other.TryGetComponent<EntityView>(out var component) && component.Entity != null && component.Entity.IsActorEntity)
		{
			OnEntityTriggerEnter(component.Entity);
		}
	}

	public void OnMathTriggerExit(MathTriggerEventData eventData)
	{
		if (activeState && eventData.Other.TryGetComponent<EntityView>(out var component) && component.Entity != null && component.Entity.IsActorEntity)
		{
			OnEntityTriggerExit(component.Entity);
		}
	}

	public void OnEntityTriggerEnter(BaseEntity entity)
	{
		MonsterGroupCtrl.ReceiveMapDataEvent(LevelMapDataEvent.EnterArea, entity);
		MapItemGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterArea, entity);
		MechanismGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterArea, entity);
		NPCGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterArea, entity);
		EventGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterArea, entity);
		TriggerAreaGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterArea, entity);
		activeState = true;
		if (OnEnterArea != null)
		{
			OnEnterArea(this, this);
		}
	}

	public void OnEntityTriggerExit(BaseEntity entity)
	{
		MonsterGroupCtrl.ReceiveMapDataEvent(LevelMapDataEvent.ExitArea, entity);
		MapItemGroup.ReceiveMapDataEvent(LevelMapDataEvent.ExitArea, entity);
		MechanismGroup.ReceiveMapDataEvent(LevelMapDataEvent.ExitArea, entity);
		NPCGroup.ReceiveMapDataEvent(LevelMapDataEvent.ExitArea, entity);
		EventGroup.ReceiveMapDataEvent(LevelMapDataEvent.ExitArea, entity);
		TriggerAreaGroup.ReceiveMapDataEvent(LevelMapDataEvent.ExitArea, entity);
		activeState = false;
		if (OnExitArea != null)
		{
			OnExitArea(this, this);
		}
	}

	public void RestLevel()
	{
		monsterGroupCtrl.ReceiveMapDataEvent(LevelMapDataEvent.RestLevel);
		mapItemGroup.ReceiveMapDataEvent(LevelMapDataEvent.RestLevel);
		npcGroup.ReceiveMapDataEvent(LevelMapDataEvent.RestLevel);
		eventGroup.ReceiveMapDataEvent(LevelMapDataEvent.RestLevel);
		triggerAreaGroup.ReceiveMapDataEvent(LevelMapDataEvent.RestLevel);
		mechanismGroup.ReceiveMapDataEvent(LevelMapDataEvent.RestLevel);
	}

	public void EnterRoomEvent()
	{
		monsterGroupCtrl.ReceiveMapDataEvent(LevelMapDataEvent.EnterRoom);
		mapItemGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterRoom);
		npcGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterRoom);
		eventGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterRoom);
		triggerAreaGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterRoom);
		mechanismGroup.ReceiveMapDataEvent(LevelMapDataEvent.EnterRoom);
	}

	public void ExitRoomEvent()
	{
		monsterGroupCtrl.ReceiveMapDataEvent(LevelMapDataEvent.ExitRoom);
		mapItemGroup.ReceiveMapDataEvent(LevelMapDataEvent.ExitRoom);
		npcGroup.ReceiveMapDataEvent(LevelMapDataEvent.ExitRoom);
		eventGroup.ReceiveMapDataEvent(LevelMapDataEvent.ExitRoom);
		triggerAreaGroup.ReceiveMapDataEvent(LevelMapDataEvent.ExitRoom);
		mechanismGroup.ReceiveMapDataEvent(LevelMapDataEvent.ExitRoom);
	}

	public void OnRelease()
	{
		monsterGroupCtrl.ReceiveMapDataEvent(LevelMapDataEvent.Release);
		mapItemGroup.ReceiveMapDataEvent(LevelMapDataEvent.Release);
		npcGroup.ReceiveMapDataEvent(LevelMapDataEvent.Release);
		eventGroup.ReceiveMapDataEvent(LevelMapDataEvent.Release);
		triggerAreaGroup.ReceiveMapDataEvent(LevelMapDataEvent.Release);
		mechanismGroup.ReceiveMapDataEvent(LevelMapDataEvent.Release);
	}

	public void RestLevelAreaState()
	{
		activeState = false;
	}

	public void OnGameSpeedChanged(float gameSpeed)
	{
		if ((UnityEngine.Object)(object)mechanismGroup != null)
		{
			mechanismGroup.OnGameSpeedChanged(gameSpeed);
		}
	}

	public void OnDispose()
	{
		MapItemGroup.OnDispose();
		MechanismGroup.OnDispose();
		MonsterGroupCtrl.OnDispose();
		NPCGroup.OnDispose();
		EventGroup.OnDispose();
		TriggerAreaGroup.OnDispose();
		OnEnterArea = null;
		OnExitArea = null;
	}

	private void OnLevelAreaTriggerTypeChanged()
	{
		if (levelAreaTriggerType == LevelAreaTriggerType.Box)
		{
			MathSphereTrigger orAddComponent = base.gameObject.GetOrAddComponent<MathSphereTrigger>();
			if (orAddComponent != null)
			{
				UnityEngine.Object.DestroyImmediate(orAddComponent);
			}
			MathBoxTrigger orAddComponent2 = base.gameObject.GetOrAddComponent<MathBoxTrigger>();
			orAddComponent2.center = base.transform.position;
			orAddComponent2.size = Vector3.one;
		}
		if (levelAreaTriggerType == LevelAreaTriggerType.Sphere)
		{
			MathBoxTrigger orAddComponent3 = base.gameObject.GetOrAddComponent<MathBoxTrigger>();
			if (orAddComponent3 != null)
			{
				UnityEngine.Object.DestroyImmediate(orAddComponent3);
			}
			MathSphereTrigger orAddComponent4 = base.gameObject.GetOrAddComponent<MathSphereTrigger>();
			orAddComponent4.center = base.transform.position;
			orAddComponent4.radius = 1f;
		}
	}

	public void BattleDataKillMonster(bool isBoss)
	{
		sceneSystem.GetLevelMapData()?.BattleDataKillMonster(isBoss);
	}

	public void ForceBattleStart(int monsterUID)
	{
		sceneSystem.GetLevelMapData()?.ForceBattleStart(monsterUID, areaId);
	}

	public void ForceBattleEnd(int monsterUID)
	{
		sceneSystem.GetLevelMapData()?.ForceBattleEnd(monsterUID, areaId);
	}

	public void OpenChestReport(MapItemNode mapItemNode)
	{
		sceneSystem.GetLevelMapData()?.OpenChestReport(mapItemNode);
	}
}
