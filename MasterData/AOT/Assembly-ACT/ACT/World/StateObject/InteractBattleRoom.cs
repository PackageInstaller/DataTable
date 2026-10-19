using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Battle.ECS.System;
using ACT.BluePrint;
using ACT.Core;
using ACT.Event;
using ACT.UI;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractBattleRoom : StateObjectBase
{
	private const int HiddenStateId = -1;

	private const int InBattleStateId = -2;

	private const int WaitingStateId = 0;

	private const int ClearedStateId = 1;

	private const int CompletedStateId = 2;

	public BoxCollider battleTriggerField;

	private CancellationTokenSource _cts;

	private MonsterPointScenePointRuntime _scenePointRuntime;

	private int _wave;

	private bool _inBattle;

	private bool _cleared;

	private bool _isSpawningMonster;

	private bool _isPreSpawningMonster;

	private bool _preSpawnSucceeded = true;

	private bool _isStartingBattle;

	private UniTaskCompletionSource _preSpawnCompletionSource;

	private const int spawnMonsterBatchSize = 1;

	private const int spawnMonsterBatchIntervalFrame = 5;

	private BattleRoomData _battleRoomData;

	private List<Entity> _spawnMonsters = new List<Entity>();

	private readonly Dictionary<SpawnMonsterParams, Entity> _preSpawnMonsters = new Dictionary<SpawnMonsterParams, Entity>();

	private readonly HashSet<Entity> _activeMonsters = new HashSet<Entity>();

	private int _spawnMonsterCount;

	private float _preSpawnTime;

	private Vector3 diePosition;

	private List<HashSet<int>> _waveGroupSpawned = new List<HashSet<int>>();

	public Animator animator;

	public BoxCollider triggerField;

	public BoxCollider conFinerField;

	public AreaCamera AreaCamera;

	private static readonly int State = Animator.StringToHash("state");

	private bool _valid;

	private int _coolDownFrame = 1;

	public override bool serviceSave => true;

	public int Wave => _wave;

	private void SetWaveGroupSpawned(int wave, int group)
	{
		if (wave >= _waveGroupSpawned.Count)
		{
			int num = wave - _waveGroupSpawned.Count + 1;
			for (int i = 0; i < num; i++)
			{
				_waveGroupSpawned.Add(new HashSet<int>());
			}
		}
		_waveGroupSpawned[wave].Add(group);
	}

	private bool WaveGroupAllSpawned(int wave)
	{
		if (wave < 0 || wave >= _waveGroupSpawned.Count)
		{
			return false;
		}
		bool result = true;
		MonsterSpawnWave monsterSpawnWave = _battleRoomData.monsterWaves[wave];
		for (int i = 0; i < monsterSpawnWave.groups.Count; i++)
		{
			if (!_waveGroupSpawned[wave].Contains(i))
			{
				return false;
			}
		}
		return result;
	}

	private bool WaveGroupSpawned(int wave, int group)
	{
		if (wave < 0 || wave >= _waveGroupSpawned.Count)
		{
			return false;
		}
		return _waveGroupSpawned[wave].Contains(group);
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId >= -2)
		{
			return stateId <= 2;
		}
		return false;
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

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override void InitStateObject(int stateId)
	{
		_valid = true;
		_spawnMonsters.Clear();
		_preSpawnMonsters.Clear();
		_activeMonsters.Clear();
		_waveGroupSpawned.Clear();
		_spawnMonsterCount = 0;
		_isPreSpawningMonster = false;
		_preSpawnSucceeded = true;
		_preSpawnCompletionSource = null;
		if (!(entity.GetCompStateObject()?.StateWorldAssetData is BattleRoomData battleRoomData))
		{
			return;
		}
		_battleRoomData = battleRoomData;
		RefreshMonsterPointParamsFromTable();
		InitializeScenePointRuntime();
		string text = transform.name;
		for (int i = 0; i < _battleRoomData.triggerConditionList.Count; i++)
		{
			TriggerCondition triggerCondition = _battleRoomData.triggerConditionList[i];
			if (triggerCondition.battleTriggerField != null)
			{
				triggerCondition.battleTriggerField.CopyTo(battleTriggerField);
			}
		}
		transform.name = text;
		_battleRoomData.triggerField.CopyTo(triggerField);
		_battleRoomData.conFinerField.CopyTo(conFinerField);
		CinemachineFramingTransposerACT cinemachineComponent = GetComponentInChildren<CinemachineVirtualCamera>(includeInactive: true).GetCinemachineComponent<CinemachineFramingTransposerACT>();
		if (cinemachineComponent != null)
		{
			cinemachineComponent.m_CameraDistance = _battleRoomData.cameraDistance;
			cinemachineComponent.m_TrackedObjectOffset = _battleRoomData.trackedObjectOffset;
		}
		AreaCamera.gameObject.SetActive(value: false);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Team_RespawnCompelete, OnTeamRespawn);
		base.InitStateObject(stateId);
		switch (stateId)
		{
		case 1:
			NetEnterState(2).Forget();
			break;
		case 0:
			if (HasPreSpawnMonsters())
			{
				_cts = new CancellationTokenSource();
				StartPreSpawnMonsters(_cts.Token);
			}
			break;
		}
	}

	private void OnTeamRespawn(BaseEventContent obj)
	{
		ResetBattleRoomState();
		BattleRoomReset();
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		if (toStateId == 0)
		{
			_cleared = false;
			BattleRoomReset(restartPreSpawn: true, toStateId);
		}
		if (fromStateId == -2 && toStateId == 1)
		{
			PlayClearPerformance().Forget();
		}
		if (toStateId == 2 && _battleRoomData.useAreaCamera)
		{
			AreaCamera.enabled = false;
		}
		if (toStateId == -1)
		{
			if (_battleRoomData.useAreaCamera)
			{
				AreaCamera.enabled = false;
			}
			BattleRoomReset(restartPreSpawn: false);
		}
		base.HandleChangeState(fromStateId, toStateId);
	}

	public override void ReleaseStateObject()
	{
		_valid = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Team_RespawnCompelete, OnTeamRespawn);
		_scenePointRuntime?.Release();
		_scenePointRuntime = null;
		BattleRoomReset(restartPreSpawn: false);
		base.ReleaseStateObject();
	}

	private void InitializeScenePointRuntime()
	{
		_scenePointRuntime?.Release();
		_scenePointRuntime = null;
		if (_battleRoomData?.monsterWaves == null)
		{
			return;
		}
		MonsterPointScenePointRuntime monsterPointScenePointRuntime = null;
		for (int i = 0; i < _battleRoomData.monsterWaves.Count; i++)
		{
			MonsterSpawnWave monsterSpawnWave = _battleRoomData.monsterWaves[i];
			if (monsterSpawnWave?.groups == null)
			{
				continue;
			}
			for (int j = 0; j < monsterSpawnWave.groups.Count; j++)
			{
				MonsterSpawnGroup monsterSpawnGroup = monsterSpawnWave.groups[j];
				if (monsterSpawnGroup?.spawnMonsterList == null)
				{
					continue;
				}
				for (int k = 0; k < monsterSpawnGroup.spawnMonsterList.Count; k++)
				{
					SpawnMonsterParams spawnMonsterParams = monsterSpawnGroup.spawnMonsterList[k];
					if (!(spawnMonsterParams?.scenePointPrefabAssetID == null) && !string.IsNullOrEmpty(spawnMonsterParams.scenePointPrefabAssetID.GUID))
					{
						if (monsterPointScenePointRuntime == null)
						{
							monsterPointScenePointRuntime = new MonsterPointScenePointRuntime($"BattleRoom swid: {swid}");
						}
						monsterPointScenePointRuntime.Instantiate(spawnMonsterParams.scenePointPrefabAssetID, spawnMonsterParams.pos, spawnMonsterParams.spawnRotation, transform);
					}
				}
			}
		}
		_scenePointRuntime = monsterPointScenePointRuntime;
	}

	private void BattleRoomStart()
	{
		if (!_inBattle && !_isStartingBattle)
		{
			_isStartingBattle = true;
			if (_cts == null)
			{
				_cts = new CancellationTokenSource();
			}
			MonoECS.instance.SyncGameInfos();
			Singleton<GameState>.instance.SetBattleFormState(BattleFormState.Seal);
			StartBattleAfterPreSpawn(_cts.Token).Forget();
		}
	}

	private async UniTask StartBattleAfterPreSpawn(CancellationToken token)
	{
		_ = 2;
		try
		{
			UniTaskCompletionSource preSpawnCompletionSource = _preSpawnCompletionSource;
			if (preSpawnCompletionSource != null)
			{
				await preSpawnCompletionSource.Task.AttachExternalCancellation(token);
			}
			token.ThrowIfCancellationRequested();
			if (!_preSpawnSucceeded || !_valid || _cleared)
			{
				return;
			}
			if (currentStateId == -2)
			{
				if (!IsPlayerInBattleResetRange())
				{
					return;
				}
			}
			else
			{
				if (currentStateId != 0 || !CheckTriggerCondition())
				{
					return;
				}
				await NetEnterState(-2);
				token.ThrowIfCancellationRequested();
				if (!_valid || currentStateId != -2)
				{
					return;
				}
			}
			_inBattle = true;
			_wave = 0;
			await StartSpawn(token);
		}
		catch (OperationCanceledException)
		{
		}
		finally
		{
			_isStartingBattle = false;
		}
	}

	private async UniTask StartSpawn(CancellationToken token)
	{
		if (_battleRoomData.useAreaCamera)
		{
			await WaitAreaCameraSwitch(token);
		}
		if (!WaveGroupSpawned(_wave, 0))
		{
			TriggerMonsterGroup(_wave, 0, token).Forget();
		}
	}

	private bool HasPreSpawnMonsters()
	{
		if (_battleRoomData?.monsterWaves == null)
		{
			return false;
		}
		for (int i = 0; i < _battleRoomData.monsterWaves.Count; i++)
		{
			List<MonsterSpawnGroup> list = _battleRoomData.monsterWaves[i]?.groups;
			if (list == null)
			{
				continue;
			}
			for (int j = 0; j < list.Count; j++)
			{
				List<SpawnMonsterParams> list2 = list[j]?.spawnMonsterList;
				if (list2 == null)
				{
					continue;
				}
				for (int k = 0; k < list2.Count; k++)
				{
					if (ShouldPreSpawn(list2[k]))
					{
						return true;
					}
				}
			}
		}
		return false;
	}

	private static bool ShouldPreSpawn(SpawnMonsterParams spawnParam)
	{
		return spawnParam?.battleRoomPreSpawn ?? false;
	}

	private void StartPreSpawnMonsters(CancellationToken token)
	{
		UniTaskCompletionSource completionSource = (_preSpawnCompletionSource = new UniTaskCompletionSource());
		_preSpawnSucceeded = false;
		_isPreSpawningMonster = true;
		PreSpawnMonsters(token, completionSource).Forget();
	}

	private async UniTask PreSpawnMonsters(CancellationToken token, UniTaskCompletionSource completionSource)
	{
		List<SpawnMonsterParams> preSpawnParams = ListPool<SpawnMonsterParams>.Get();
		bool succeeded = false;
		try
		{
			preSpawnParams.Clear();
			for (int i = 0; i < _battleRoomData.monsterWaves.Count; i++)
			{
				List<MonsterSpawnGroup> list = _battleRoomData.monsterWaves[i]?.groups;
				if (list == null)
				{
					continue;
				}
				for (int j = 0; j < list.Count; j++)
				{
					List<SpawnMonsterParams> list2 = list[j]?.spawnMonsterList;
					if (list2 == null)
					{
						continue;
					}
					for (int k = 0; k < list2.Count; k++)
					{
						SpawnMonsterParams spawnMonsterParams = list2[k];
						if (ShouldPreSpawn(spawnMonsterParams))
						{
							preSpawnParams.Add(spawnMonsterParams);
						}
					}
				}
			}
			await SpawnMonster(preSpawnParams, _spawnMonsters, token, preSpawn: true);
			succeeded = !token.IsCancellationRequested;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		finally
		{
			preSpawnParams.Clear();
			ListPool<SpawnMonsterParams>.Release(preSpawnParams);
			if (_preSpawnCompletionSource == completionSource)
			{
				_preSpawnSucceeded = succeeded;
				_isPreSpawningMonster = false;
			}
			completionSource.TrySetResult();
		}
	}

	private async UniTask TriggerMonsterGroup(int waveIndex, int groupIndex, CancellationToken token)
	{
		if (waveIndex < 0 || waveIndex >= _battleRoomData.monsterWaves.Count)
		{
			return;
		}
		List<MonsterSpawnGroup> groups = _battleRoomData.monsterWaves[waveIndex].groups;
		if (groups == null || groupIndex < 0 || groupIndex >= groups.Count || WaveGroupSpawned(waveIndex, groupIndex))
		{
			return;
		}
		SetWaveGroupSpawned(waveIndex, groupIndex);
		List<SpawnMonsterParams> spawnParams = ListPool<SpawnMonsterParams>.Get();
		try
		{
			spawnParams.Clear();
			List<SpawnMonsterParams> spawnMonsterList = groups[groupIndex].spawnMonsterList;
			if (spawnMonsterList != null)
			{
				for (int i = 0; i < spawnMonsterList.Count; i++)
				{
					SpawnMonsterParams spawnMonsterParams = spawnMonsterList[i];
					if (ShouldPreSpawn(spawnMonsterParams))
					{
						ActivatePreSpawnMonster(spawnMonsterParams);
					}
					else
					{
						spawnParams.Add(spawnMonsterParams);
					}
				}
			}
			if (spawnParams.Count > 0)
			{
				await SpawnMonster(spawnParams, _spawnMonsters, token);
			}
			if (!token.IsCancellationRequested)
			{
				_preSpawnTime = Time.time;
			}
		}
		finally
		{
			spawnParams.Clear();
			ListPool<SpawnMonsterParams>.Release(spawnParams);
		}
	}

	private void ActivatePreSpawnMonster(SpawnMonsterParams spawnParam)
	{
		if (_preSpawnMonsters.TryGetValue(spawnParam, out var value) && value.IsValid && value.IsAlive() && _activeMonsters.Add(value))
		{
			_spawnMonsterCount++;
			if (value.TryGetCompAI(out CompAI component))
			{
				component.ActBehaviorTree?.SendEvent("enemy_extra_born_behavior");
				component.compAIState = CompAIState.BattleRoomControlDoExtraBornBehavior;
			}
		}
	}

	private void BattleRoomEnd()
	{
		if (_inBattle)
		{
			_cleared = true;
			_inBattle = false;
			Singleton<GameState>.instance.SetBattleFormState(BattleFormState.Normal);
			_cts?.Cancel();
			_cts?.Dispose();
			_cts = null;
			BattleRoomDrop();
			NetEnterState(1).Forget();
		}
	}

	private void BattleRoomReset(bool restartPreSpawn = true, int nextStateId = int.MinValue)
	{
		if (_battleRoomData != null)
		{
			Singleton<GameState>.instance.SetBattleFormState(BattleFormState.Normal);
			_inBattle = false;
			_isSpawningMonster = false;
			_isPreSpawningMonster = false;
			_preSpawnSucceeded = true;
			_isStartingBattle = false;
			_cts?.Cancel();
			_cts?.Dispose();
			_cts = null;
			_preSpawnCompletionSource = null;
			_spawnMonsterCount = 0;
			for (int i = 0; i < _spawnMonsters.Count; i++)
			{
				MonoECS.instance.TryRemoveBehave(_spawnMonsters[i]);
			}
			_spawnMonsters.Clear();
			_preSpawnMonsters.Clear();
			_activeMonsters.Clear();
			_waveGroupSpawned.Clear();
			_coolDownFrame = 1;
			if (_battleRoomData.useAreaCamera)
			{
				AreaCamera.enabled = false;
			}
			TryRestartPreSpawnAfterReset(restartPreSpawn, (nextStateId == int.MinValue) ? currentStateId : nextStateId);
		}
	}

	private void TryRestartPreSpawnAfterReset(bool restartPreSpawn, int stateId)
	{
		if (restartPreSpawn && stateId == 0 && HasPreSpawnMonsters())
		{
			_cts = new CancellationTokenSource();
			StartPreSpawnMonsters(_cts.Token);
		}
	}

	private void ResetBattleRoomState()
	{
		if (_valid && currentStateId == -2)
		{
			NetEnterState(0).Forget();
		}
	}

	private async UniTask WaitAreaCameraSwitch(CancellationToken token)
	{
		AreaCamera.gameObject.SetActive(value: true);
		AreaCamera.enabled = true;
		await UniTask.DelayFrame(2, PlayerLoopTiming.Update, token);
		SystemCamera cameraSystem = GameManager.cameraSystem;
		if (cameraSystem.Brain.IsLive(AreaCamera.conditionalCamera.vCamera))
		{
			await UniTask.WaitUntil(() => !cameraSystem.Brain.IsBlending, PlayerLoopTiming.Update, token);
		}
	}

	private async UniTask SpawnMonster(List<SpawnMonsterParams> p, List<Entity> monsterList, CancellationToken cancellationToken, bool preSpawn = false)
	{
		_isSpawningMonster = true;
		List<UniTask> tasks = ListPool<UniTask>.Get();
		try
		{
			if (p == null || p.Count == 0)
			{
				_preSpawnTime = Time.time;
				return;
			}
			List<float> pathIndexList = ((GameLoader.meta.pathOffsetChangeArray != null) ? new List<float>(GameLoader.meta.pathOffsetChangeArray) : new List<float>());
			if (pathIndexList.Count > 1)
			{
				pathIndexList.RandomSort(0, pathIndexList.Count - 1);
			}
			tasks.Clear();
			EntityFactory factory = GameManager.entities.factory;
			int batchSize = Mathf.Max(1, 1);
			int batchIntervalFrame = Mathf.Max(0, 5);
			for (int i = 0; i < p.Count; i++)
			{
				if (cancellationToken.IsCancellationRequested)
				{
					break;
				}
				SpawnMonsterParams spawnMonsterParams = p[i];
				SpawnMonsterParams spawnMonsterParams2 = (SpawnMonsterParams)spawnMonsterParams.Clone();
				if (preSpawn)
				{
					spawnMonsterParams2.pos = spawnMonsterParams.jumpInbornPos;
				}
				Entity eb = factory.CreateEnemy(spawnMonsterParams2.id);
				tasks.Add(ServerSpawnMonster(spawnMonsterParams, spawnMonsterParams2, eb, monsterList, cancellationToken, pathIndexList, i, preSpawn));
				if (tasks.Count < batchSize && i != p.Count - 1)
				{
					continue;
				}
				await UniTask.WhenAll(tasks);
				tasks.Clear();
				if (cancellationToken.IsCancellationRequested)
				{
					break;
				}
				if (i < p.Count - 1)
				{
					if (batchIntervalFrame > 0)
					{
						await UniTask.DelayFrame(batchIntervalFrame, PlayerLoopTiming.Update, cancellationToken);
					}
					else
					{
						await UniTask.Yield(cancellationToken);
					}
				}
			}
			if (!preSpawn && !cancellationToken.IsCancellationRequested)
			{
				_preSpawnTime = Time.time;
			}
		}
		catch (OperationCanceledException)
		{
		}
		finally
		{
			tasks.Clear();
			ListPool<UniTask>.Release(tasks);
			_isSpawningMonster = false;
		}
	}

	private void RefreshMonsterPointParamsFromTable()
	{
		if (_battleRoomData?.monsterWaves == null)
		{
			return;
		}
		for (int i = 0; i < _battleRoomData.monsterWaves.Count; i++)
		{
			List<MonsterSpawnGroup> list = _battleRoomData.monsterWaves[i]?.groups;
			if (list == null)
			{
				continue;
			}
			for (int j = 0; j < list.Count; j++)
			{
				List<SpawnMonsterParams> list2 = list[j]?.spawnMonsterList;
				if (list2 != null)
				{
					for (int k = 0; k < list2.Count; k++)
					{
						ApplyRuntimeMonsterPointConfig(list2[k]);
					}
				}
			}
		}
	}

	private static void ApplyRuntimeMonsterPointConfig(SpawnMonsterParams param)
	{
		if (param == null || RuntimeConfigs.data?.enemySpawns == null || !RuntimeConfigs.data.enemySpawns.TryGetValue(param.monsterPointId, out var value) || value.enemy == null || value.enemy.Count == 0)
		{
			return;
		}
		int num = CoreUtils.DetermineActualMonster(param.monsterPointId);
		if (num > 0)
		{
			param.id = num;
			param.levelType = value.enemyLevelType;
			param.level = value.enemyLevelOffset;
			if (value.useEnemyAi)
			{
				param.aiIndex = value.enemyAi;
			}
		}
	}

	private async UniTask ServerSpawnMonster(SpawnMonsterParams sourceParam, SpawnMonsterParams param, Entity eb, List<Entity> monsterList, CancellationToken cancellationToken, List<float> pathIndexList, int curPathIndex, bool preSpawn)
	{
		if (cancellationToken.IsCancellationRequested)
		{
			MonoECS.instance.TryRemoveBehave(eb);
			return;
		}
		await MonoECS.instance.CoServerSpawnMonster(eb, param);
		if (cancellationToken.IsCancellationRequested)
		{
			MonoECS.instance.TryRemoveBehave(eb);
		}
		else
		{
			if (!eb.IsValid)
			{
				return;
			}
			if (sourceParam.buffList != null)
			{
				AddBuff(eb, sourceParam.buffList);
			}
			if (preSpawn && eb.TryGetCompAI(out CompAI component))
			{
				component.pos = sourceParam.pos;
			}
			Vector3 pathOffset = ((pathIndexList.Count <= 0 || !sourceParam.usePathOffsetChange || eb.GetEntityType() != EntityType.Monster || eb.GetConfig().MonsterAttackType == MonsterAttackType.support || eb.GetCompPhysics().overlapEntityMode == OverlapEntityMode.Uncrossable) ? Vector3.zero : new Vector3(0f, 0f, pathIndexList[curPathIndex % pathIndexList.Count]));
			eb.GetCompPhysics().SetPathOffset(pathOffset);
			if (cancellationToken.IsCancellationRequested)
			{
				MonoECS.instance.TryRemoveBehave(eb);
				return;
			}
			eb.GetCompAbility().onDie += new Action<Entity>(MonsterDie);
			monsterList.Add(eb);
			if (preSpawn)
			{
				_preSpawnMonsters[sourceParam] = eb;
				if (eb.TryGetCompAI(out CompAI component2))
				{
					component2.ActBehaviorTree?.SendEvent("enemy_wait_do_extra_born_behavior");
					component2.compAIState = CompAIState.BattleRoomControlWaitDoExtraBornBehavior;
				}
			}
			else if (_activeMonsters.Add(eb))
			{
				_spawnMonsterCount++;
			}
		}
	}

	private void MonsterDie(Entity dieEB)
	{
		diePosition = dieEB.GetCompTransform().physicsPosition;
		if (_activeMonsters.Remove(dieEB))
		{
			_spawnMonsterCount--;
		}
		if (_inBattle && currentStateId == -2 && !_isSpawningMonster && _spawnMonsterCount == 0 && _wave == _battleRoomData.monsterWaves.Count - 1 && WaveGroupAllSpawned(_wave))
		{
			BattleRoomEnd();
		}
	}

	private void BattleRoomDrop()
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		int monsterDorpSourceUid;
		if (compStateObject.StateWorldAssetData != null)
		{
			monsterDorpSourceUid = compStateObject.StateWorldAssetData.stateWorldAssetUid;
			Singleton<DropItemManager>.instance.RegisterDropPos(monsterDorpSourceUid, diePosition);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.DropItem_Change, GetDropItemAddNtf);
		}
		void GetDropItemAddNtf(BaseEventContent obj)
		{
			DropItemChangeEvt dropItemChangeEvt = (DropItemChangeEvt)obj;
			if (dropItemChangeEvt.dropItemAddNtf.DropSoureUid == monsterDorpSourceUid)
			{
				Singleton<DropItemManager>.instance.DropFromMonster = true;
				Singleton<DropItemManager>.instance.MonsterDropExtraEffect(entity, dropItemChangeEvt.dropItemAddNtf);
				Singleton<DropItemManager>.instance.DropEffect(dropItemChangeEvt.dropItemAddNtf, 0u);
				Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.DropItem_Change, GetDropItemAddNtf);
			}
		}
	}

	private void AddBuff(Entity e, string[] names)
	{
		if (!entity.IsValid)
		{
			return;
		}
		e.GetCompAbility().AddAbilities(names, AbilitySource.BluePrint);
		if (!(e != MonoECS.instance.mainEntity))
		{
			foreach (string item in names)
			{
				StageChallengeManager.localChallengeBuff.Add(item);
			}
		}
	}

	private bool CheckTriggerCondition()
	{
		if (_battleRoomData.triggerConditionList == null || _battleRoomData.triggerConditionList.Count == 0)
		{
			return false;
		}
		bool result = true;
		for (int i = 0; i < _battleRoomData.triggerConditionList.Count; i++)
		{
			if (!_battleRoomData.triggerConditionList[i].Check(IsStay))
			{
				result = false;
				break;
			}
		}
		return result;
	}

	private bool CheckNextWaveCondition()
	{
		int num = _wave + 1;
		if (num < _battleRoomData.monsterWaves.Count)
		{
			MonsterSpawnWave monsterSpawnWave = _battleRoomData.monsterWaves[num];
			if (monsterSpawnWave.nextType == SpawnMonsterType.EnterTrigger)
			{
				if (MonoECS.instance.mainEntity.IsValid)
				{
					Vector3 physicsPosition = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
					return monsterSpawnWave.triggerFieldBounds.Contains(physicsPosition);
				}
				return false;
			}
			if (monsterSpawnWave.nextType == SpawnMonsterType.MonsterCountLeft)
			{
				return _spawnMonsterCount <= monsterSpawnWave.nextSpawnCount;
			}
			if (monsterSpawnWave.nextType == SpawnMonsterType.TimeElappsed)
			{
				return Time.time - _preSpawnTime > (float)monsterSpawnWave.nextTimeLeft;
			}
		}
		return false;
	}

	private bool CheckPlayerLeave()
	{
		if (currentStateId != -2 || !MonoECS.instance.mainEntity.IsValid || IsPlayerInBattleResetRange())
		{
			return false;
		}
		ResetBattleRoomState();
		BattleRoomReset();
		return true;
	}

	private bool IsPlayerInBattleResetRange()
	{
		if (!MonoECS.instance.mainEntity.IsValid)
		{
			return false;
		}
		Vector3 colliderPosition = MonoECS.instance.mainEntity.GetCompTransform().colliderPosition;
		return _battleRoomData.resetTriggerFieldBounds.Contains(colliderPosition);
	}

	private bool CheckGroupCondition(MonsterSpawnGroup info)
	{
		if (info.groupType == SpawnMonsterType.EnterTrigger)
		{
			if (MonoECS.instance.mainEntity.IsValid)
			{
				Vector3 colliderPosition = MonoECS.instance.mainEntity.GetCompTransform().colliderPosition;
				return info.triggerFieldBounds.Contains(colliderPosition);
			}
			return false;
		}
		if (info.groupType == SpawnMonsterType.MonsterCountLeft)
		{
			return _spawnMonsterCount <= info.nextSpawnCount;
		}
		if (info.groupType == SpawnMonsterType.TimeElappsed)
		{
			return Time.time - _preSpawnTime > (float)info.nextTimeLeft;
		}
		return false;
	}

	private void TryProgressBattleRoom()
	{
		if (!_inBattle || _cleared || _isSpawningMonster || currentStateId != -2 || _battleRoomData?.monsterWaves == null || _battleRoomData.monsterWaves.Count == 0 || _wave < 0 || _wave >= _battleRoomData.monsterWaves.Count)
		{
			return;
		}
		if (WaveGroupAllSpawned(_wave))
		{
			if (_spawnMonsterCount == 0 && _wave == _battleRoomData.monsterWaves.Count - 1)
			{
				BattleRoomEnd();
			}
			else if (CheckNextWaveCondition())
			{
				_wave++;
				SpawnWaveFirstGroup(_wave);
			}
			return;
		}
		MonsterSpawnWave monsterSpawnWave = _battleRoomData.monsterWaves[_wave];
		for (int i = 0; i < monsterSpawnWave.groups.Count; i++)
		{
			if (i > 0 && !WaveGroupSpawned(_wave, i) && CheckGroupCondition(monsterSpawnWave.groups[i]))
			{
				TriggerMonsterGroup(_wave, i, _cts.Token).Forget();
			}
		}
	}

	private void SpawnWaveFirstGroup(int wave)
	{
		if (wave >= 0 && wave < _battleRoomData.monsterWaves.Count)
		{
			MonsterSpawnWave monsterSpawnWave = _battleRoomData.monsterWaves[wave];
			if (monsterSpawnWave.groups != null && monsterSpawnWave.groups.Count != 0)
			{
				TriggerMonsterGroup(wave, 0, _cts.Token).Forget();
			}
		}
	}

	private void Update()
	{
		if (!_valid || _battleRoomData == null || CheckPlayerLeave() || (_isSpawningMonster && !_isPreSpawningMonster) || (!_isPreSpawningMonster && !_preSpawnSucceeded) || _isStartingBattle)
		{
			return;
		}
		if (!_inBattle && _coolDownFrame > 0)
		{
			_coolDownFrame--;
		}
		else if (_coolDownFrame <= 0 && !_inBattle && !_cleared)
		{
			bool num = currentStateId == 0 && CheckTriggerCondition();
			bool flag = currentStateId == -2 && IsPlayerInBattleResetRange();
			if (num | flag)
			{
				BattleRoomStart();
			}
		}
		else if (_inBattle && !_cleared)
		{
			TryProgressBattleRoom();
		}
	}

	private async UniTask PlayClearPerformance()
	{
		if (_battleRoomData.useClearPerformance)
		{
			await GameUtility.PlayBattleRoomPerformance(GameLoader.meta.battleRoomPerformanceConfig);
		}
		try
		{
			await UniTask.WaitUntil(WaitMonsterDieOver).Timeout(TimeSpan.FromSeconds(10.0));
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		NetEnterState(2).Forget();
	}

	private bool WaitMonsterDieOver()
	{
		bool flag = true;
		foreach (Entity spawnMonster in _spawnMonsters)
		{
			if (spawnMonster.IsValid)
			{
				flag &= spawnMonster.GetCompMotion().DieAnimationEnd;
			}
		}
		return flag;
	}

	public bool TryGetMonsterHpPercent(out float hpPercent)
	{
		if (_spawnMonsters == null)
		{
			hpPercent = 0f;
			return false;
		}
		if (_spawnMonsters.Count <= 0)
		{
			hpPercent = 0f;
			return false;
		}
		CompAbility compAbility = _spawnMonsters[0].GetCompAbility();
		float num = (float)compAbility.hp / (float)compAbility.maxHP;
		hpPercent = num;
		return true;
	}
}
