using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Event;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.Chronos;
using Fundamental;
using Runtime.Battle.BreakChallenge;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.Battle;

public class BreakChallengeManager : Singleton<BreakChallengeManager>
{
	private const string ConfigPath = "Configs/BreakChallengeConfigs";

	private const string LocalStringConfigPath = "Configs/BreakChallengeLocalStringConfig";

	private Dictionary<int, BreakChallengeConfig> _configsDic;

	private AssetLoadHandle _assetHandle;

	private AssetLoadHandle _localStringAssetHandle;

	private BreakChallengeLocalStringConfig _localStringConfig;

	private bool _isInit;

	private BreakChallengeConfig _currentConfig;

	private int _currentRoundIndex = -1;

	private HashSet<int> _currentRoundRequiredPoints;

	private HashSet<int> _currentRoundHitPoints;

	private bool _isChallengeActive;

	private Dictionary<int, BreakPoint> _breakPoints = new Dictionary<int, BreakPoint>();

	private Round _currentRound;

	private Looper _roundEndDelayer;

	private Looper _roundLooper;

	private Looper _firstRoundDelayer;

	private GameObject _leaveField;

	private List<AssetLoadHandle> _breakPointModels = new List<AssetLoadHandle>();

	public override ContextType ContextType => ContextType.NET;

	private BreakPointData GetPointDataByIdFromCurrentRound(int id)
	{
		if (_currentRound == null)
		{
			return null;
		}
		if (_currentRound is DesignateRound designateRound)
		{
			if (designateRound.BreakPoints != null)
			{
				BreakPointData[] breakPoints = designateRound.BreakPoints;
				foreach (BreakPointData breakPointData in breakPoints)
				{
					if (breakPointData.id == id)
					{
						return breakPointData;
					}
				}
			}
		}
		else if (_currentRound is RandomRound { RandomBreakPoints: not null, RandomBreakPoints: var randomBreakPoints })
		{
			foreach (BreakPointData breakPointData2 in randomBreakPoints)
			{
				if (breakPointData2.id == id)
				{
					return breakPointData2;
				}
			}
		}
		return null;
	}

	private BreakPointData GetPointDataById(int id)
	{
		if (_currentConfig == null || _currentConfig.BreakPoints == null)
		{
			return null;
		}
		for (int i = 0; i < _currentConfig.BreakPoints.Count; i++)
		{
			if (_currentConfig.BreakPoints[i].id == id)
			{
				return _currentConfig.BreakPoints[i];
			}
		}
		return null;
	}

	public override void Init()
	{
		if (_configsDic == null)
		{
			_configsDic = new Dictionary<int, BreakChallengeConfig>();
		}
		if (!_localStringAssetHandle.IsValid)
		{
			_localStringAssetHandle = AssetStationManager.BattleStation.LoadAsync<BreakChallengeLocalStringConfig>("Configs/BreakChallengeLocalStringConfig");
			_localStringAssetHandle.Completed += (AssetLoadHandle handle) =>
			{
				_localStringConfig = handle.As<BreakChallengeLocalStringConfig>();
			};
		}
		if (!_assetHandle.IsValid)
		{
			_assetHandle = AssetStationManager.BattleStation.LoadAsync<BreakChallengeConfigs>("Configs/BreakChallengeConfigs");
			_assetHandle.Completed += (AssetLoadHandle handle) =>
			{
				BreakChallengeConfigs.BreakChallengeMode[] breakModeConfigs = handle.As<BreakChallengeConfigs>().BreakModeConfigs;
				for (int i = 0; i < breakModeConfigs.Length; i++)
				{
					BreakChallengeConfigs.BreakChallengeMode breakChallengeMode = breakModeConfigs[i];
					if (!_configsDic.TryGetValue(breakChallengeMode.id, out var _))
					{
						_configsDic.Add(breakChallengeMode.id, breakChallengeMode.config);
					}
				}
				_isInit = true;
			};
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change_Complete, WorldChangeEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_TP, BattleTpEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChallengeExit, ChallengeExitEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Player_Respawn, OnPlayerRespawn);
		base.Init();
	}

	public override void UnInit()
	{
		StopChallenge(success: false, showTips: false);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change_Complete, WorldChangeEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_TP, BattleTpEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChallengeExit, ChallengeExitEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Player_Respawn, OnPlayerRespawn);
		base.UnInit();
	}

	private void OnPlayerRespawn(BaseEventContent obj)
	{
		if (_isChallengeActive)
		{
			StopChallenge(success: false);
		}
	}

	private void ChallengeIdChange(BaseEventContent obj)
	{
		if (_isChallengeActive)
		{
			StopChallenge(success: false);
		}
	}

	private void WorldChangeEvent(BaseEventContent obj)
	{
		if (_isChallengeActive)
		{
			StopChallenge(success: false);
		}
	}

	private void BattleTpEvent(BaseEventContent obj)
	{
		if (_isChallengeActive)
		{
			StopChallenge(success: false);
		}
	}

	private void ChallengeExitEvent(BaseEventContent obj)
	{
		if (_isChallengeActive)
		{
			StopChallenge(success: false);
		}
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

	public BreakChallengeConfig GetConfigById(int id)
	{
		if (!_isInit)
		{
			return null;
		}
		return _configsDic.GetValueOrDefault(id);
	}

	private void LoadBreakChallenge(Transform parent, BreakChallengeConfig config)
	{
		if (!(config != null) || !GameUtility.RuntimeGuidIsValid(config.BreakPointModelGuid))
		{
			return;
		}
		string breakPointModelGuid = config.BreakPointModelGuid;
		for (int i = 0; i < config.BreakPoints.Count; i++)
		{
			BreakPointData breakPointData = config.BreakPoints[i];
			if (breakPointModelGuid != null)
			{
				AssetLoadHandle item = AssetStationManager.BattleStation.Instantiate(breakPointModelGuid, parent);
				GameObject gameObject = item.AsGameObject();
				gameObject.transform.localPosition = breakPointData.localPosition;
				_breakPointModels.Add(item);
				BreakPoint component = gameObject.GetComponent<BreakPoint>();
				if (component != null)
				{
					component.SetMeta(breakPointData.id);
					component.InitState(0, 0);
				}
				_breakPoints.Add(breakPointData.id, component);
			}
		}
	}

	public void StartChallenge(int configId, Transform parent)
	{
		BreakChallengeConfig configById = GetConfigById(configId);
		if (configById == null)
		{
			Debug.LogError($"BreakChallengeManager: 找不到配置ID {configId}");
			return;
		}
		if (_isChallengeActive)
		{
			Debug.LogWarning("BreakChallengeManager: 挑战已在进行中，先停止当前挑战");
			StopChallenge(success: false);
		}
		_currentConfig = configById;
		_currentRoundIndex = -1;
		_isChallengeActive = true;
		if (parent != null)
		{
			LoadBreakChallenge(parent, configById);
			CreatTriggerExitField(parent, configById);
		}
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		ChallengeStateConfig[] stateConfig = _currentConfig.StateConfig;
		StateChangeInfo[] array = new StateChangeInfo[stateConfig.Length];
		for (int i = 0; i < stateConfig.Length; i++)
		{
			ChallengeStateConfig obj = stateConfig[i];
			int stateWorldUid = obj.StateWorldUid;
			int startState = obj.StartState;
			InitLinkObjectState(array, i, stateWorldUid, startState);
		}
		ruleManager.SharedChangeStates(array);
		ShowChallengePrompts();
		StartNextRound();
	}

	private void CreatTriggerExitField(Transform parent, BreakChallengeConfig config)
	{
		_leaveField = new GameObject();
		_leaveField.transform.SetParent(parent, worldPositionStays: false);
		_leaveField.AddComponent<TemporaryArea>().Init(config.TriggerBounds, null, OnTriggerExit);
	}

	private void OnTriggerExit()
	{
		StopChallenge(success: false);
	}

	private void InitLinkObjectState(StateChangeInfo[] infos, int i, int uid, int stateId)
	{
		infos[i] = new StateChangeInfo
		{
			uid = uid,
			stateId = stateId
		};
	}

	public void StopChallenge(bool success, bool showTips = true)
	{
		if (!_isChallengeActive)
		{
			return;
		}
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
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		ChallengeStateConfig[] stateConfig = _currentConfig.StateConfig;
		StateChangeInfo[] array = new StateChangeInfo[stateConfig.Length];
		for (int i = 0; i < stateConfig.Length; i++)
		{
			ChallengeStateConfig challengeStateConfig = stateConfig[i];
			int stateWorldUid = challengeStateConfig.StateWorldUid;
			int stateId = (success ? challengeStateConfig.SuccessState : challengeStateConfig.FailState);
			InitLinkObjectState(array, i, stateWorldUid, stateId);
		}
		ruleManager.SharedChangeStates(array);
		if (success)
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BigWorldSuccess, null);
		}
		else
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BigWorldFail, null);
		}
		_isChallengeActive = false;
		_roundEndDelayer.Cancel();
		_roundLooper.Cancel();
		_firstRoundDelayer.Cancel();
		foreach (AssetLoadHandle breakPointModel in _breakPointModels)
		{
			if (breakPointModel.IsValid)
			{
				AssetStationManager.BattleStation.ReleaseInstance(breakPointModel);
			}
		}
		_breakPointModels.Clear();
		_breakPoints.Clear();
		_currentConfig = null;
		_currentRoundIndex = -1;
		_currentRoundRequiredPoints?.Clear();
		_currentRoundHitPoints?.Clear();
		if (_leaveField != null)
		{
			Object.Destroy(_leaveField);
		}
	}

	public void OnBreakPointHit(int breakPointId)
	{
		if (_isChallengeActive && !(_currentConfig == null) && _currentRoundRequiredPoints != null && _currentRoundRequiredPoints.Contains(breakPointId) && _currentRoundHitPoints.Add(breakPointId))
		{
			UpdateBreakPointProgress(_currentRoundRequiredPoints.Count - _currentRoundHitPoints.Count);
			Debug.Log($"BreakChallengeManager: 指示器 {breakPointId} 被攻击，当前进度 {_currentRoundHitPoints.Count}/{_currentRoundRequiredPoints.Count}");
			CheckRoundComplete();
		}
	}

	private void StartNextRound()
	{
		if (_isChallengeActive && !(_currentConfig == null))
		{
			_currentRoundIndex++;
			if (_currentRoundIndex >= _currentConfig.Rounds.Length)
			{
				UpdateRoundProgress(_currentRoundIndex);
				Debug.Log("BreakChallengeManager: 所有轮次已完成！");
				StopChallenge(success: true);
			}
			else
			{
				_currentRound = _currentConfig.Rounds[_currentRoundIndex];
				_currentRoundRequiredPoints = GetRequiredBreakPointsForRound(_currentRound);
				_currentRoundHitPoints = new HashSet<int>();
				StartRoundAfterCountdown();
			}
		}
	}

	private void StartRoundAfterCountdown()
	{
		Debug.Log($"BreakChallengeManager: 开始第 {_currentRoundIndex + 1} 轮，需要攻击 {_currentRoundRequiredPoints.Count} 个指示器，限时 {_currentRound.RoundTime} 秒");
		if (_currentRoundIndex == 0)
		{
			SetProgressTitle();
		}
		UpdateRoundTimer(ACT.Event.EventType.start, _currentRound.RoundTime, _currentRound.RoundTime);
		UpdateRoundProgress(_currentRoundIndex);
		if (_currentRound is DesignateRound designateRound)
		{
			UpdateBreakPointProgress(designateRound.BreakPoints.Length);
		}
		else if (_currentRound is RandomRound randomRound)
		{
			UpdateBreakPointProgress(randomRound.RandomCount);
		}
		foreach (KeyValuePair<int, BreakPoint> breakPoint in _breakPoints)
		{
			int key = breakPoint.Key;
			BreakPoint value = breakPoint.Value;
			if (!(value == null))
			{
				if (_currentRoundRequiredPoints.Contains(key))
				{
					int moveState = GetPointDataByIdFromCurrentRound(key)?.animatorMoveState ?? 0;
					value.InitState(1, moveState);
				}
				else
				{
					value.InitState(0, 0);
				}
			}
		}
		float timer = _currentRound.RoundTime;
		_roundLooper = FixedUpdateTimer.Default.LoopMs(1000, () =>
		{
			UpdateRoundTimer(ACT.Event.EventType.tick, _currentRound.RoundTime, timer);
			if (timer <= 0f)
			{
				_roundLooper.Cancel();
				OnRoundComplete(_currentRound);
			}
			else
			{
				timer -= (MonoECS.instance.running ? 1 : 0);
			}
		});
	}

	private HashSet<int> GetRequiredBreakPointsForRound(Round round)
	{
		HashSet<int> hashSet = new HashSet<int>();
		if (round is DesignateRound designateRound)
		{
			if (designateRound.BreakPoints != null)
			{
				BreakPointData[] breakPoints = designateRound.BreakPoints;
				foreach (BreakPointData breakPointData in breakPoints)
				{
					hashSet.Add(breakPointData.id);
				}
			}
		}
		else if (round is RandomRound { RandomBreakPoints: not null } randomRound && randomRound.RandomBreakPoints.Length != 0)
		{
			List<int> list = randomRound.RandomBreakPoints.Select((BreakPointData p) => p.id).ToList();
			int num = Mathf.Min(randomRound.RandomCount, list.Count);
			for (int num2 = 0; num2 < list.Count; num2++)
			{
				int num3 = Random.Range(num2, list.Count);
				int i = num2;
				List<int> list2 = list;
				int index = num3;
				int num4 = list[num3];
				int num5 = list[num2];
				int num6 = (list[i] = num4);
				num6 = (list2[index] = num5);
			}
			for (int num9 = 0; num9 < num; num9++)
			{
				hashSet.Add(list[num9]);
			}
		}
		return hashSet;
	}

	private void CheckRoundComplete()
	{
		if (_currentRoundRequiredPoints != null && _currentRoundHitPoints != null && _currentRoundHitPoints.Count >= _currentRoundRequiredPoints.Count && _currentRoundRequiredPoints.All((int id) => _currentRoundHitPoints.Contains(id)))
		{
			Debug.Log($"BreakChallengeManager: 第 {_currentRoundIndex + 1} 轮提前完成！");
			_roundLooper.Cancel();
			OnRoundComplete(_currentRound);
		}
	}

	private void OnRoundComplete(Round round)
	{
		if (!_isChallengeActive)
		{
			return;
		}
		if (_currentRoundRequiredPoints != null && _currentRoundHitPoints != null && _currentRoundRequiredPoints.All((int id) => _currentRoundHitPoints.Contains(id)))
		{
			Debug.Log($"BreakChallengeManager: 第 {_currentRoundIndex + 1} 轮完成！");
			if (_currentRoundIndex + 1 >= _currentConfig.Rounds.Length)
			{
				StartNextRound();
				return;
			}
			UpdateRoundTimer(ACT.Event.EventType.stop, _currentRound.RoundTime, 0f);
			float timer = _currentRound.EndIntervalTime;
			_roundEndDelayer = FixedUpdateTimer.Default.LoopMs(1000, () =>
			{
				if (timer <= 0f)
				{
					_roundEndDelayer.Cancel();
					StartNextRound();
				}
				else
				{
					timer -= (MonoECS.instance.running ? 1 : 0);
				}
			});
		}
		else
		{
			Debug.LogWarning($"BreakChallengeManager: 第 {_currentRoundIndex + 1} 轮未完成！进度 {_currentRoundHitPoints.Count}/{_currentRoundRequiredPoints.Count}");
			StopChallenge(success: false);
		}
	}

	private void UpdateRoundTimer(ACT.Event.EventType type, float totalTime, float remainingTime)
	{
		BigWordTimeDate evt = Singleton<EventManager>.instance.GetEvt<BigWordTimeDate>();
		evt._Type = type;
		evt._total = totalTime;
		evt._remaining = remainingTime;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BigWordChangeTimer, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void SetProgressTitle()
	{
		List<LocalizedString> list = ListPool<LocalizedString>.Get();
		LocalizedString item = (_currentConfig.CustomLocalStringConfig.CustomLocalString ? _currentConfig.CustomLocalStringConfig.MainProgressText : _localStringConfig.MainProgressText);
		list.Add(item);
		LocalizedString item2 = (_currentConfig.CustomLocalStringConfig.CustomLocalString ? _currentConfig.CustomLocalStringConfig.SubProgressTip : _localStringConfig.SubProgressTip);
		list.Add(item2);
		Model<BigWorldChallengeProgressModel>.Interface.StartChallenge(list);
		ListPool<LocalizedString>.Release(list);
	}

	private void UpdateRoundProgress(int roundIndex)
	{
		BigWordProgressData evt = Singleton<EventManager>.instance.GetEvt<BigWordProgressData>();
		List<string> list = ListPool<string>.Get();
		list.Add(roundIndex.ToString());
		list.Add(_currentConfig.Rounds.Length.ToString());
		evt.values = list;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_RefreshBigWorldProgressTitle, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		ListPool<string>.Release(list);
	}

	public void UpdateBreakPointProgress(int remainPoint)
	{
		BigWordProgressData evt = Singleton<EventManager>.instance.GetEvt<BigWordProgressData>();
		evt.value = remainPoint.ToString();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_RefreshBigWorldProgress, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void ShowChallengePrompts()
	{
		if (!(_localStringConfig == null) && !(_currentConfig == null))
		{
			List<LocalizedString> list = ListPool<LocalizedString>.Get();
			LocalizedString item = (_currentConfig.CustomLocalStringConfig.CustomLocalString ? _currentConfig.CustomLocalStringConfig.MainTipText : _localStringConfig.MainTipText);
			list.Add(item);
			Model<ChallengePromptsModel>.Interface.SetStringList(list);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHALLENGEPROMPTS);
			ListPool<LocalizedString>.Release(list);
		}
	}
}
