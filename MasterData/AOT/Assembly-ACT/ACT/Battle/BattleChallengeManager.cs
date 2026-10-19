using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle.Configs;
using ACT.BluePrint;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.Chronos;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.SmartFormat.PersistentVariables;

namespace ACT.Battle;

public class BattleChallengeManager : Singleton<BattleChallengeManager>
{
	private const string ConfigPath = "Configs/BattleChallengeConfigs";

	private const string LocalStringConfigPath = "Configs/BattleChallengeLocalStringConfig";

	private Dictionary<int, BattleChallengeConfig> _configsDic;

	private AssetLoadHandle _assetHandle;

	private AssetLoadHandle _localStringAssetHandle;

	private BattleChallengeLocalStringConfig _localStringConfig;

	private bool _isInit;

	private BattleChallengeConfig _currentConfig;

	private int _currentConfigId;

	private bool _isChallengeActive;

	private float _timeRemaining;

	private int _totalMonsterCount;

	private int _aliveMonsterCount;

	private bool _isSpawning;

	private Looper _challengeLooper;

	private Delayer _challengeDelayer;

	private GameObject _leaveField;

	private CancellationTokenSource _spawnCts;

	private readonly List<Entity> _spawnedMonsters = new List<Entity>(8);

	private const float _delaytime = 1f;

	public override ContextType ContextType => ContextType.NET;

	public bool IsInitialized => _isInit;

	public override void Init()
	{
		if (_configsDic == null)
		{
			_configsDic = new Dictionary<int, BattleChallengeConfig>();
		}
		if (!_localStringAssetHandle.IsValid)
		{
			_localStringAssetHandle = AssetStationManager.BattleStation.LoadAsync<BattleChallengeLocalStringConfig>("Configs/BattleChallengeLocalStringConfig");
			_localStringAssetHandle.Completed += (AssetLoadHandle handle) =>
			{
				_localStringConfig = handle.As<BattleChallengeLocalStringConfig>();
			};
		}
		if (!_assetHandle.IsValid)
		{
			_assetHandle = AssetStationManager.BattleStation.LoadAsync<BattleChallengeConfigs>("Configs/BattleChallengeConfigs");
			_assetHandle.Completed += (AssetLoadHandle handle) =>
			{
				BattleChallengeConfigs.BattleChallengeMode[] battleModeConfigs = handle.As<BattleChallengeConfigs>().BattleModeConfigs;
				for (int i = 0; i < battleModeConfigs.Length; i++)
				{
					BattleChallengeConfigs.BattleChallengeMode battleChallengeMode = battleModeConfigs[i];
					if (!_configsDic.ContainsKey(battleChallengeMode.id))
					{
						_configsDic.Add(battleChallengeMode.id, battleChallengeMode.config);
					}
				}
				_isInit = true;
			};
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change_Complete, OnFailEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_TP, OnFailEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChallengeExit, OnFailEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Player_Respawn, OnFailEvent);
		base.Init();
	}

	public override void UnInit()
	{
		StopChallenge(success: false, showTips: false);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change_Complete, OnFailEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_TP, OnFailEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChallengeExit, OnFailEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Player_Respawn, OnFailEvent);
		base.UnInit();
	}

	public override void OnDestroy()
	{
		if (_assetHandle.IsValid)
		{
			AssetStationManager.BattleStation.Release(_assetHandle);
		}
		if (_localStringAssetHandle.IsValid)
		{
			AssetStationManager.BattleStation.Release(_localStringAssetHandle);
		}
		base.OnDestroy();
	}

	private void OnFailEvent(BaseEventContent obj)
	{
		if (_isChallengeActive)
		{
			StopChallenge(success: false);
		}
	}

	public BattleChallengeConfig GetConfigById(int id)
	{
		if (!_isInit)
		{
			return null;
		}
		return _configsDic.GetValueOrDefault(id);
	}

	public void StartChallenge(int configId, Transform parent)
	{
		BattleChallengeConfig configById = GetConfigById(configId);
		if (configById == null)
		{
			Debug.LogError($"BattleChallengeManager: 找不到配置ID {configId}");
			return;
		}
		if (configById.SpawnPoints == null || configById.SpawnPoints.Length == 0)
		{
			Debug.LogError($"BattleChallengeManager: 配置ID {configId} 没有怪物生成点");
			return;
		}
		if (_isChallengeActive)
		{
			Debug.LogWarning("BattleChallengeManager: 挑战已在进行中，先停止当前挑战");
			StopChallenge(success: false);
		}
		_currentConfig = configById;
		_currentConfigId = configId;
		_isChallengeActive = true;
		_totalMonsterCount = configById.SpawnPoints.Length;
		_aliveMonsterCount = 0;
		_isSpawning = true;
		_spawnedMonsters.Clear();
		if (parent != null)
		{
			CreateTriggerExitField(parent, configById);
		}
		ChangeLinkedObjectStates(configById.StateConfig, (ChallengeStateConfig cfg) => cfg.StartState);
		ShowChallengePrompts();
		SetProgressTitle();
		UpdateKillProgress();
		_spawnCts?.Cancel();
		_spawnCts?.Dispose();
		_spawnCts = new CancellationTokenSource();
		SpawnMonstersAsync(_spawnCts.Token).Forget();
	}

	public void StopChallenge(bool success, bool showTips = true)
	{
		if (_isChallengeActive)
		{
			UpdateTimer(ACT.Event.EventType.stop, _currentConfig.TimeLimit, 0f);
			if (showTips)
			{
				ChallengeTipComponentData uiData = new ChallengeTipComponentData
				{
					challengeTipShowType = ((!success) ? ChallengeTipShowType.Failure : ChallengeTipShowType.Success)
				};
				OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
				evt.position = UIPosition.UpperMiddle;
				evt.type = HudComponentType.ChallengeTip;
				evt.uiData = uiData;
				evt.timeOutDuration = 15f;
				evt.priorityInQueue = 1;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
			ChangeLinkedObjectStates(_currentConfig.StateConfig, (ChallengeStateConfig cfg) => (!success) ? cfg.FailState : cfg.SuccessState);
			if (success)
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BigWorldSuccess, null);
			}
			else
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BigWorldFail, null);
			}
			int currentConfigId = _currentConfigId;
			_isChallengeActive = false;
			if (_challengeLooper.IsValid())
			{
				_challengeLooper.Cancel();
			}
			if (_challengeDelayer.IsValid())
			{
				_challengeDelayer.Cancel();
			}
			_spawnCts?.Cancel();
			_spawnCts?.Dispose();
			_spawnCts = null;
			_currentConfig = null;
			_currentConfigId = 0;
			_totalMonsterCount = 0;
			_aliveMonsterCount = 0;
			_isSpawning = false;
			CleanupMonsters();
			if (_leaveField != null)
			{
				UnityEngine.Object.Destroy(_leaveField);
			}
			BigWorldChallengeResultEvt evt2 = Singleton<EventManager>.instance.GetEvt<BigWorldChallengeResultEvt>();
			evt2.challengeType = ChallengeType.Battle;
			evt2.configId = currentConfigId;
			evt2.success = success;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.BigWorldChallenge_Result, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
		}
	}

	private async UniTaskVoid SpawnMonstersAsync(CancellationToken cancellationToken)
	{
		BattleSpawnPointConfig[] spawnPoints = _currentConfig.SpawnPoints;
		List<UniTask> tasks = ListPool<UniTask>.Get();
		try
		{
			List<float> list;
			if (GameLoader.meta.pathOffsetChangeArray != null && GameLoader.meta.pathOffsetChangeArray.Count > 0)
			{
				list = new List<float>(GameLoader.meta.pathOffsetChangeArray);
				if (list.Count > 1)
				{
					list.RandomSort(0, list.Count - 1);
				}
			}
			else
			{
				list = new List<float>();
			}
			EntityFactory factory = GameManager.entities.factory;
			for (int i = 0; i < spawnPoints.Length; i++)
			{
				if (cancellationToken.IsCancellationRequested)
				{
					break;
				}
				if (!_isChallengeActive)
				{
					break;
				}
				SpawnMonsterParams spawnMonsterParams = BuildSpawnMonsterParams(spawnPoints[i]);
				Entity eb = factory.CreateEnemy(spawnMonsterParams.id);
				tasks.Add(ServerSpawnMonster(spawnMonsterParams, eb, cancellationToken, list, i));
			}
			await UniTask.WhenAll(tasks);
			if (!cancellationToken.IsCancellationRequested && _isChallengeActive)
			{
				if (_spawnedMonsters.Count == 0)
				{
					Debug.LogError("BattleChallengeManager: 没有成功生成任何怪物");
					StopChallenge(success: false);
				}
				else if (_aliveMonsterCount <= 0)
				{
					StopChallenge(success: true);
				}
				else
				{
					StartChallengeTimer();
				}
			}
		}
		finally
		{
			_isSpawning = false;
			tasks.Clear();
			ListPool<UniTask>.Release(tasks);
		}
	}

	private async UniTask ServerSpawnMonster(SpawnMonsterParams param, Entity eb, CancellationToken cancellationToken, List<float> pathIndexList, int curPathIndex)
	{
		if (cancellationToken.IsCancellationRequested)
		{
			MonoECS.instance.TryRemoveBehave(eb);
			return;
		}
		await MonoECS.instance.CoServerSpawnMonster(eb, param);
		if (cancellationToken.IsCancellationRequested || !_isChallengeActive)
		{
			if (eb.IsAlive())
			{
				MonoECS.instance.TryRemoveBehave(eb);
			}
		}
		else if (eb.IsValid && eb.IsAlive())
		{
			if (param.buffList != null && param.buffList.Length != 0)
			{
				AddBuff(eb, param.buffList);
			}
			CompPhysics compPhysics = eb.GetCompPhysics();
			ConfigCharacter config = eb.GetConfig();
			if (pathIndexList.Count > 0 && param.usePathOffsetChange && eb.GetEntityType() == EntityType.Monster && config.MonsterAttackType != MonsterAttackType.support && compPhysics.overlapEntityMode != OverlapEntityMode.Uncrossable)
			{
				param.pathOffset = new Vector3(0f, 0f, pathIndexList[curPathIndex % pathIndexList.Count]);
			}
			else
			{
				param.pathOffset = Vector3.zero;
			}
			compPhysics.SetPathOffset(param.pathOffset);
			if (cancellationToken.IsCancellationRequested || !_isChallengeActive)
			{
				MonoECS.instance.TryRemoveBehave(eb);
				return;
			}
			eb.GetCompAbility().onDie += new Action<Entity>(OnMonsterDie);
			_spawnedMonsters.Add(eb);
			_aliveMonsterCount++;
			UpdateKillProgress();
		}
	}

	private SpawnMonsterParams BuildSpawnMonsterParams(BattleSpawnPointConfig cfg)
	{
		SpawnMonsterParams spawnMonsterParams = SpawnMonsterParams.SpawnMonsterParamsPool.Get();
		int monsterPointId = cfg.MonsterPointId;
		spawnMonsterParams.id = GetMonsterId(monsterPointId);
		spawnMonsterParams.monsterPointId = monsterPointId;
		if (RuntimeConfigs.data.enemySpawns.TryGetValue(monsterPointId, out var value))
		{
			spawnMonsterParams.levelType = value.enemyLevelType;
			spawnMonsterParams.level = value.enemyLevelOffset;
		}
		spawnMonsterParams.pos = cfg.SpawnPosition;
		spawnMonsterParams.hatredSize = cfg.HatredSize;
		spawnMonsterParams.hatredOffset = cfg.HatredOffset;
		spawnMonsterParams.useRayCastCheckBlock = cfg.UseRayCastCheckBlock;
		spawnMonsterParams.loseBattleSize = cfg.LoseBattleSize;
		spawnMonsterParams.loseBattleOffset = cfg.LoseBattleOffset;
		spawnMonsterParams.loseBattleCanCheckBlock = cfg.LoseBattleCanCheckBlock;
		spawnMonsterParams.buffList = cfg.BuffList;
		spawnMonsterParams.isLeft = cfg.IsLeft;
		spawnMonsterParams.groupUid = cfg.GroupUid;
		spawnMonsterParams.groupAi = cfg.GroupIndex;
		spawnMonsterParams.aiIndex = ResolveAiIndex(cfg, spawnMonsterParams.id);
		spawnMonsterParams.bornBehaviorName = ResolveBornBehaviorName(cfg, spawnMonsterParams.id);
		spawnMonsterParams.jumpInbornPos = cfg.JumpInBornPos;
		spawnMonsterParams.bornInActive = cfg.BornInActive;
		spawnMonsterParams.isHaveBornEffect = cfg.IsHaveBornEffect;
		spawnMonsterParams.usePathOffsetChange = cfg.UsePathOffsetChange;
		spawnMonsterParams.shareBossInfoUI = cfg.ShareBossInfoUI;
		if (cfg.PatrolPoints != null)
		{
			for (int i = 0; i < cfg.PatrolPoints.Length; i++)
			{
				spawnMonsterParams.patrolPoints.Add(cfg.PatrolPoints[i]);
			}
		}
		if (cfg.InfoPoints != null)
		{
			for (int j = 0; j < cfg.InfoPoints.Length; j++)
			{
				BattleSpawnInfoPointConfig battleSpawnInfoPointConfig = cfg.InfoPoints[j];
				spawnMonsterParams.infoPos.Add(battleSpawnInfoPointConfig.Position);
				spawnMonsterParams.infoPosName.Add(battleSpawnInfoPointConfig.PosName);
			}
		}
		return spawnMonsterParams;
	}

	private static int ResolveAiIndex(BattleSpawnPointConfig cfg, int monsterId)
	{
		if (cfg.AiConfig == null)
		{
			return 0;
		}
		for (int i = 0; i < cfg.AiConfig.Length; i++)
		{
			if (cfg.AiConfig[i].Id == monsterId)
			{
				return cfg.AiConfig[i].Index;
			}
		}
		return 0;
	}

	private static string ResolveBornBehaviorName(BattleSpawnPointConfig cfg, int monsterId)
	{
		if (cfg.BornBehaviorConfigs == null)
		{
			return string.Empty;
		}
		for (int i = 0; i < cfg.BornBehaviorConfigs.Length; i++)
		{
			if (cfg.BornBehaviorConfigs[i].Id == monsterId)
			{
				return cfg.BornBehaviorConfigs[i].BehaviorName ?? string.Empty;
			}
		}
		return string.Empty;
	}

	private static int GetMonsterId(int monsterPointId)
	{
		if (!RuntimeConfigs.data.enemySpawns.TryGetValue(monsterPointId, out var value) || value.enemy == null)
		{
			return 21001;
		}
		int num = 0;
		int result = 21001;
		for (int i = 0; i < value.enemy.Count; i++)
		{
			Maybe maybe = value.enemy[i];
			if (maybe.weight >= num)
			{
				num = maybe.weight;
				result = maybe.id;
			}
		}
		return result;
	}

	private void OnMonsterDie(Entity eb)
	{
		if (!_isChallengeActive || _currentConfig == null)
		{
			return;
		}
		_aliveMonsterCount--;
		UpdateKillProgress();
		if (!_isSpawning && _aliveMonsterCount <= 0)
		{
			_challengeDelayer = FixedUpdateTimer.Default.DelayMs(1000, () =>
			{
				StopChallenge(success: true);
			});
		}
	}

	private void CleanupMonsters()
	{
		for (int num = _spawnedMonsters.Count - 1; num >= 0; num--)
		{
			Entity entity = _spawnedMonsters[num];
			if (entity.IsAlive())
			{
				MonoECS.instance.TryRemoveBehave(entity);
			}
		}
		_spawnedMonsters.Clear();
	}

	private static void AddBuff(Entity entity, string[] names)
	{
		if (entity.IsValid)
		{
			entity.GetCompAbility().AddAbilities(names, AbilitySource.BluePrint);
		}
	}

	private void StartChallengeTimer()
	{
		_timeRemaining = _currentConfig.TimeLimit;
		UpdateTimer(ACT.Event.EventType.start, _currentConfig.TimeLimit, _timeRemaining);
		_challengeLooper = FixedUpdateTimer.Default.LoopMs(1000, () =>
		{
			UpdateTimer(ACT.Event.EventType.tick, _currentConfig.TimeLimit, _timeRemaining);
			if (_timeRemaining <= 0f)
			{
				StopChallenge(success: false);
			}
			else
			{
				_timeRemaining -= (MonoECS.instance.running ? 1 : 0);
			}
		});
	}

	private void CreateTriggerExitField(Transform parent, BattleChallengeConfig config)
	{
		if (config.TriggerBounds != null && config.TriggerBounds.Length != 0)
		{
			_leaveField = new GameObject();
			_leaveField.transform.SetParent(parent, worldPositionStays: false);
			_leaveField.AddComponent<TemporaryArea>().Init(config.TriggerBounds, null, OnTriggerExit);
		}
	}

	private void OnTriggerExit()
	{
		StopChallenge(success: false);
	}

	private void ChangeLinkedObjectStates(ChallengeStateConfig[] stateConfigs, Func<ChallengeStateConfig, int> stateSelector)
	{
		if (stateConfigs != null && stateConfigs.Length != 0)
		{
			RuleManager ruleManager = MonoECS.instance.ruleManager;
			StateChangeInfo[] array = new StateChangeInfo[stateConfigs.Length];
			for (int i = 0; i < stateConfigs.Length; i++)
			{
				array[i] = new StateChangeInfo
				{
					uid = stateConfigs[i].StateWorldUid,
					stateId = stateSelector(stateConfigs[i])
				};
			}
			ruleManager.SharedChangeStates(array);
		}
	}

	private void UpdateTimer(ACT.Event.EventType type, float totalTime, float remainingTime)
	{
		BigWordTimeDate evt = Singleton<EventManager>.instance.GetEvt<BigWordTimeDate>();
		evt._Type = type;
		evt._total = totalTime;
		evt._remaining = remainingTime;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BigWordChangeTimer, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void UpdateKillProgress()
	{
		if (!(_currentConfig == null))
		{
			int num = _totalMonsterCount - _aliveMonsterCount;
			BigWordProgressData evt = Singleton<EventManager>.instance.GetEvt<BigWordProgressData>();
			List<string> list = ListPool<string>.Get();
			list.Add(num.ToString());
			list.Add(_totalMonsterCount.ToString());
			evt.values = list;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_RefreshBigWorldProgress, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			ListPool<string>.Release(list);
		}
	}

	private void SetProgressTitle()
	{
		if (!(_localStringConfig == null) && !(_currentConfig == null))
		{
			List<LocalizedString> list = ListPool<LocalizedString>.Get();
			LocalizedString localizedString = (_currentConfig.CustomLocalStringConfig.CustomLocalString ? new LocalizedString(_currentConfig.CustomLocalStringConfig.MainProgressText.TableReference, _currentConfig.CustomLocalStringConfig.MainProgressText.TableEntryReference) : new LocalizedString(_localStringConfig.MainProgressText.TableReference, _localStringConfig.MainProgressText.TableEntryReference));
			localizedString["0"] = new StringVariable
			{
				Value = _currentConfig.TimeLimit.ToString()
			};
			list.Add(localizedString);
			LocalizedString localizedString2 = (_currentConfig.CustomLocalStringConfig.CustomLocalString ? new LocalizedString(_currentConfig.CustomLocalStringConfig.SubProgressTip.TableReference, _currentConfig.CustomLocalStringConfig.SubProgressTip.TableEntryReference) : new LocalizedString(_localStringConfig.SubProgressTip.TableReference, _localStringConfig.SubProgressTip.TableEntryReference));
			int num = _totalMonsterCount - _aliveMonsterCount;
			localizedString2["0"] = new StringVariable
			{
				Value = num.ToString()
			};
			localizedString2["1"] = new StringVariable
			{
				Value = _totalMonsterCount.ToString()
			};
			list.Add(localizedString2);
			Model<BigWorldChallengeProgressModel>.Interface.StartChallenge(list);
			ListPool<LocalizedString>.Release(list);
		}
	}

	private void ShowChallengePrompts()
	{
		if (!(_localStringConfig == null) && !(_currentConfig == null))
		{
			LocalizedString localizedString = (_currentConfig.CustomLocalStringConfig.CustomLocalString ? new LocalizedString(_currentConfig.CustomLocalStringConfig.MainTipText.TableReference, _currentConfig.CustomLocalStringConfig.MainTipText.TableEntryReference) : new LocalizedString(_localStringConfig.MainTipText.TableReference, _localStringConfig.MainTipText.TableEntryReference));
			localizedString["0"] = new StringVariable
			{
				Value = _currentConfig.TimeLimit.ToString()
			};
			List<LocalizedString> list = ListPool<LocalizedString>.Get();
			list.Add(localizedString);
			Model<ChallengePromptsModel>.Interface.SetStringList(list);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHALLENGEPROMPTS);
			ListPool<LocalizedString>.Release(list);
		}
	}
}
