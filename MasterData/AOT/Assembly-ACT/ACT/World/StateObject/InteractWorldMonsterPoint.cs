using System;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.BluePrint;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractWorldMonsterPoint : StateObjectBase, ISpawnMonsterParams
{
	private int _monsterPointId = -1;

	private CancellationTokenSource _cts;

	private Entity _entity;

	public Entity MonsterEntity => _entity;

	public override bool serviceSave => true;

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId >= -5)
		{
			return stateId <= 2;
		}
		return false;
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject().StateWorldAssetData is WorldMonsterPointData { uniqueIndex: var uniqueIndex })
		{
			int worldID = Singleton<GameManager>.instance.worldManager.GetCurrentWorld().WorldDataHandle.WorldID;
			if (RuntimeConfigs.data.worldMonsterPoints.TryGetValue(worldID, out var value))
			{
				foreach (ItemKv item in value.spawnPoint)
				{
					if (uniqueIndex == item.id)
					{
						_monsterPointId = item.count;
						break;
					}
				}
			}
		}
		base.InitStateObject(stateId);
	}

	protected override void HandleInitState(int stateId)
	{
		switch (currentStateId)
		{
		case 0:
			if (_monsterPointId == -1)
			{
				NetEnterState(1).Forget();
				break;
			}
			_cts = new CancellationTokenSource();
			SpawnMonster(_cts.Token).Forget();
			break;
		case -1:
			_cts?.Cancel();
			_cts?.Dispose();
			_cts = null;
			if (_entity.IsValid)
			{
				MonoECS.instance.TryRemoveBehave(_entity);
			}
			break;
		}
	}

	public override void ReleaseStateObject()
	{
		_cts?.Cancel();
		_cts?.Dispose();
		_cts = null;
		if (_entity.IsValid)
		{
			MonoECS.instance.TryRemoveBehave(_entity);
		}
		base.ReleaseStateObject();
	}

	private async UniTask SpawnMonster(CancellationToken token)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		StateWorldAssetData stateWorldAssetData = compStateObject.StateWorldAssetData;
		if (stateWorldAssetData is WorldMonsterPointData data)
		{
			int behaveId = compStateObject.BehaveId;
			Entity e = (_entity = GameManager.entities.factory.CreateEnemy(behaveId));
			await MonoECS.instance.CoServerSpawnMonster(e, GetSpawnMonsterParams());
			if (data.usePathOffsetChange && e.GetEntityType() == EntityType.Monster && e.GetConfig().MonsterAttackType != MonsterAttackType.support)
			{
				int index = UnityEngine.Random.Range(0, GameLoader.meta.pathOffsetChangeArray.Count - 1);
				data.pathOffset = new Vector3(0f, 0f, GameLoader.meta.pathOffsetChangeArray[index]);
			}
			else
			{
				data.pathOffset = Vector3.zero;
			}
			e.GetCompPhysics().SetPathOffset(data.pathOffset);
			e.GetCompStateObject().StateWorldAssetData = data;
			e.GetCompAbility().onDie += new Action<Entity>(MonsterDie);
			if (token.IsCancellationRequested)
			{
				MonoECS.instance.TryRemoveBehave(e);
			}
		}
	}

	public SpawnMonsterParams GetSpawnMonsterParams()
	{
		if (!(entity.GetCompStateObject().StateWorldAssetData is WorldMonsterPointData worldMonsterPointData))
		{
			return null;
		}
		if (worldMonsterPointData.usePathOffsetChange && worldMonsterPointData.groupUid == -1)
		{
			int index = UnityEngine.Random.Range(0, GameLoader.meta.pathOffsetChangeArray.Count - 1);
			worldMonsterPointData.pathOffset = new Vector3(0f, 0f, GameLoader.meta.pathOffsetChangeArray[index]);
		}
		else if (worldMonsterPointData.groupUid == -1)
		{
			worldMonsterPointData.pathOffset = Vector3.zero;
		}
		int enemyLevelType = RuntimeConfigs.data.enemySpawns[_monsterPointId].enemyLevelType;
		SpawnMonsterParams spawnMonsterParams = SpawnMonsterParams.SpawnMonsterParamsPool.Get();
		spawnMonsterParams.id = entity.GetCompStateObject().BehaveId;
		spawnMonsterParams.monsterPointId = _monsterPointId;
		spawnMonsterParams.levelType = enemyLevelType;
		spawnMonsterParams.level = RuntimeConfigs.data.enemySpawns[_monsterPointId].enemyLevelOffset;
		spawnMonsterParams.pos = worldMonsterPointData.monsterPosition;
		spawnMonsterParams.hatredSize = new Vector3(worldMonsterPointData.hartedSizeX, worldMonsterPointData.hartedSizeY, worldMonsterPointData.hartedSizeZ);
		spawnMonsterParams.hatredOffset = new Vector3(worldMonsterPointData.hartedOffsetX, worldMonsterPointData.hartedOffsetY, worldMonsterPointData.hartedOffsetZ);
		spawnMonsterParams.useRayCastCheckBlock = worldMonsterPointData.useRayCastCheckBlock;
		spawnMonsterParams.useDirectMonsterPointRange = worldMonsterPointData.useBoxColliderRange;
		spawnMonsterParams.useEntityPositionForHatredRange = worldMonsterPointData.useEntityPositionForHatredRange;
		spawnMonsterParams.useEntityPositionForLoseBattleRange = worldMonsterPointData.useEntityPositionForLoseRange;
		spawnMonsterParams.loseBattleSize = new Vector3(worldMonsterPointData.loseBattleSizeX, worldMonsterPointData.loseBattleSizeY, worldMonsterPointData.loseBattleSizeZ);
		spawnMonsterParams.loseBattleOffset = new Vector3(worldMonsterPointData.loseBattleOffsetX, worldMonsterPointData.loseBattleOffsetY, worldMonsterPointData.loseBattleOffsetZ);
		spawnMonsterParams.loseBattleCanCheckBlock = worldMonsterPointData.loseBattleCanCheckBlock;
		spawnMonsterParams.buffList = worldMonsterPointData.buffList;
		spawnMonsterParams.isLeft = worldMonsterPointData.isLeft;
		spawnMonsterParams.groupUid = worldMonsterPointData.groupUid;
		spawnMonsterParams.groupAi = worldMonsterPointData.groupAI;
		spawnMonsterParams.aiIndex = -1;
		spawnMonsterParams.isHaveBornEffect = worldMonsterPointData.isHaveBornEffect;
		Pos[] patrolPoint = worldMonsterPointData.patrolPoint;
		foreach (Pos pos in patrolPoint)
		{
			spawnMonsterParams.patrolPoints.Add(pos);
		}
		if (worldMonsterPointData.infoPoint != null)
		{
			patrolPoint = worldMonsterPointData.infoPoint;
			foreach (Pos pos2 in patrolPoint)
			{
				spawnMonsterParams.infoPos.Add(pos2);
				spawnMonsterParams.infoPosName.Add(pos2.posName);
			}
		}
		return spawnMonsterParams;
	}

	private void MonsterDie(Entity eb)
	{
		NetEnterState(1).SuppressCancellationThrow();
		int stateWorldAssetUid = eb.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.DropItem_Change, GetDropItemAddNtf);
		Singleton<DropItemManager>.instance.RegisterDropPos(stateWorldAssetUid, eb.GetCompTransform().physicsPosition + Vector3.up);
		void GetDropItemAddNtf(BaseEventContent obj)
		{
			DropItemChangeEvt dropItemChangeEvt = (DropItemChangeEvt)obj;
			if (dropItemChangeEvt.dropItemAddNtf.DropSoureUid == stateWorldAssetUid)
			{
				Singleton<DropItemManager>.instance.DropEffect(dropItemChangeEvt.dropItemAddNtf, 0u);
				Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.DropItem_Change, GetDropItemAddNtf);
			}
		}
	}
}
