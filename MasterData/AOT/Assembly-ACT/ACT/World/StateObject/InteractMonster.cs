using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.BluePrint;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractMonster")]
public class InteractMonster : StateObjectBase, ISpawnMonsterParams
{
	private CancellationTokenSource _cts;

	private MonsterPointScenePointRuntime _scenePointRuntime;

	private Entity _monster;

	private bool _isWildBoss;

	private bool _playerInsideWildBossLoseBattleRange;

	public override bool serviceSave => true;

	public bool ForbidCreateMonster { get; set; }

	public Entity MonsterEntity => _monster;

	public override void InitStateObject(int stateId)
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TriggerTeleportPoint, TriggerTeleportPoint);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Player_Respawn, OnPlayerRespawn);
		_isWildBoss = entity.GetCompStateObject().StateWorldAssetData is MonsterPointData monsterPointData && monsterPointData.serviceSaveTag == ServiceSaveTag.WildBoss;
		_playerInsideWildBossLoseBattleRange = false;
		if (entity.GetCompStateObject().StateWorldAssetData is MonsterPointData monsterPointData2 && monsterPointData2.ScenePointPrefabAssetID != null && !string.IsNullOrEmpty(monsterPointData2.ScenePointPrefabAssetID.GUID))
		{
			_scenePointRuntime = new MonsterPointScenePointRuntime($"MonsterPoint swid: {swid}");
			_scenePointRuntime.Instantiate(monsterPointData2.ScenePointPrefabAssetID, transform.position, transform.rotation, transform);
		}
		base.InitStateObject(stateId);
	}

	private void TriggerTeleportPoint(BaseEventContent obj)
	{
		if (obj is TriggerTeleportPoint && _monster.IsValid && _monster.IsAlive())
		{
			GameUtility.ResetMonsterInfo(_monster);
			_playerInsideWildBossLoseBattleRange = false;
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	protected override void HandleInitState(int stateId)
	{
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		if (fromStateId != 0 && toStateId == 0)
		{
			CreateMonster();
		}
		if (toStateId != 0 && toStateId != 1 && toStateId != 2)
		{
			ReleaseMonster();
		}
	}

	private void CreateMonster()
	{
		if (ForbidCreateMonster)
		{
			return;
		}
		CompStateObject compStateObject = entity.GetCompStateObject();
		MonsterPointData monsterPointData = (MonsterPointData)compStateObject.StateWorldAssetData;
		if (RuntimeConfigs.data.enemySpawns == null || !RuntimeConfigs.data.enemySpawns.ContainsKey(monsterPointData.monsterPointId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"怪点Id {monsterPointData.monsterPointId} 不存在！请检查表配置");
			}
		}
		else
		{
			ReleaseMonster();
			_cts = new CancellationTokenSource();
			_monster = GameManager.entities.factory.CreateEnemy(compStateObject.BehaveId);
			_ = LuminApplication.LogEnabled;
			CoSpawnMonster(_monster, _cts.Token).Forget();
		}
	}

	private void ReleaseMonster()
	{
		_playerInsideWildBossLoseBattleRange = false;
		_cts?.Cancel();
		_cts?.Dispose();
		_cts = null;
		MonoECS.instance.TryRemoveBehave(_monster);
	}

	private void FixedUpdate()
	{
		if (!_isWildBoss)
		{
			return;
		}
		CompAI component;
		bool inside;
		if (!_monster.IsValid || !_monster.IsAlive() || !_monster.IsLogicAvailable())
		{
			_playerInsideWildBossLoseBattleRange = false;
		}
		else if (_monster.TryGetCompAI(out component) && component.TryIsLocalPlayerInsideLoseBattleRange(out inside))
		{
			if (_playerInsideWildBossLoseBattleRange && !inside)
			{
				GameUtility.ResetMonsterInfo(_monster);
			}
			_playerInsideWildBossLoseBattleRange = inside;
		}
	}

	private async UniTask CoSpawnMonster(Entity eb, CancellationToken token)
	{
		MonoECS instance = MonoECS.instance;
		CompStateObject compStateObject = entity.GetCompStateObject();
		MonsterPointData data = (MonsterPointData)compStateObject.StateWorldAssetData;
		int behaveId = compStateObject.BehaveId;
		if (!data.aiDictionary.TryGetValue(behaveId, out var _))
		{
		}
		await instance.CoServerSpawnMonster(eb, GetSpawnMonsterParams());
		if (data.buffList != null && data.buffList.Length != 0)
		{
			eb.GetCompAbility().AddAbilities(data.buffList, AbilitySource.Passive);
		}
		if (data.usePathOffsetChange && eb.GetEntityType() == EntityType.Monster && eb.GetConfig().MonsterAttackType != MonsterAttackType.support)
		{
			int index = UnityEngine.Random.Range(0, GameLoader.meta.pathOffsetChangeArray.Count - 1);
			data.pathOffset = new Vector3(0f, 0f, GameLoader.meta.pathOffsetChangeArray[index]);
		}
		else
		{
			data.pathOffset = Vector3.zero;
		}
		eb.GetCompPhysics().SetPathOffset(data.pathOffset);
		eb.GetCompStateObject().StateWorldAssetData = data;
		eb.GetCompAbility().onDie += new Action<Entity>(MonsterDrop);
		if (token.IsCancellationRequested)
		{
			MonoECS.instance.TryRemoveBehave(eb);
		}
	}

	private void MonsterDrop(Entity eb)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		int dorpSourceUid;
		if (compStateObject.StateWorldAssetData != null)
		{
			dorpSourceUid = compStateObject.StateWorldAssetData.stateWorldAssetUid;
			Singleton<DropItemManager>.instance.RegisterDropPos(dorpSourceUid, eb.GetCompTransform().physicsPosition + Vector3.up);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.DropItem_Change, GetDropItemAddNtf);
			MonoECS.instance.ruleManager.SharedChangeState(compStateObject.StateWorldAssetData.stateWorldAssetUid, 1);
		}
		void GetDropItemAddNtf(BaseEventContent obj)
		{
			DropItemChangeEvt dropItemChangeEvt = (DropItemChangeEvt)obj;
			if (dropItemChangeEvt.dropItemAddNtf.DropSoureUid == dorpSourceUid)
			{
				Singleton<DropItemManager>.instance.DropFromMonster = true;
				Singleton<DropItemManager>.instance.MonsterDropExtraEffect(eb, dropItemChangeEvt.dropItemAddNtf);
				Singleton<DropItemManager>.instance.DropEffect(dropItemChangeEvt.dropItemAddNtf, 0u);
				Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.DropItem_Change, GetDropItemAddNtf);
			}
		}
	}

	private void OnPlayerRespawn(BaseEventContent obj)
	{
		if (_monster.IsValid)
		{
			GameUtility.ResetMonsterInfo(_monster);
			_playerInsideWildBossLoseBattleRange = false;
		}
	}

	public override void ReleaseStateObject()
	{
		_scenePointRuntime?.Release();
		_scenePointRuntime = null;
		ReleaseMonster();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TriggerTeleportPoint, TriggerTeleportPoint);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Player_Respawn, OnPlayerRespawn);
		base.ReleaseStateObject();
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (-5 <= stateId)
		{
			return stateId <= 2;
		}
		return false;
	}

	public SpawnMonsterParams GetSpawnMonsterParams()
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		MonsterPointData monsterPointData = (MonsterPointData)compStateObject.StateWorldAssetData;
		int valueOrDefault = monsterPointData.aiDictionary.GetValueOrDefault(compStateObject.BehaveId, -1);
		Vector3 vector = Vector3.zero;
		if (monsterPointData.usePathOffsetChange && RuntimeConfigs.data.entityDatas[compStateObject.BehaveId].type == 2)
		{
			if (monsterPointData.groupUid == -1)
			{
				int index = UnityEngine.Random.Range(0, GameLoader.meta.pathOffsetChangeArray.Count - 1);
				vector = new Vector3(0f, 0f, GameLoader.meta.pathOffsetChangeArray[index]);
			}
			else
			{
				vector = monsterPointData.pathOffset;
			}
		}
		SpawnMonsterParams spawnMonsterParams = SpawnMonsterParams.SpawnMonsterParamsPool.Get();
		spawnMonsterParams.id = compStateObject.BehaveId;
		spawnMonsterParams.monsterPointId = monsterPointData.monsterPointId;
		spawnMonsterParams.levelType = RuntimeConfigs.data.enemySpawns[monsterPointData.monsterPointId].enemyLevelType;
		spawnMonsterParams.level = RuntimeConfigs.data.enemySpawns[monsterPointData.monsterPointId].enemyLevelOffset;
		if (monsterPointData.sixtyBossPoint)
		{
			int key = (spawnMonsterParams.monsterPointId = RuntimeConfigs.data.worldBossMonsters[monsterPointData.bossPoint].monsterLevelShow[monsterPointData.bossIndex]);
			spawnMonsterParams.levelType = RuntimeConfigs.data.enemySpawns[monsterPointData.monsterPointId].enemyLevelType;
			spawnMonsterParams.level = RuntimeConfigs.data.enemySpawns[key].enemyLevelOffset;
		}
		spawnMonsterParams.pos = monsterPointData.monsterPosition + vector;
		spawnMonsterParams.hatredSize = new Vector3(monsterPointData.hartedSizeX, monsterPointData.hartedSizeY, monsterPointData.hartedSizeZ);
		spawnMonsterParams.hatredOffset = new Vector3(monsterPointData.hartedOffsetX, monsterPointData.hartedOffsetY, monsterPointData.hartedOffsetZ);
		spawnMonsterParams.useRayCastCheckBlock = monsterPointData.useRayCastCheckBlock;
		spawnMonsterParams.useDirectMonsterPointRange = monsterPointData.useBoxColliderRange;
		spawnMonsterParams.useEntityPositionForHatredRange = monsterPointData.useEntityPositionForHatredRange;
		spawnMonsterParams.useEntityPositionForLoseBattleRange = monsterPointData.useEntityPositionForLoseRange;
		spawnMonsterParams.loseBattleSize = new Vector3(monsterPointData.loseBattleSizeX, monsterPointData.loseBattleSizeY, monsterPointData.loseBattleSizeZ);
		spawnMonsterParams.loseBattleOffset = new Vector3(monsterPointData.loseBattleOffsetX, monsterPointData.loseBattleOffsetY, monsterPointData.loseBattleOffsetZ);
		spawnMonsterParams.loseBattleCanCheckBlock = monsterPointData.loseBattleCanCheckBlock;
		spawnMonsterParams.buffList = monsterPointData.buffList;
		spawnMonsterParams.isLeft = monsterPointData.isLeft;
		spawnMonsterParams.groupUid = monsterPointData.groupUid;
		spawnMonsterParams.groupAi = monsterPointData.groupAI;
		spawnMonsterParams.aiIndex = valueOrDefault;
		spawnMonsterParams.isHaveBornEffect = monsterPointData.isHaveBornEffect;
		Pos[] patrolPoint = monsterPointData.patrolPoint;
		foreach (Pos pos in patrolPoint)
		{
			spawnMonsterParams.patrolPoints.Add(pos);
		}
		if (monsterPointData.infoPoint != null)
		{
			patrolPoint = monsterPointData.infoPoint;
			foreach (Pos pos2 in patrolPoint)
			{
				spawnMonsterParams.infoPos.Add(pos2);
				spawnMonsterParams.infoPosName.Add(pos2.posName);
			}
		}
		return spawnMonsterParams;
	}
}
