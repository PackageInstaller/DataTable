using System;
using System.Threading;
using ACT.Battle;
using ACT.BluePrint;
using ACT.Core;
using ACT.Event;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractFleeMonster")]
public class InteractFleeMonster : StateObjectBase, ISpawnMonsterParams
{
	private CancellationTokenSource _cts;

	private Entity _monster;

	private FleeMonsterPointData _data;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		_data = (FleeMonsterPointData)compStateObject.StateWorldAssetData;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.FleeStateEnd, OnFleeStateEnd);
		GameObject gameObject = new GameObject();
		gameObject.transform.SetParent(transform, worldPositionStays: false);
		gameObject.AddComponent<TemporaryArea>().Init(new MixedBox[1] { _data.FleeTriggerField }, OnPlayerEnterMoveTrigger, null);
		base.InitStateObject(stateId);
		if (stateId == 2)
		{
			NetEnterState(0).Forget();
		}
	}

	private void OnFleeStateEnd(BaseEventContent obj)
	{
		if (obj is FleeStateEndEvt fleeStateEndEvt && fleeStateEndEvt.fleeMonster.Equals(_monster))
		{
			NetEnterState(0).Forget();
		}
	}

	private void OnPlayerEnterMoveTrigger()
	{
		if (currentStateId == 0)
		{
			NetEnterState(2).Forget();
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
		if (fromStateId == 0 && toStateId == 2)
		{
			CreateMonster();
		}
		else if (fromStateId == 2 && toStateId == 0)
		{
			ReleaseMonster();
		}
	}

	private void CreateMonster()
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		int monsterPointId = _data.GetMonsterPointId();
		if (RuntimeConfigs.data.enemySpawns == null || !RuntimeConfigs.data.enemySpawns.ContainsKey(monsterPointId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"怪点Id {monsterPointId} 不存在！请检查表配置");
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
		_cts?.Cancel();
		_cts?.Dispose();
		_cts = null;
		MonoECS.instance.TryRemoveBehave(_monster);
		_monster = default;
	}

	private async UniTask CoSpawnMonster(Entity eb, CancellationToken token)
	{
		await MonoECS.instance.CoServerSpawnMonster(eb, GetSpawnMonsterParams());
		string[] buffList = _data.GetBuffList();
		if (buffList != null && buffList.Length > 0)
		{
			eb.GetCompAbility().AddAbilities(buffList, AbilitySource.Passive);
		}
		eb.GetCompStateObject().StateWorldAssetData = _data;
		eb.GetCompAbility().onDie += new Action<Entity>(MonsterDrop);
		if (token.IsCancellationRequested)
		{
			MonoECS.instance.TryRemoveBehave(eb);
		}
	}

	private void MonsterDrop(Entity eb)
	{
		int dorpSourceUid = _data.stateWorldAssetUid;
		Singleton<DropItemManager>.instance.RegisterDropPos(_data.stateWorldAssetUid, eb.GetCompTransform().physicsPosition + Vector3.up);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.DropItem_Change, GetDropItemAddNtf);
		NetEnterState(1).Forget();
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

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.FleeStateEnd, OnFleeStateEnd);
		ReleaseMonster();
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0 && stateId != 1)
		{
			return stateId == 2;
		}
		return true;
	}

	public SpawnMonsterParams GetSpawnMonsterParams()
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		int monsterPointId = _data.GetMonsterPointId();
		SpawnMonsterParams spawnMonsterParams = SpawnMonsterParams.SpawnMonsterParamsPool.Get();
		spawnMonsterParams.id = compStateObject.BehaveId;
		spawnMonsterParams.monsterPointId = monsterPointId;
		spawnMonsterParams.levelType = RuntimeConfigs.data.enemySpawns[monsterPointId].enemyLevelType;
		spawnMonsterParams.level = RuntimeConfigs.data.enemySpawns[monsterPointId].enemyLevelOffset;
		spawnMonsterParams.pos = _data.GetMonsterPosition();
		spawnMonsterParams.buffList = _data.GetBuffList();
		spawnMonsterParams.isLeft = _data.GetIsLeft();
		spawnMonsterParams.groupUid = _data.GetGroupUid();
		spawnMonsterParams.groupAi = _data.GetGroupAi();
		spawnMonsterParams.aiIndex = _data.GetAiIndex(compStateObject.BehaveId);
		spawnMonsterParams.isHaveBornEffect = _data.GetIsHaveBornEffect();
		Pos[] fleeWaypoints = _data.FleeWaypoints;
		foreach (Pos pos in fleeWaypoints)
		{
			spawnMonsterParams.patrolPoints.Add(pos.value);
		}
		return spawnMonsterParams;
	}
}
