using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Model;

public class CharacterTutorialModel : Model<CharacterTutorialModel>
{
	private bool _inCharacterTutorial;

	private bool _canOperate;

	private int _currentCharacterTutorialId;

	private bool _tutorialLastStepCompleted;

	private bool _CharacterTutorialShowHighLight;

	public Dictionary<int, HighLightCountData> HighLightCountDataDic = new Dictionary<int, HighLightCountData>();

	private const string _characterTutorialConfigsPath = "CharacterTutorialConfigs";

	private const string _characterTeamTutorialConfigsPath = "CharacterTeamTutorialConfigs";

	private AssetLoadHandle _characterTutorialHandle;

	private AssetLoadHandle _characterTeamTutorialHandle;

	private CharacterTutorialConfigs _configs;

	private CharacterTeamTutorialConfigs _teamConfigs;

	private CharacterTutorialData _curCharacterTutorialData;

	private PromptProcessData _curPromptProcessData;

	private OperateNodeData _curOperateNodeData;

	private int _promptProcessId;

	private string _listenAbilityName = string.Empty;

	private int _configuredEnergyApplyVersion;

	private int _tutorialSessionVersion;

	private int _promptProcessVersion;

	private int _lastTeamTutorialTargetMidTipNodeId;

	private float _operateNodeEnterRealtime;

	private const float _ignoreFailSecondsAfterEnterNode = 0.1f;

	private Action _onTutorialStart;

	private Action _onTutorialFinish;

	private Action _onCharacterTeamTutorialStart;

	private Action _onCharacterTeamTutorialFinish;

	private Action<PromptProcessData> _onPromptProcessChanged;

	private Action<OperateNodeData, bool> _onOperateNodeSuccess;

	private Action<OperateNodeData, OperateNodeData> _onOperateNodeFail;

	private Action<OperateNodeData> _onToNextOperateNode;

	private Action<OperateNodeData> _onOperateNodeBackTo;

	private Action<int> _onOperateNodeSecondEnergyShowDesc;

	private Action _onInteractRefresh;

	private List<CharacterTutorialRaidInfo> _allCharacterTutorialRaidInfos;

	private List<CharacterTutorialRaidInfo> _characterTutorialRaidInfos;

	private List<CharacterTutorialRaidInfo> _characterTeamTutorialRaidInfos;

	private bool _characterTutorialEventListenersAdded;

	private System.DateTime _promotProcessStartTime;

	private readonly Dictionary<(int CharacterId, int NodeId), List<Parameters>> _energyRowsByCharacterAndNode = new Dictionary<(int, int), List<Parameters>>();

	private readonly Dictionary<int, List<TeamParameters>> _teamEnergyRowsByNode = new Dictionary<int, List<TeamParameters>>();

	private bool _energyConfigCacheInitialized;

	private bool _teamEnergyConfigCacheInitialized;

	public bool InCharacterTutorial => _inCharacterTutorial;

	public bool InSingleCharacterTutorial
	{
		get
		{
			if (_inCharacterTutorial)
			{
				return TutorialMode == CharacterTutorialMode.Single;
			}
			return false;
		}
	}

	public bool InCharacterTeamTutorial
	{
		get
		{
			if (_inCharacterTutorial)
			{
				return TutorialMode == CharacterTutorialMode.Team;
			}
			return false;
		}
	}

	public CharacterTutorialMode TutorialMode { get; private set; }

	public int MainCharacterTutorialId { get; private set; }

	public int[] CharacterTutorialTeamIds { get; private set; } = Array.Empty<int>();

	public bool CanOperate
	{
		set
		{
			_canOperate = value;
			if (value)
			{
				OnEnterOperateNode();
			}
		}
	}

	public int CharacterTutorialId
	{
		get
		{
			return _currentCharacterTutorialId;
		}
		set
		{
			_currentCharacterTutorialId = value;
		}
	}

	public bool CharacterTutorialShowHighLight
	{
		get
		{
			return _CharacterTutorialShowHighLight;
		}
		set
		{
			_CharacterTutorialShowHighLight = value;
		}
	}

	private bool HasTutorial => _curCharacterTutorialData != null;

	private bool HasProcess => _curPromptProcessData != null;

	private bool HasNode => _curOperateNodeData != null;

	public PromptProcessData CurrentPromptProcessData => _curPromptProcessData;

	public OperateNodeData CurrentOperateNodeData => _curOperateNodeData;

	public event Action OnTutorialStart
	{
		add
		{
			_onTutorialStart = (Action)Delegate.Combine(_onTutorialStart, value);
		}
		remove
		{
			_onTutorialStart = (Action)Delegate.Remove(_onTutorialStart, value);
		}
	}

	public event Action OnTutorialFinish
	{
		add
		{
			_onTutorialFinish = (Action)Delegate.Combine(_onTutorialFinish, value);
		}
		remove
		{
			_onTutorialFinish = (Action)Delegate.Remove(_onTutorialFinish, value);
		}
	}

	public event Action OnCharacterTeamTutorialStart
	{
		add
		{
			_onCharacterTeamTutorialStart = (Action)Delegate.Combine(_onCharacterTeamTutorialStart, value);
		}
		remove
		{
			_onCharacterTeamTutorialStart = (Action)Delegate.Remove(_onCharacterTeamTutorialStart, value);
		}
	}

	public event Action OnCharacterTeamTutorialFinish
	{
		add
		{
			_onCharacterTeamTutorialFinish = (Action)Delegate.Combine(_onCharacterTeamTutorialFinish, value);
		}
		remove
		{
			_onCharacterTeamTutorialFinish = (Action)Delegate.Remove(_onCharacterTeamTutorialFinish, value);
		}
	}

	public event Action<PromptProcessData> OnPromptProcessChanged
	{
		add
		{
			_onPromptProcessChanged = (Action<PromptProcessData>)Delegate.Combine(_onPromptProcessChanged, value);
		}
		remove
		{
			_onPromptProcessChanged = (Action<PromptProcessData>)Delegate.Remove(_onPromptProcessChanged, value);
		}
	}

	public event Action<OperateNodeData, bool> OnOperateNodeSuccess
	{
		add
		{
			_onOperateNodeSuccess = (Action<OperateNodeData, bool>)Delegate.Combine(_onOperateNodeSuccess, value);
		}
		remove
		{
			_onOperateNodeSuccess = (Action<OperateNodeData, bool>)Delegate.Remove(_onOperateNodeSuccess, value);
		}
	}

	public event Action<OperateNodeData, OperateNodeData> OnOperateNodeFail
	{
		add
		{
			_onOperateNodeFail = (Action<OperateNodeData, OperateNodeData>)Delegate.Combine(_onOperateNodeFail, value);
		}
		remove
		{
			_onOperateNodeFail = (Action<OperateNodeData, OperateNodeData>)Delegate.Remove(_onOperateNodeFail, value);
		}
	}

	public event Action<OperateNodeData> OnToNextOperateNode
	{
		add
		{
			_onToNextOperateNode = (Action<OperateNodeData>)Delegate.Combine(_onToNextOperateNode, value);
		}
		remove
		{
			_onToNextOperateNode = (Action<OperateNodeData>)Delegate.Remove(_onToNextOperateNode, value);
		}
	}

	public event Action<OperateNodeData> OnOperateNodeBackTo
	{
		add
		{
			_onOperateNodeBackTo = (Action<OperateNodeData>)Delegate.Combine(_onOperateNodeBackTo, value);
		}
		remove
		{
			_onOperateNodeBackTo = (Action<OperateNodeData>)Delegate.Remove(_onOperateNodeBackTo, value);
		}
	}

	public event Action<int> OnOperateNodeSecondEnergyShowDesc
	{
		add
		{
			_onOperateNodeSecondEnergyShowDesc = (Action<int>)Delegate.Combine(_onOperateNodeSecondEnergyShowDesc, value);
		}
		remove
		{
			_onOperateNodeSecondEnergyShowDesc = (Action<int>)Delegate.Remove(_onOperateNodeSecondEnergyShowDesc, value);
		}
	}

	public event Action OnInteractRefresh
	{
		add
		{
			_onInteractRefresh = (Action)Delegate.Combine(_onInteractRefresh, value);
		}
		remove
		{
			_onInteractRefresh = (Action)Delegate.Remove(_onInteractRefresh, value);
		}
	}

	public bool TryConsumeTutorialCompleteFlag()
	{
		if (!_tutorialLastStepCompleted)
		{
			return false;
		}
		_tutorialLastStepCompleted = false;
		return true;
	}

	private void MarkEnterOperateNode()
	{
		_operateNodeEnterRealtime = Time.realtimeSinceStartup;
		if (_curOperateNodeData is CharacterAbilityOperateNodeData characterAbilityOperateNodeData)
		{
			_listenAbilityName = characterAbilityOperateNodeData.GetAbilityName();
		}
		else
		{
			_listenAbilityName = string.Empty;
		}
	}

	private static bool IsCharacterTrialEntrance(RaidEntranceData entranceData)
	{
		if (entranceData?.raidId == null)
		{
			return false;
		}
		int[] raidId = entranceData.raidId;
		foreach (int key in raidId)
		{
			if (!RuntimeConfigs.data.raids.TryGetValue(key, out var value))
			{
				continue;
			}
			int[] tryRole = value.tryRole;
			if (tryRole != null && tryRole.Length > 0)
			{
				EntityCharacterProbation data = CoreUtils.GetData(value.tryRole[0], RuntimeConfigs.data.entityCharacterProbations);
				if (data != null && data.isShow != 0)
				{
					return true;
				}
			}
		}
		return false;
	}

	private void BuildAllCharacterTutorialRaidInfosFromConfig()
	{
		_allCharacterTutorialRaidInfos = new List<CharacterTutorialRaidInfo>();
		_characterTeamTutorialRaidInfos = new List<CharacterTutorialRaidInfo>();
		if (RuntimeConfigs.data?.raidEntranceDatas == null)
		{
			return;
		}
		foreach (var (_, raidEntranceData2) in RuntimeConfigs.data.raidEntranceDatas)
		{
			if (raidEntranceData2.raidType == 6 && !IsCharacterTrialEntrance(raidEntranceData2))
			{
				CharacterTutorialRaidInfo item = new CharacterTutorialRaidInfo(raidEntranceData2);
				_allCharacterTutorialRaidInfos.Add(item);
				if (IsCharacterTeamTutorialRaid(raidEntranceData2))
				{
					_characterTeamTutorialRaidInfos.Add(item);
				}
			}
		}
	}

	private void RefreshOwnedCharacterTutorialRaidInfos()
	{
		if (_allCharacterTutorialRaidInfos == null)
		{
			BuildAllCharacterTutorialRaidInfosFromConfig();
		}
		if (_characterTutorialRaidInfos == null)
		{
			_characterTutorialRaidInfos = new List<CharacterTutorialRaidInfo>();
		}
		_characterTutorialRaidInfos.Clear();
		HashSet<int> hashSet = new HashSet<int>();
		List<Character> bagCharacters = CharacterDataHelper.GetBagCharacters();
		if (bagCharacters != null)
		{
			foreach (Character item in bagCharacters)
			{
				if (item != null)
				{
					hashSet.Add(item.Id);
				}
			}
		}
		foreach (CharacterTutorialRaidInfo allCharacterTutorialRaidInfo in _allCharacterTutorialRaidInfos)
		{
			if (hashSet.Contains(allCharacterTutorialRaidInfo.CharacterId))
			{
				_characterTutorialRaidInfos.Add(allCharacterTutorialRaidInfo);
			}
		}
	}

	protected override void Init()
	{
		BuildAllCharacterTutorialRaidInfosFromConfig();
		RefreshOwnedCharacterTutorialRaidInfos();
		if (_configs == null)
		{
			_characterTutorialHandle = AssetStationManager.Root.Load<CharacterTutorialConfigs>("CharacterTutorialConfigs");
			_configs = _characterTutorialHandle.As<CharacterTutorialConfigs>();
		}
		if (_teamConfigs == null)
		{
			_characterTeamTutorialHandle = AssetStationManager.Root.Load<CharacterTeamTutorialConfigs>("CharacterTeamTutorialConfigs");
			_teamConfigs = _characterTeamTutorialHandle.As<CharacterTeamTutorialConfigs>();
		}
	}

	protected override void UnInit()
	{
		RemoveCharacterTutorialEventListener();
		_tutorialSessionVersion++;
		_promptProcessVersion++;
		_curCharacterTutorialData = null;
		_curPromptProcessData = null;
		_curOperateNodeData = null;
		_inCharacterTutorial = false;
		_canOperate = false;
		TutorialMode = CharacterTutorialMode.Single;
		MainCharacterTutorialId = 0;
		CharacterTutorialTeamIds = Array.Empty<int>();
		_listenAbilityName = string.Empty;
		_tutorialLastStepCompleted = false;
		_CharacterTutorialShowHighLight = false;
		_configuredEnergyApplyVersion++;
		_promptProcessId = 0;
		_lastTeamTutorialTargetMidTipNodeId = 0;
		HighLightCountDataDic?.Clear();
		ResetConfiguredEnergyCache();
	}

	protected override void OnDestroy()
	{
		AssetStationManager.Root.Release(_characterTutorialHandle);
		AssetStationManager.Root.Release(_characterTeamTutorialHandle);
	}

	private void AddCharacterTutorialEventListener()
	{
		if (!_characterTutorialEventListenersAdded)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterStateChange, OnCharacterStateChange);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterTutorial_AddAbility, OnCharacterAddAbility);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterTutorial_RemoveAbility, OnCharacterRemoveAbility);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterTutorial_PerfectDodge, OnPerfectDodge);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterTutorial_EnemyDie, OnEnemyDie);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterTutorial_EnemyWeak, OnEnemyWeak);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnBattleCharacterChange);
			_characterTutorialEventListenersAdded = true;
		}
	}

	private void RemoveCharacterTutorialEventListener()
	{
		if (_characterTutorialEventListenersAdded)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterStateChange, OnCharacterStateChange);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterTutorial_AddAbility, OnCharacterAddAbility);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterTutorial_RemoveAbility, OnCharacterRemoveAbility);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterTutorial_PerfectDodge, OnPerfectDodge);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterTutorial_EnemyDie, OnEnemyDie);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterTutorial_EnemyWeak, OnEnemyWeak);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnBattleCharacterChange);
			_characterTutorialEventListenersAdded = false;
		}
	}

	public void StartCharacterTutorial(int id)
	{
		if (!HasTutorial && !(_configs == null))
		{
			CharacterTutorialConfig config = _configs.GetConfig(id);
			if (!(config == null))
			{
				_currentCharacterTutorialId = id;
				_tutorialSessionVersion++;
				MainCharacterTutorialId = id;
				CharacterTutorialTeamIds = Array.Empty<int>();
				TutorialMode = CharacterTutorialMode.Single;
				_tutorialLastStepCompleted = false;
				_curCharacterTutorialData = new CharacterTutorialData(config);
				_inCharacterTutorial = true;
				_onTutorialStart?.Invoke();
				AddCharacterTutorialEventListener();
			}
		}
	}

	public void StartCharacterTeamTutorial(int id)
	{
		if (!HasTutorial && !(_teamConfigs == null))
		{
			CharacterTeamTutorialConfig config = _teamConfigs.GetConfig(id);
			if (!(config == null))
			{
				_currentCharacterTutorialId = id;
				_tutorialSessionVersion++;
				CharacterTutorialTeamIds = GetCurrentRaidTryRoles();
				MainCharacterTutorialId = ((CharacterTutorialTeamIds.Length != 0) ? CharacterTutorialTeamIds[0] : id);
				TutorialMode = CharacterTutorialMode.Team;
				_tutorialLastStepCompleted = false;
				_curCharacterTutorialData = new CharacterTutorialData(config);
				_inCharacterTutorial = true;
				_onCharacterTeamTutorialStart?.Invoke();
				AddCharacterTutorialEventListener();
			}
		}
	}

	public async UniTask RefreshCharacterTeamTutorialInteractTarget(float holdSeconds)
	{
		if (InCharacterTeamTutorial)
		{
			_onInteractRefresh?.Invoke();
			if (!(holdSeconds <= 0f))
			{
				await UniTask.Delay(TimeSpan.FromSeconds(holdSeconds));
			}
		}
	}

	public void FinishCharacterTutorial()
	{
		FinishCharacterTutorialInternal(CharacterTutorialMode.Single);
	}

	public void FinishCharacterTeamTutorial()
	{
		FinishCharacterTutorialInternal(CharacterTutorialMode.Team);
	}

	private void FinishActiveCharacterTutorial()
	{
		FinishCharacterTutorialInternal(TutorialMode);
	}

	private async void FinishCharacterTutorialInternal(CharacterTutorialMode finishMode)
	{
		if (!HasTutorial || TutorialMode != finishMode)
		{
			return;
		}
		int sessionVersion = _tutorialSessionVersion;
		await UniTask.Delay(TimeSpan.FromSeconds(0.5));
		if (HasTutorial && TutorialMode == finishMode && _tutorialSessionVersion == sessionVersion)
		{
			if (finishMode == CharacterTutorialMode.Team)
			{
				_onCharacterTeamTutorialFinish?.Invoke();
			}
			else
			{
				_onTutorialFinish?.Invoke();
			}
			RemoveCharacterTutorialEventListener();
			_curCharacterTutorialData = null;
			_curPromptProcessData = null;
			_curOperateNodeData = null;
			_inCharacterTutorial = false;
			_canOperate = false;
			_tutorialSessionVersion++;
			_promptProcessVersion++;
			TutorialMode = CharacterTutorialMode.Single;
			MainCharacterTutorialId = 0;
			CharacterTutorialTeamIds = Array.Empty<int>();
			_configuredEnergyApplyVersion++;
			HighLightCountDataDic.Clear();
			_lastTeamTutorialTargetMidTipNodeId = 0;
		}
	}

	public void StartPromptProcess(int promptProcessId)
	{
		if (!HasTutorial)
		{
			return;
		}
		int processVersion = ++_promptProcessVersion;
		if (HasProcess)
		{
			_curPromptProcessData = null;
			_curOperateNodeData = null;
			_listenAbilityName = string.Empty;
			_configuredEnergyApplyVersion++;
			_canOperate = false;
			_CharacterTutorialShowHighLight = false;
			HighLightCountDataDic.Clear();
			_onPromptProcessChanged?.Invoke(null);
		}
		_promptProcessId = promptProcessId;
		_lastTeamTutorialTargetMidTipNodeId = 0;
		_curPromptProcessData = _curCharacterTutorialData.GetPromptProcessData(promptProcessId);
		if (_curPromptProcessData != null)
		{
			_listenAbilityName = string.Empty;
			_canOperate = true;
			_onPromptProcessChanged?.Invoke(_curPromptProcessData);
			_promotProcessStartTime = System.DateTime.Now;
			TeachingTrainGround evt = EventTrackSolver.Instance.GetEvt<TeachingTrainGround>();
			evt.status = 2;
			evt.processId = promptProcessId;
			evt.result = 1;
			EventTrackSolver.Instance.Dispatch(evt);
			if (InCharacterTeamTutorial)
			{
				StartFirstNode();
			}
			else
			{
				StartFirstNodeDeferred(processVersion).Forget();
			}
		}
	}

	private async UniTaskVoid StartFirstNodeDeferred(int processVersion)
	{
		await UniTask.NextFrame();
		if (HasTutorial && HasProcess && _promptProcessVersion == processVersion)
		{
			StartFirstNode();
		}
	}

	public void FinishPromptProcess()
	{
		if (HasTutorial && HasProcess)
		{
			int id = _curPromptProcessData.id;
			bool flag = _curCharacterTutorialData.IsLastProcess(_curPromptProcessData.id);
			if (flag)
			{
				_tutorialLastStepCompleted = true;
			}
			_curPromptProcessData = null;
			_curOperateNodeData = null;
			_promptProcessVersion++;
			_listenAbilityName = string.Empty;
			_configuredEnergyApplyVersion++;
			_lastTeamTutorialTargetMidTipNodeId = 0;
			_canOperate = false;
			_onPromptProcessChanged?.Invoke(null);
			CharacterTutorialProcessFinishEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterTutorialProcessFinishEvt>();
			evt.finishProcessId = id;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterTutorial_ProcessFinish, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			if (flag)
			{
				FinishActiveCharacterTutorial();
			}
			TeachingTrainGround evt2 = EventTrackSolver.Instance.GetEvt<TeachingTrainGround>();
			evt2.status = 3;
			evt2.processId = id;
			evt2.result = 1;
			evt2.eventDuration = (float)(System.DateTime.Now - _promotProcessStartTime).TotalSeconds;
			EventTrackSolver.Instance.Dispatch(evt2);
		}
	}

	private void NodeSuccess()
	{
		if (HasTutorial && HasProcess)
		{
			bool flag = _curPromptProcessData.IsLastNode(_curOperateNodeData);
			_onOperateNodeSuccess?.Invoke(_curOperateNodeData, flag);
			if (!flag)
			{
				ToNextNode();
			}
			else
			{
				FinishPromptProcess();
			}
		}
	}

	private void NodeFail()
	{
		if (HasTutorial && HasProcess)
		{
			OperateNodeData curOperateNodeData = _curOperateNodeData;
			_curOperateNodeData = _curPromptProcessData.BackToNode(_curOperateNodeData);
			_onOperateNodeFail?.Invoke(curOperateNodeData, _curOperateNodeData);
			BackToNode();
		}
	}

	private void ToNextNode()
	{
		if (!HasTutorial || !HasProcess || !_curPromptProcessData.ToNextNode(out _curOperateNodeData))
		{
			return;
		}
		MarkEnterOperateNode();
		int currentTutorialConfigId = GetCurrentTutorialConfigId();
		if (IsShowSecondEnergyHighLight(currentTutorialConfigId))
		{
			if (HighLightCountDataDic.TryGetValue(currentTutorialConfigId, out var value))
			{
				if (value.nodeId == currentTutorialConfigId)
				{
					if (value.isOpened)
					{
						_onToNextOperateNode?.Invoke(_curOperateNodeData);
						OnEnterOperateNode();
					}
					return;
				}
				ShowTutorialHighLight(currentTutorialConfigId, isNodeEnd: false);
			}
			else
			{
				ShowTutorialHighLight(currentTutorialConfigId, isNodeEnd: false);
			}
		}
		_onToNextOperateNode?.Invoke(_curOperateNodeData);
		OnEnterOperateNode();
	}

	private void ShowTutorialHighLight(int processId, bool isNodeEnd)
	{
		if (InCharacterTeamTutorial)
		{
			ShowTeamTutorialHighLight(processId, isNodeEnd);
			return;
		}
		NodeMessage data = CoreUtils.GetData(processId, RuntimeConfigs.data.nodeMessages);
		if (data != null && data.triggerTiming != 0)
		{
			int triggerTiming = data.triggerTiming;
			int delayTime = data.delayTime;
			if (triggerTiming == 1 && !isNodeEnd)
			{
				TriggerTutorialHighLight(processId, delayTime).Forget();
			}
			else if ((triggerTiming == 2) & isNodeEnd)
			{
				TriggerTutorialHighLight(processId, delayTime).Forget();
			}
		}
	}

	private void ShowTeamTutorialHighLight(int processId, bool isNodeEnd)
	{
		TeamAtackRutorial data = CoreUtils.GetData(processId, RuntimeConfigs.data.teamAtackRutorials);
		if (data != null && data.triggerTiming != 0)
		{
			int triggerTiming = data.triggerTiming;
			if (triggerTiming == 1 && !isNodeEnd)
			{
				TriggerTutorialHighLight(processId, 0).Forget();
			}
			else if ((triggerTiming == 2) & isNodeEnd)
			{
				TriggerTutorialHighLight(processId, 0).Forget();
			}
		}
	}

	private void TryShowTeamTutorialTargetMidTip(int nodeId)
	{
		if (InCharacterTeamTutorial && nodeId != 0 && _lastTeamTutorialTargetMidTipNodeId != nodeId)
		{
			TeamAtackRutorial data = CoreUtils.GetData(nodeId, RuntimeConfigs.data.teamAtackRutorials);
			if (data == null || data.targetMidText == 0)
			{
				CloseCharacterTeamTutorialTip();
				return;
			}
			_lastTeamTutorialTargetMidTipNodeId = nodeId;
			Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_CHARACTERTEAMTUTORIAL, new CharacterTeamTutorialTipData
			{
				targetMidText = data.targetMidText,
				tableName = "longcommon",
				stayTime = data.stayTime
			});
		}
	}

	private void CloseCharacterTeamTutorialTip()
	{
		_lastTeamTutorialTargetMidTipNodeId = 0;
		Singleton<TipManager>.instance.WaitOpenTipQueueDic[TIP_TYPE.TIP_CHARACTERTEAMTUTORIAL].Clear();
		BaseTip tipDataByTipType = Singleton<TipManager>.instance.GetTipDataByTipType(TIP_TYPE.TIP_CHARACTERTEAMTUTORIAL);
		if (tipDataByTipType != null && tipDataByTipType.state < TipState.Closing)
		{
			tipDataByTipType.HideSelf();
		}
	}

	private async UniTaskVoid TriggerTutorialHighLight(int processId, int delayTime)
	{
		_CharacterTutorialShowHighLight = true;
		if (delayTime > 0)
		{
			await UniTask.Delay(delayTime);
			if (!HasTutorial || !HasProcess || !_CharacterTutorialShowHighLight)
			{
				return;
			}
		}
		_onOperateNodeSecondEnergyShowDesc?.Invoke(processId);
	}

	public void HighLightCountDataDicAdd(bool isOpened)
	{
		if (HasTutorial && HasProcess && HasNode)
		{
			int currentTutorialConfigId = GetCurrentTutorialConfigId();
			if (HighLightCountDataDic.TryGetValue(currentTutorialConfigId, out var _))
			{
				HighLightCountDataDic[currentTutorialConfigId] = new HighLightCountData
				{
					nodeId = currentTutorialConfigId,
					isOpened = isOpened
				};
			}
			else
			{
				HighLightCountDataDic.Add(currentTutorialConfigId, new HighLightCountData
				{
					nodeId = currentTutorialConfigId,
					isOpened = isOpened
				});
			}
		}
	}

	private void StartFirstNode()
	{
		if (HasTutorial && HasProcess)
		{
			_curOperateNodeData = _curPromptProcessData.StartFirstNode();
			MarkEnterOperateNode();
			_onToNextOperateNode?.Invoke(_curOperateNodeData);
			OnEnterOperateNode();
		}
	}

	private void BackToNode()
	{
		if (HasTutorial && HasProcess)
		{
			_curOperateNodeData = _curPromptProcessData.BackToNode(_curOperateNodeData);
			MarkEnterOperateNode();
			_onOperateNodeBackTo?.Invoke(_curOperateNodeData);
			OnEnterOperateNode();
		}
	}

	private void OnEnterOperateNode()
	{
		if (!HasTutorial || !HasProcess || !_canOperate || _curOperateNodeData == null)
		{
			return;
		}
		MarkEnterOperateNode();
		int currentTutorialConfigId = GetCurrentTutorialConfigId();
		TryShowTeamTutorialTargetMidTip(currentTutorialConfigId);
		TryApplyConfiguredEnergyOnNodeStart();
		if (IsShowSecondEnergyHighLight(currentTutorialConfigId))
		{
			if (HighLightCountDataDic.TryGetValue(currentTutorialConfigId, out var value))
			{
				if (value.nodeId == currentTutorialConfigId)
				{
					if (value.isOpened && _curOperateNodeData.IsSuccessOnEnter())
					{
						NodeSuccess();
					}
					return;
				}
				ShowTutorialHighLight(currentTutorialConfigId, isNodeEnd: false);
			}
			else
			{
				ShowTutorialHighLight(currentTutorialConfigId, isNodeEnd: false);
			}
		}
		if (_curOperateNodeData.IsSuccessOnEnter())
		{
			NodeSuccess();
		}
	}

	private bool InIgnoreFailWindow()
	{
		return Time.realtimeSinceStartup - _operateNodeEnterRealtime <= 0.1f;
	}

	private void OnCharacterStateChange(BaseEventContent eventContent)
	{
		if (eventContent is CharacterStateChangeEvt characterStateChangeEvt)
		{
			CharacterStateEventData eventData = new CharacterStateEventData(characterStateChangeEvt.characterId, characterStateChangeEvt.characterState);
			OnReceiveEvent(eventData);
		}
	}

	private void OnCharacterAddAbility(BaseEventContent eventContent)
	{
		if (eventContent is CharacterTutorialAddAbilityEvt characterTutorialAddAbilityEvt)
		{
			CharacterAddAbilityEventData eventData = new CharacterAddAbilityEventData(characterTutorialAddAbilityEvt.characterId, characterTutorialAddAbilityEvt.abilityName);
			OnReceiveEvent(eventData);
		}
	}

	private void OnCharacterRemoveAbility(BaseEventContent eventContent)
	{
		if (eventContent is CharacterTutorialRemoveAbilityEvt characterTutorialRemoveAbilityEvt && _listenAbilityName == characterTutorialRemoveAbilityEvt.abilityName && !_CharacterTutorialShowHighLight && !InIgnoreFailWindow())
		{
			NodeFail();
		}
	}

	private void OnPerfectDodge(BaseEventContent eventContent)
	{
		if (eventContent is CharacterTutorialPerfectDodgeEvt characterTutorialPerfectDodgeEvt)
		{
			PerfectDodgeEventData eventData = new PerfectDodgeEventData(characterTutorialPerfectDodgeEvt.characterId);
			OnReceiveEvent(eventData);
		}
	}

	private void OnEnemyDie(BaseEventContent eventContent)
	{
		if (eventContent is CharacterTutorialEnemyDieEvt)
		{
			EnemyDieEventData eventData = new EnemyDieEventData();
			OnReceiveEvent(eventData);
		}
	}

	private void OnEnemyWeak(BaseEventContent eventContent)
	{
		if (eventContent is CharacterTutorialEnemyWeakEvt)
		{
			EnemyWeakEventData eventData = new EnemyWeakEventData();
			OnReceiveEvent(eventData);
		}
	}

	private void OnBattleCharacterChange(BaseEventContent eventContent)
	{
		if (eventContent is BattleCharacterChangeEvt { newEb: { IsValid: not false } newEb } battleCharacterChangeEvt && newEb.IsCharacter())
		{
			SwitchCharacterEventData eventData = new SwitchCharacterEventData(newEb.GetCompCharacter().characterSource.Id(), battleCharacterChangeEvt.switchSkill);
			OnReceiveEvent(eventData);
		}
	}

	private void OnReceiveEvent(CharacterTutorialEventData eventData)
	{
		if (!HasTutorial || !HasProcess || !HasNode || !_canOperate || !_curOperateNodeData.CanHandle(eventData))
		{
			return;
		}
		if (_curOperateNodeData.IsSuccess(eventData))
		{
			int currentTutorialConfigId = GetCurrentTutorialConfigId();
			if (IsShowSecondEnergyHighLight(currentTutorialConfigId))
			{
				if (HighLightCountDataDic.TryGetValue(currentTutorialConfigId, out var _))
				{
					NodeSuccess();
					return;
				}
				ShowTutorialHighLight(currentTutorialConfigId, isNodeEnd: true);
			}
			if (_CharacterTutorialShowHighLight)
			{
				HighLightClose();
			}
			else
			{
				NodeSuccess();
			}
		}
		else if (!_curOperateNodeData.IgnoreFailCondition && !_CharacterTutorialShowHighLight && !InIgnoreFailWindow())
		{
			NodeFail();
		}
	}

	public async void HighLightClose()
	{
		int sessionVersion = _tutorialSessionVersion;
		int processVersion = _promptProcessVersion;
		OperateNodeData operateNodeData = _curOperateNodeData;
		await UniTask.WaitUntil(() => !_CharacterTutorialShowHighLight);
		if (HasTutorial && HasProcess && HasNode && _tutorialSessionVersion == sessionVersion && _promptProcessVersion == processVersion && _curOperateNodeData == operateNodeData)
		{
			NodeSuccess();
		}
	}

	public void HideHighLight()
	{
		ToNextNode();
	}

	public int GetCharacterTutorialRaidNum()
	{
		RefreshOwnedCharacterTutorialRaidInfos();
		return _characterTutorialRaidInfos?.Count ?? 0;
	}

	public CharacterTutorialRaidInfo GetCharacterTutorialRaidInfo(int index)
	{
		RefreshOwnedCharacterTutorialRaidInfos();
		if (index > _characterTutorialRaidInfos.GetLastIndex())
		{
			return null;
		}
		return _characterTutorialRaidInfos[index];
	}

	public CharacterTutorialRaidInfo GetCharacterTutorialRaidInfoByCharacterId(int characterId)
	{
		RefreshOwnedCharacterTutorialRaidInfos();
		foreach (CharacterTutorialRaidInfo characterTutorialRaidInfo in _characterTutorialRaidInfos)
		{
			if (characterTutorialRaidInfo.CharacterId == characterId)
			{
				return characterTutorialRaidInfo;
			}
		}
		return null;
	}

	public bool IsCharacterTutorialCompleted(int characterId)
	{
		if (characterId <= 0)
		{
			return false;
		}
		CharacterTutorialRaidInfo characterTutorialRaidInfoByCharacterId = GetCharacterTutorialRaidInfoByCharacterId(characterId);
		if (characterTutorialRaidInfoByCharacterId != null && characterTutorialRaidInfoByCharacterId.RaidId > 0)
		{
			ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(characterTutorialRaidInfoByCharacterId.RaidId);
			if (raidInfo != null)
			{
				return raidInfo.CleanNum > 0;
			}
			return false;
		}
		return false;
	}

	public void EnterCharacterTutorialRaid(int characterId)
	{
		if (characterId <= 0)
		{
			return;
		}
		CharacterTutorialRaidInfo characterTutorialRaidInfoByCharacterId = GetCharacterTutorialRaidInfoByCharacterId(characterId);
		if (characterTutorialRaidInfoByCharacterId == null || characterTutorialRaidInfoByCharacterId.RaidId <= 0)
		{
			return;
		}
		MonoECS.instance.SyncGameInfos();
		TeamUsage raidTrialTeamUsage = Model<RaidModel>.Interface.GetRaidTrialTeamUsage(characterTutorialRaidInfoByCharacterId.RaidId);
		if (raidTrialTeamUsage == null)
		{
			return;
		}
		G.service.RaidEnterInfo(characterTutorialRaidInfoByCharacterId.RaidId, raidTrialTeamUsage, async (bool success) =>
		{
			if (success)
			{
				Model<TeamTeachingModel>.Interface.ClearCurrentTrainingContent();
				await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
			}
		});
	}

	public int GetCharacterTeamTutorialRaidNum()
	{
		return _characterTeamTutorialRaidInfos?.Count ?? 0;
	}

	public CharacterTutorialRaidInfo GetCharacterTeamTutorialRaidInfo(int index)
	{
		if (_characterTeamTutorialRaidInfos == null || index < 0 || index > _characterTeamTutorialRaidInfos.GetLastIndex())
		{
			return null;
		}
		return _characterTeamTutorialRaidInfos[index];
	}

	public IReadOnlyList<CharacterTutorialRaidInfo> GetCharacterTeamTutorialRaidInfos()
	{
		return _characterTeamTutorialRaidInfos;
	}

	public IReadOnlyList<CharacterTutorialRaidInfo> GetCharacterTutorialRaidInfos()
	{
		RefreshOwnedCharacterTutorialRaidInfos();
		return _characterTutorialRaidInfos;
	}

	public bool CharacterTutorialIsComplete(CharacterTutorialRaidInfo info)
	{
		if (info == null)
		{
			return false;
		}
		ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(info.RaidId);
		if (raidInfo == null || raidInfo.CleanNum <= 0)
		{
			return false;
		}
		return true;
	}

	public bool IsCharacterTeamTutorialRaid(RaidEntranceData entranceData)
	{
		if (entranceData == null || entranceData.raidType != 6)
		{
			return false;
		}
		if (entranceData.raidId == null)
		{
			return false;
		}
		int[] raidId = entranceData.raidId;
		foreach (int key in raidId)
		{
			if (RuntimeConfigs.data.raids.TryGetValue(key, out var value))
			{
				int[] tryRole = value.tryRole;
				if (tryRole != null && tryRole.Length >= 2)
				{
					return true;
				}
			}
		}
		return false;
	}

	private static int[] GetCurrentRaidTryRoles()
	{
		ACT.Config.Raid data = CoreUtils.GetData(Model<RaidModel>.Interface.CurrentRaidId, RuntimeConfigs.data.raids);
		int[] array = data?.tryRole;
		if (array == null || array.Length <= 0)
		{
			return Array.Empty<int>();
		}
		int[] array2 = new int[data.tryRole.Length];
		Array.Copy(data.tryRole, array2, data.tryRole.Length);
		return array2;
	}

	public int GetNodeId()
	{
		if (!HasNode)
		{
			return 0;
		}
		return GetNodeId(_curOperateNodeData.Index);
	}

	public int GetNodeId(int nodeIndex)
	{
		if (!HasProcess)
		{
			return 0;
		}
		OperateNodeData node = _curPromptProcessData.GetNode(nodeIndex);
		if (node != null && node.MessageId > 0)
		{
			return node.MessageId;
		}
		return _promptProcessId * 100 + nodeIndex + 1;
	}

	private int GetCurrentTutorialConfigId()
	{
		if (!InCharacterTeamTutorial)
		{
			return GetNodeId();
		}
		return _promptProcessId;
	}

	public TeamAtackRutorial GetTeamAtackRutorial(int nodeId)
	{
		return CoreUtils.GetData(nodeId, RuntimeConfigs.data.teamAtackRutorials);
	}

	public bool IsShowSecondEnergyHighLight(int processId)
	{
		if (InCharacterTeamTutorial)
		{
			return IsShowTeamSecondEnergyHighLight(processId);
		}
		NodeMessage data = CoreUtils.GetData(processId, RuntimeConfigs.data.nodeMessages);
		if (data == null)
		{
			return false;
		}
		if (data.secondEnergyText > 0 || data.secondEnergyFrame.Length != 0)
		{
			return true;
		}
		return false;
	}

	private bool IsShowTeamSecondEnergyHighLight(int promptProcessId)
	{
		TeamAtackRutorial data = CoreUtils.GetData(promptProcessId, RuntimeConfigs.data.teamAtackRutorials);
		if (data == null)
		{
			return false;
		}
		if (data.targetText > 0 || data.targetFrame.Length != 0)
		{
			return true;
		}
		return false;
	}

	private void EnsureEnergyConfigCache()
	{
		if (_energyConfigCacheInitialized)
		{
			return;
		}
		Dictionary<int, Parameters> dictionary = RuntimeConfigs.data?.Parameterss;
		if (dictionary == null)
		{
			return;
		}
		_energyRowsByCharacterAndNode.Clear();
		foreach (KeyValuePair<int, Parameters> item in dictionary)
		{
			Parameters value = item.Value;
			(int, int) key = (value.characterID, value.nodeID);
			if (!_energyRowsByCharacterAndNode.TryGetValue(key, out var value2))
			{
				value2 = new List<Parameters>();
				_energyRowsByCharacterAndNode.Add(key, value2);
			}
			value2.Add(value);
		}
		foreach (List<Parameters> value3 in _energyRowsByCharacterAndNode.Values)
		{
			value3.Sort(CompareParametersEnergyApplyOrder);
		}
		_energyConfigCacheInitialized = true;
	}

	private void EnsureTeamEnergyConfigCache()
	{
		if (_teamEnergyConfigCacheInitialized)
		{
			return;
		}
		Dictionary<int, TeamParameters> dictionary = RuntimeConfigs.data?.teamParameterss;
		if (dictionary == null)
		{
			return;
		}
		_teamEnergyRowsByNode.Clear();
		foreach (KeyValuePair<int, TeamParameters> item in dictionary)
		{
			TeamParameters value = item.Value;
			if (!_teamEnergyRowsByNode.TryGetValue(value.nodeID, out var value2))
			{
				value2 = new List<TeamParameters>();
				_teamEnergyRowsByNode.Add(value.nodeID, value2);
			}
			value2.Add(value);
		}
		foreach (List<TeamParameters> value3 in _teamEnergyRowsByNode.Values)
		{
			value3.Sort(CompareTeamParametersEnergyApplyOrder);
		}
		_teamEnergyConfigCacheInitialized = true;
	}

	private void ResetConfiguredEnergyCache()
	{
		_energyRowsByCharacterAndNode.Clear();
		_teamEnergyRowsByNode.Clear();
		_energyConfigCacheInitialized = false;
		_teamEnergyConfigCacheInitialized = false;
	}

	private void TryApplyConfiguredEnergyOnNodeStart()
	{
		if (InCharacterTeamTutorial)
		{
			TryApplyConfiguredTeamEnergyOnNodeStart();
			return;
		}
		int characterTutorialId = CharacterTutorialId;
		if (characterTutorialId > 0)
		{
			int nodeId = GetNodeId();
			int applyVersion = ++_configuredEnergyApplyVersion;
			EnsureEnergyConfigCache();
			if (_energyRowsByCharacterAndNode.TryGetValue((characterTutorialId, nodeId), out var value))
			{
				ApplyConfiguredEnergyRows(value);
				ReapplyConfiguredEnergyAfterBlueprintUpdate(characterTutorialId, nodeId, applyVersion, value).Forget();
			}
		}
	}

	private void TryApplyConfiguredTeamEnergyOnNodeStart()
	{
		int promptProcessId = _promptProcessId;
		if (promptProcessId > 0)
		{
			int applyVersion = ++_configuredEnergyApplyVersion;
			EnsureTeamEnergyConfigCache();
			if (_teamEnergyRowsByNode.TryGetValue(promptProcessId, out var value))
			{
				ApplyConfiguredTeamEnergyRows(value);
				ReapplyConfiguredTeamEnergyAfterBlueprintUpdate(promptProcessId, applyVersion, value).Forget();
			}
		}
	}

	private async UniTaskVoid ReapplyConfiguredEnergyAfterBlueprintUpdate(int characterId, int nodeId, int applyVersion, List<Parameters> matches)
	{
		await UniTask.DelayFrame(2);
		if (HasTutorial && HasProcess && HasNode && _canOperate && CharacterTutorialId == characterId && GetNodeId() == nodeId && _configuredEnergyApplyVersion == applyVersion)
		{
			ApplyConfiguredEnergyRows(matches);
		}
	}

	private async UniTaskVoid ReapplyConfiguredTeamEnergyAfterBlueprintUpdate(int nodeId, int applyVersion, List<TeamParameters> matches)
	{
		await UniTask.DelayFrame(2);
		if (HasTutorial && HasProcess && HasNode && InCharacterTeamTutorial && _canOperate && GetNodeId() == nodeId && _configuredEnergyApplyVersion == applyVersion)
		{
			ApplyConfiguredTeamEnergyRows(matches);
		}
	}

	private void ApplyConfiguredEnergyRows(List<Parameters> matches)
	{
		foreach (Parameters match in matches)
		{
			switch ((EnergyType)match.type)
			{
			case EnergyType.Normal:
				TeamAttackCharging(GetConfiguredEnergyValue(match));
				break;
			case EnergyType.Special:
				TeamAttackSpecialCharging(GetConfiguredEnergyValue(match));
				break;
			case EnergyType.Customization:
				ApplyCustomizationEnergyFromParametersRow(match);
				break;
			}
		}
	}

	private void ApplyConfiguredTeamEnergyRows(List<TeamParameters> matches)
	{
		foreach (TeamParameters match in matches)
		{
			switch ((EnergyType)match.type)
			{
			case EnergyType.Normal:
				TeamAttackCharging(GetConfiguredEnergyValue(match));
				break;
			case EnergyType.Special:
				TeamAttackSpecialCharging(GetConfiguredEnergyValue(match));
				break;
			case EnergyType.Customization:
				ApplyCustomizationEnergyFromTeamParametersRow(match);
				break;
			case EnergyType.Buff:
				ApplyBuffFromTeamParametersRow(match);
				break;
			}
		}
	}

	private static int CompareParametersEnergyApplyOrder(Parameters a, Parameters b)
	{
		int energyTypeApplyOrder = GetEnergyTypeApplyOrder(a.type);
		int energyTypeApplyOrder2 = GetEnergyTypeApplyOrder(b.type);
		if (energyTypeApplyOrder != energyTypeApplyOrder2)
		{
			return energyTypeApplyOrder.CompareTo(energyTypeApplyOrder2);
		}
		int id = a.id;
		return id.CompareTo(b.id);
	}

	private static int CompareTeamParametersEnergyApplyOrder(TeamParameters a, TeamParameters b)
	{
		int energyTypeApplyOrder = GetEnergyTypeApplyOrder(a.type);
		int energyTypeApplyOrder2 = GetEnergyTypeApplyOrder(b.type);
		if (energyTypeApplyOrder != energyTypeApplyOrder2)
		{
			return energyTypeApplyOrder.CompareTo(energyTypeApplyOrder2);
		}
		int id = a.id;
		return id.CompareTo(b.id);
	}

	private static int GetEnergyTypeApplyOrder(int type)
	{
		return (EnergyType)type switch
		{
			EnergyType.Normal => 0, 
			EnergyType.Special => 1, 
			EnergyType.Customization => 2, 
			EnergyType.Buff => 3, 
			_ => 4, 
		};
	}

	private void ApplyCustomizationEnergyFromParametersRow(Parameters row)
	{
		CompMotion compMotion = MonoECS.instance.mainEntity.GetCompMotion();
		if (compMotion != null && !string.IsNullOrEmpty(row.name))
		{
			if (row.TypeValueTwo != 0f)
			{
				compMotion.SetFloat(row.name, row.TypeValueTwo);
			}
			else if (row.TypeValueThree)
			{
				compMotion.SetBool(row.name, row.TypeValueThree);
			}
			else
			{
				compMotion.SetInt(row.name, row.TypeValueOne);
			}
		}
	}

	private void ApplyCustomizationEnergyFromTeamParametersRow(TeamParameters row)
	{
		CompMotion compMotion = MonoECS.instance.mainEntity.GetCompMotion();
		if (compMotion != null && !string.IsNullOrEmpty(row.name))
		{
			if (row.TypeValueTwo != 0f)
			{
				compMotion.SetFloat(row.name, row.TypeValueTwo);
			}
			else if (row.TypeValueThree)
			{
				compMotion.SetBool(row.name, row.TypeValueThree);
			}
			else
			{
				compMotion.SetInt(row.name, row.TypeValueOne);
			}
		}
	}

	private void ApplyBuffFromTeamParametersRow(TeamParameters row)
	{
		if (string.IsNullOrEmpty(row.name))
		{
			return;
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (!mainEntity.IsValid)
		{
			return;
		}
		CompAbility compAbility = mainEntity.GetCompAbility();
		string[] abilities = new string[1] { row.name };
		if (row.TypeValueOne > 0)
		{
			for (int i = 0; i < row.TypeValueOne; i++)
			{
				compAbility.AddAbilities(abilities, AbilitySource.BluePrint);
				StageChallengeManager.localChallengeBuff.Add(row.name);
			}
			return;
		}
		compAbility.RemoveAbility(row.name);
		List<string> localChallengeBuff = StageChallengeManager.localChallengeBuff;
		if (localChallengeBuff.Contains(row.name))
		{
			localChallengeBuff.Remove(row.name);
		}
	}

	private float GetConfiguredEnergyValue(Parameters configValue)
	{
		if (configValue.TypeValueOne != 0)
		{
			return configValue.TypeValueOne;
		}
		if (configValue.TypeValueTwo != 0f)
		{
			return configValue.TypeValueTwo;
		}
		return 0f;
	}

	private float GetConfiguredEnergyValue(TeamParameters configValue)
	{
		if (configValue.TypeValueOne != 0)
		{
			return configValue.TypeValueOne;
		}
		if (configValue.TypeValueTwo != 0f)
		{
			return configValue.TypeValueTwo;
		}
		return 0f;
	}

	private void TeamAttackCharging(float val = float.MaxValue)
	{
		MPPlayer local = MPPlayer.local;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = local.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				teamCharacter.GetCompAbility().ModifyNormalEnergy(val);
			}
		}
	}

	public void TeamAttackSpecialCharging(float val = float.MaxValue)
	{
		MPPlayer local = MPPlayer.local;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = local.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				teamCharacter.GetCompAbility().ModifySpecialEnergy(val);
			}
		}
	}

	public void SetCharacterSpecialEnergyMaxWithType(int characterId, object value)
	{
		foreach (KeyValuePair<int, Parameters> item in RuntimeConfigs.data.Parameterss)
		{
			if (item.Value.characterID != characterId)
			{
				continue;
			}
			CompMotion compMotion = MonoECS.instance.mainEntity.GetCompMotion();
			if (compMotion == null)
			{
				break;
			}
			if (!(value is int i))
			{
				if (!(value is float f))
				{
					if (!(value is bool b))
					{
						if (!(value is string trigger))
						{
							throw new ArgumentException($"Unsupported value type: {value?.GetType()}");
						}
						compMotion.SetTrigger(trigger);
					}
					else
					{
						compMotion.SetBool(item.Value.name, b);
					}
				}
				else
				{
					compMotion.SetFloat(item.Value.name, f);
				}
			}
			else
			{
				compMotion.SetInt(item.Value.name, i);
			}
		}
	}
}
