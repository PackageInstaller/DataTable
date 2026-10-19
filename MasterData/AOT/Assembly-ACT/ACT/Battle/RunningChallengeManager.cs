using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Event;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.Chronos;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.SmartFormat.PersistentVariables;

namespace ACT.Battle;

public class RunningChallengeManager : Singleton<RunningChallengeManager>
{
	private sealed class RunningCheckpointRuntime
	{
		public AssetLoadHandle handle;

		public GameObject gameObject;

		public Collider collider;

		public BetterAnimation animation;

		public bool collected;
	}

	private const string ConfigPath = "Configs/RunningChallengeConfigs";

	private const string LocalStringConfigPath = "Configs/RunningChallengeLocalStringConfig";

	private const string AppearAnimName = "appear";

	private const string IdleAnimName = "idle";

	private const string AfterHitAnimName = "AfterHit";

	private Dictionary<int, RunningChallengeConfig> _configsDic;

	private AssetLoadHandle _assetHandle;

	private AssetLoadHandle _localStringAssetHandle;

	private RunningChallengeLocalStringConfig _localStringConfig;

	private bool _isInit;

	private RunningChallengeConfig _currentConfig;

	private int _currentConfigId;

	private bool _isChallengeActive;

	private float _timeRemaining;

	private int _totalCheckpointCount;

	private int _collectedCount;

	private int _pendingSpawnCount;

	private Looper _challengeLooper;

	private Delayer _challengeDelayer;

	private GameObject _leaveField;

	private readonly List<RunningCheckpointRuntime> _checkpoints = new List<RunningCheckpointRuntime>(16);

	private const float _delaytime = 0.5f;

	public override ContextType ContextType => ContextType.NET;

	public bool IsInitialized => _isInit;

	public override void Init()
	{
		if (_configsDic == null)
		{
			_configsDic = new Dictionary<int, RunningChallengeConfig>();
		}
		if (!_localStringAssetHandle.IsValid)
		{
			_localStringAssetHandle = AssetStationManager.BattleStation.LoadAsync<RunningChallengeLocalStringConfig>("Configs/RunningChallengeLocalStringConfig");
			_localStringAssetHandle.Completed += (AssetLoadHandle handle) =>
			{
				_localStringConfig = handle.As<RunningChallengeLocalStringConfig>();
			};
		}
		if (!_assetHandle.IsValid)
		{
			_assetHandle = AssetStationManager.BattleStation.LoadAsync<RunningChallengeConfigs>("Configs/RunningChallengeConfigs");
			_assetHandle.Completed += (AssetLoadHandle handle) =>
			{
				RunningChallengeConfigs.RunningChallengeMode[] runningModeConfigs = handle.As<RunningChallengeConfigs>().RunningModeConfigs;
				for (int i = 0; i < runningModeConfigs.Length; i++)
				{
					RunningChallengeConfigs.RunningChallengeMode runningChallengeMode = runningModeConfigs[i];
					if (!_configsDic.ContainsKey(runningChallengeMode.id))
					{
						_configsDic.Add(runningChallengeMode.id, runningChallengeMode.config);
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

	public RunningChallengeConfig GetConfigById(int id)
	{
		if (!_isInit)
		{
			return null;
		}
		return _configsDic.GetValueOrDefault(id);
	}

	public void StartChallenge(int configId, Transform parent)
	{
		RunningChallengeConfig configById = GetConfigById(configId);
		if (configById == null)
		{
			Debug.LogError($"RunningChallengeManager: 找不到配置ID {configId}");
			return;
		}
		if (configById.CheckpointPositions == null || configById.CheckpointPositions.Length == 0)
		{
			Debug.LogError($"RunningChallengeManager: 配置ID {configId} 没有检查点");
			return;
		}
		if (!GameUtility.RuntimeGuidIsValid(configById.CheckpointModelGuid))
		{
			Debug.LogError($"RunningChallengeManager: 配置ID {configId} 检查点模型GUID无效");
			return;
		}
		if (_isChallengeActive)
		{
			Debug.LogWarning("RunningChallengeManager: 挑战已在进行中，先停止当前挑战");
			StopChallenge(success: false);
		}
		_currentConfig = configById;
		_currentConfigId = configId;
		_collectedCount = 0;
		_isChallengeActive = true;
		_totalCheckpointCount = configById.CheckpointPositions.Length;
		_pendingSpawnCount = _totalCheckpointCount;
		_checkpoints.Clear();
		if (parent != null)
		{
			SpawnCheckpoints(parent, configById);
			CreateTriggerExitField(parent, configById);
		}
		ChangeLinkedObjectStates(configById.StateConfig, (ChallengeStateConfig cfg) => cfg.StartState);
		ShowChallengePrompts();
		SetProgressTitle();
		UpdateCollectProgress();
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
			_collectedCount = 0;
			_totalCheckpointCount = 0;
			_pendingSpawnCount = 0;
			_currentConfig = null;
			_currentConfigId = 0;
			CleanupCheckpoints();
			if (_leaveField != null)
			{
				UnityEngine.Object.Destroy(_leaveField);
			}
			BigWorldChallengeResultEvt evt2 = Singleton<EventManager>.instance.GetEvt<BigWorldChallengeResultEvt>();
			evt2.challengeType = ChallengeType.Running;
			evt2.configId = currentConfigId;
			evt2.success = success;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.BigWorldChallenge_Result, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
		}
	}

	private void SpawnCheckpoints(Transform parent, RunningChallengeConfig config)
	{
		Vector3[] checkpointPositions = config.CheckpointPositions;
		for (int i = 0; i < checkpointPositions.Length; i++)
		{
			RunningCheckpointRuntime runtime = new RunningCheckpointRuntime();
			_checkpoints.Add(runtime);
			int index = i;
			Vector3 worldPos = checkpointPositions[i];
			runtime.handle = AssetStationManager.BattleStation.InstantiateAsync(config.CheckpointModelGuid, parent, instantiateInWorldSpace: false, (AssetLoadHandle result) =>
			{
				if (!_isChallengeActive || _currentConfig == null)
				{
					AssetStationManager.BattleStation.ReleaseInstance(result);
					OnAllCheckpointsSpawnProcessed();
				}
				else
				{
					OnCheckpointSpawned(index, runtime, result.AsGameObject(), worldPos);
				}
			});
		}
	}

	private void OnCheckpointSpawned(int index, RunningCheckpointRuntime runtime, GameObject obj, Vector3 worldPos)
	{
		runtime.gameObject = obj;
		runtime.animation = obj.GetComponent<BetterAnimation>();
		runtime.collider = obj.GetComponent<Collider>();
		obj.transform.position = worldPos;
		PlayAppearAndIdle(runtime.animation);
		BigWorldRunningPointTrigger component = obj.GetComponent<BigWorldRunningPointTrigger>();
		if (component != null)
		{
			component.onTriggerEnter = (Action<Collider>)Delegate.Combine(component.onTriggerEnter, (Action<Collider>)((Collider _) =>
			{
				OnCheckpointTriggered(index);
			}));
		}
		OnAllCheckpointsSpawnProcessed();
	}

	private void OnAllCheckpointsSpawnProcessed()
	{
		_pendingSpawnCount--;
		if (_pendingSpawnCount > 0 || !_isChallengeActive)
		{
			return;
		}
		int num = 0;
		for (int i = 0; i < _checkpoints.Count; i++)
		{
			if (_checkpoints[i].gameObject != null)
			{
				num++;
			}
		}
		if (num == 0)
		{
			Debug.LogError("RunningChallengeManager: 没有成功生成任何检查点");
			StopChallenge(success: false);
		}
		else
		{
			_totalCheckpointCount = num;
			UpdateCollectProgress();
			StartChallengeTimer();
		}
	}

	private static void PlayAppearAndIdle(BetterAnimation animation)
	{
		if (!(animation == null))
		{
			animation.GetSequence("appear").OnComplete((AnimationBuilder _) =>
			{
				animation.GetSequence("idle").SetLoops(-1).Play();
			}).Play();
		}
	}

	private void OnCheckpointTriggered(int index)
	{
		if (!_isChallengeActive || _currentConfig == null || index < 0 || index >= _checkpoints.Count)
		{
			return;
		}
		RunningCheckpointRuntime checkpoint = _checkpoints[index];
		if (checkpoint.collected || checkpoint.gameObject == null || !checkpoint.gameObject.activeSelf)
		{
			return;
		}
		checkpoint.collected = true;
		if (checkpoint.collider != null)
		{
			checkpoint.collider.enabled = false;
		}
		_collectedCount++;
		UpdateCollectProgress();
		DispatchChallengeCollectEvent();
		if (checkpoint.animation != null)
		{
			checkpoint.animation.GetSequence("AfterHit").OnComplete((AnimationBuilder _) =>
			{
				checkpoint.gameObject.SetActive(value: false);
			}).Play();
		}
		else
		{
			checkpoint.gameObject.SetActive(value: false);
		}
		if (_collectedCount >= _totalCheckpointCount)
		{
			_challengeDelayer = FixedUpdateTimer.Default.DelayMs(500, () =>
			{
				StopChallenge(success: true);
			});
		}
	}

	private void CleanupCheckpoints()
	{
		for (int i = 0; i < _checkpoints.Count; i++)
		{
			RunningCheckpointRuntime runningCheckpointRuntime = _checkpoints[i];
			if (runningCheckpointRuntime.handle.IsValid)
			{
				AssetStationManager.BattleStation.ReleaseInstance(runningCheckpointRuntime.handle);
			}
		}
		_checkpoints.Clear();
	}

	private void DispatchChallengeCollectEvent()
	{
		BigWordRunningPointChange evt = Singleton<EventManager>.instance.GetEvt<BigWordRunningPointChange>();
		evt.count = _collectedCount.ToString();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChallengeCollect, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
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

	private void CreateTriggerExitField(Transform parent, RunningChallengeConfig config)
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

	private void UpdateCollectProgress()
	{
		if (!(_currentConfig == null))
		{
			BigWordProgressData evt = Singleton<EventManager>.instance.GetEvt<BigWordProgressData>();
			List<string> list = ListPool<string>.Get();
			list.Add(_collectedCount.ToString());
			list.Add(_totalCheckpointCount.ToString());
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
			localizedString["1"] = new StringVariable
			{
				Value = _totalCheckpointCount.ToString()
			};
			list.Add(localizedString);
			LocalizedString localizedString2 = (_currentConfig.CustomLocalStringConfig.CustomLocalString ? new LocalizedString(_currentConfig.CustomLocalStringConfig.SubProgressTip.TableReference, _currentConfig.CustomLocalStringConfig.SubProgressTip.TableEntryReference) : new LocalizedString(_localStringConfig.SubProgressTip.TableReference, _localStringConfig.SubProgressTip.TableEntryReference));
			localizedString2["0"] = new StringVariable
			{
				Value = _collectedCount.ToString()
			};
			localizedString2["1"] = new StringVariable
			{
				Value = _totalCheckpointCount.ToString()
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
			localizedString["1"] = new StringVariable
			{
				Value = _totalCheckpointCount.ToString()
			};
			List<LocalizedString> list = ListPool<LocalizedString>.Get();
			list.Add(localizedString);
			Model<ChallengePromptsModel>.Interface.SetStringList(list);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHALLENGEPROMPTS);
			ListPool<LocalizedString>.Release(list);
		}
	}
}
