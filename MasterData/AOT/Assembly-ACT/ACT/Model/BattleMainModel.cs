using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.UI;
using Fundamental;
using Runtime.Battle.ChaseBattle;
using UnityEngine;

namespace ACT.Model;

public class BattleMainModel : Model<BattleMainModel>
{
	public enum TaskTipDisableSourceEnum
	{
		ServerUIModule,
		BigWorld,
		WorldType
	}

	private bool _isCharacterTutorial;

	public List<int> curSubWorldHudTypeOpenSystems;

	private bool m_TaskTipStateCache = true;

	private Dictionary<TaskTipDisableSourceEnum, bool> m_TaskTipStates = new Dictionary<TaskTipDisableSourceEnum, bool>();

	private bool m_MiniMapModeDisabled;

	private bool m_BloodBarDisabled;

	private bool m_MoveModeDisabled;

	private bool m_SettingBtnDisabled;

	private bool _protagonistBtnDisabled;

	private bool _operateBtnDisabled;

	private bool _menuRootDisabled;

	private bool _leftTopMenuRootDisabled;

	private bool _characterBtnDisabled;

	private bool _littleItemDisabled;

	private PlayerPerspectiveState _playerPerspective;

	private Action<PlayerPerspectiveState> _perspectiveStateChange;

	public bool haveBossHatred;

	public UIQueueDisplayManager HudCpQueueManager;

	public HudType hudType { get; private set; }

	public bool isCharacterTutorial
	{
		get
		{
			return _isCharacterTutorial;
		}
		set
		{
			if (value != _isCharacterTutorial)
			{
				_isCharacterTutorial = value;
				hudType = ((!_isCharacterTutorial) ? HudType.RaidType : GetCharacterTutorialHudType());
				RefreshHUD?.Invoke();
			}
		}
	}

	public float bloodWarnPercent => RuntimeConfigs.data.game.characterLowHpPercent;

	public float bloodWarnEffectPercent => RuntimeConfigs.data.game.characterLowHpPercent;

	public bool needPopUpTextLibraryUnLockNumTip { get; set; }

	public bool MiniMapModeDisabled
	{
		get
		{
			if (!m_MiniMapModeDisabled)
			{
				return hudType != HudType.MainWorldType;
			}
			return true;
		}
		private set
		{
			m_MiniMapModeDisabled = value;
			OnMiniMapModeDisabledChangeEventHandler?.Invoke();
		}
	}

	public bool BloodBarDisabled
	{
		get
		{
			return m_BloodBarDisabled;
		}
		private set
		{
			m_BloodBarDisabled = value;
			OnBloodBarDisabledChangeEventHandler?.Invoke();
		}
	}

	public bool MoveModeDisabled
	{
		get
		{
			return m_MoveModeDisabled;
		}
		private set
		{
			m_MoveModeDisabled = value;
			OnMoveModeDisabledChangeEventHandler?.Invoke();
		}
	}

	public bool SettingBtnDisabled
	{
		get
		{
			return m_SettingBtnDisabled;
		}
		private set
		{
			m_SettingBtnDisabled = value;
			OnSettingBtnDisabledChangeEventHandler?.Invoke();
		}
	}

	public bool ProtagonistBtnDisabled
	{
		get
		{
			return _protagonistBtnDisabled;
		}
		private set
		{
			_protagonistBtnDisabled = value;
			OnProtagonistBtnDisabledChangeEventHandler?.Invoke();
		}
	}

	public bool OperateBtnDisabled
	{
		get
		{
			return _operateBtnDisabled;
		}
		private set
		{
			_operateBtnDisabled = value;
			OnOperateBtnDisabledChangeEventHandler?.Invoke();
		}
	}

	public bool MenuRootDisabled
	{
		get
		{
			return _menuRootDisabled;
		}
		private set
		{
			_menuRootDisabled = value;
			OnMenuRootDisabledChangeEventHandler?.Invoke();
		}
	}

	public bool LeftTopMenuRootDisabled
	{
		get
		{
			return _leftTopMenuRootDisabled;
		}
		private set
		{
			_leftTopMenuRootDisabled = value;
			OnLeftTopMenuRootDisabledChangeEventHandler?.Invoke();
		}
	}

	public bool CharacterBtnDisabled
	{
		get
		{
			return _characterBtnDisabled;
		}
		private set
		{
			_characterBtnDisabled = value;
			OnCharacterBtnDisabledChangeEventHandler?.Invoke();
		}
	}

	public bool LittleItemDisabled
	{
		get
		{
			return _littleItemDisabled;
		}
		private set
		{
			_littleItemDisabled = value;
			OnLittleItemDisabledChangeEventHandler?.Invoke();
		}
	}

	public PlayerPerspectiveState PlayerPerspective
	{
		get
		{
			return _playerPerspective;
		}
		private set
		{
			if (value != _playerPerspective)
			{
				_perspectiveStateChange?.Invoke(value);
			}
			_playerPerspective = value;
		}
	}

	public bool IsBack => PlayerPerspective == PlayerPerspectiveState.Back;

	public AddBossHatredEvt curBossHatredEvt { get; private set; }

	public UpdateLittleItemEvt curEquipBottleUIData { get; private set; } = new UpdateLittleItemEvt();

	public bool playerExpIsChange { get; private set; }

	public bool NeedReDisplay { get; private set; }

	public event Action RefreshHUD;

	public event Action OnTaskTipStateChangeEventHandler;

	public event Action OnMiniMapModeDisabledChangeEventHandler;

	public event Action OnBloodBarDisabledChangeEventHandler;

	public event Action OnMoveModeDisabledChangeEventHandler;

	public event Action OnSettingBtnDisabledChangeEventHandler;

	public event Action OnProtagonistBtnDisabledChangeEventHandler;

	public event Action OnOperateBtnDisabledChangeEventHandler;

	public event Action OnMenuRootDisabledChangeEventHandler;

	public event Action OnLeftTopMenuRootDisabledChangeEventHandler;

	public event Action OnCharacterBtnDisabledChangeEventHandler;

	public event Action OnLittleItemDisabledChangeEventHandler;

	public event Action<PlayerPerspectiveState> PerspectiveStateChange
	{
		add
		{
			_perspectiveStateChange = (Action<PlayerPerspectiveState>)Delegate.Combine(_perspectiveStateChange, value);
		}
		remove
		{
			_perspectiveStateChange = (Action<PlayerPerspectiveState>)Delegate.Remove(_perspectiveStateChange, value);
		}
	}

	private void RefreshTaskTipActive()
	{
		bool flag = true;
		foreach (KeyValuePair<TaskTipDisableSourceEnum, bool> taskTipState in m_TaskTipStates)
		{
			flag &= taskTipState.Value;
		}
		flag &= hudType == HudType.MainWorldType;
		if (flag != m_TaskTipStateCache)
		{
			m_TaskTipStateCache = flag;
			OnTaskTipStateChangeEventHandler?.Invoke();
		}
	}

	private bool GetTaskTipStateBySource(TaskTipDisableSourceEnum source)
	{
		return m_TaskTipStates.GetValueOrDefault(source, defaultValue: true);
	}

	public void SetTaskTipState(TaskTipDisableSourceEnum source, bool value)
	{
		if (!m_TaskTipStates.TryGetValue(source, out var value2) || value2 != value)
		{
			m_TaskTipStates[source] = value;
			RefreshTaskTipActive();
		}
	}

	public bool GetTaskTipActive()
	{
		return m_TaskTipStateCache;
	}

	protected override void Init()
	{
		curSubWorldHudTypeOpenSystems = ListPool<int>.Get();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change, OnSceneChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.HudTypeChange, OnHudTypeChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Boss_AddHatred, OnBossAddHatred);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Boss_RemoveHatred, OnBossRemoveHatred);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateBloodBottle, RefreshBloodBottleUIData);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PlayerExp_Change, OnPlayerExpChange);
		Model<BattleMainMarkModel>.CreateModel();
		Model<BattleMainMarkModelV2>.CreateModel();
		Model<BattleMainTaskTipModelV2>.CreateModel();
		InitUIModuleState();
		InitHudComponentPartitioningManager();
	}

	public void SetPlayerPerspective(PlayerPerspectiveState perspective)
	{
		PlayerPerspective = perspective;
	}

	private void OnHudTypeChange(BaseEventContent obj)
	{
		if (obj is HudTypeChangeEvt hudTypeChangeEvt)
		{
			ChangeHudType(hudTypeChangeEvt.hudType);
		}
	}

	private void OnSceneChange(BaseEventContent obj)
	{
		if (!(obj is SceneChangeEvt sceneChangeEvt))
		{
			return;
		}
		curSubWorldHudTypeOpenSystems.Clear();
		if (sceneChangeEvt.newScene != SceneStatus.Main)
		{
			curSubWorldHudTypeOpenSystems.Add(1036);
		}
		switch (sceneChangeEvt.newScene)
		{
		case SceneStatus.Main:
			_isCharacterTutorial = false;
			hudType = HudType.MainWorldType;
			break;
		case SceneStatus.Raid:
			hudType = GetRaidHudType();
			if (hudType == HudType.TeamTeaching || hudType == HudType.characterTutorial)
			{
				curSubWorldHudTypeOpenSystems.Add(1017);
			}
			break;
		case SceneStatus.Abyss:
			hudType = HudType.AbyssType;
			break;
		case SceneStatus.Trainingground:
			hudType = HudType.TrainingGroundType;
			curSubWorldHudTypeOpenSystems.Add(1017);
			curSubWorldHudTypeOpenSystems.Add(1013);
			break;
		case SceneStatus.Temple:
			hudType = HudType.TempleType;
			break;
		case SceneStatus.Rogue:
			hudType = HudType.RogueType;
			break;
		}
		RefreshHUD?.Invoke();
	}

	private HudType GetRaidHudType()
	{
		if (!Model<RaidModel>.HasInstance())
		{
			if (!_isCharacterTutorial)
			{
				return HudType.RaidType;
			}
			return HudType.characterTutorial;
		}
		if (Model<TeamTeachingModel>.HasInstance() && Model<TeamTeachingModel>.Interface.IsTeamTeachingRaid())
		{
			_isCharacterTutorial = false;
			return HudType.TeamTeaching;
		}
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		switch (Model<RaidModel>.Interface.GetRaidType(currentRaidId))
		{
		case 9:
			_isCharacterTutorial = false;
			return HudType.TeamTeaching;
		default:
			_isCharacterTutorial = false;
			return HudType.RaidType;
		case 6:
			_isCharacterTutorial = true;
			if (!IsCharacterTeamTutorialRaid(currentRaidId))
			{
				return HudType.characterTutorial;
			}
			return HudType.CharacterTeamTutorial;
		}
	}

	private HudType GetCharacterTutorialHudType()
	{
		if (!Model<RaidModel>.HasInstance())
		{
			return HudType.characterTutorial;
		}
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		if (!IsCharacterTeamTutorialRaid(currentRaidId))
		{
			return HudType.characterTutorial;
		}
		return HudType.CharacterTeamTutorial;
	}

	private bool IsCharacterTeamTutorialRaid(int raidId)
	{
		if (!RuntimeConfigs.data.raids.TryGetValue(raidId, out var value))
		{
			return false;
		}
		RaidEntranceData data = CoreUtils.GetData(raidId, RuntimeConfigs.data.raidEntranceDatas);
		if (data == null)
		{
			return false;
		}
		int[] tryRole = value.tryRole;
		if (tryRole != null && tryRole.Length >= 2)
		{
			return data.raidType == 6;
		}
		return false;
	}

	protected override void UnInit()
	{
		ListPool<int>.Release(curSubWorldHudTypeOpenSystems);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change, OnSceneChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.HudTypeChange, OnHudTypeChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Boss_AddHatred, OnBossAddHatred);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Boss_RemoveHatred, OnBossRemoveHatred);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateBloodBottle, RefreshBloodBottleUIData);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PlayerExp_Change, OnPlayerExpChange);
		RefreshHUD = null;
		UninitHudComponentPartitioningManager();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
	}

	public void ChangeHudType(HudType _hudType)
	{
		if (hudType != _hudType)
		{
			hudType = _hudType;
		}
		RefreshHUD?.Invoke();
	}

	public void UpdateEscItemRedDot(int systemId, bool active)
	{
		RefreshSystemUnlockRedDot evt = Singleton<EventManager>.instance.GetEvt<RefreshSystemUnlockRedDot>();
		evt.systemId = systemId;
		evt.isActive = active;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_RefreshHUDSystemOpenRedDot, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void InitUIModuleState()
	{
		if (!Model<ClientModuleModel>.HasInstance())
		{
			Model<ClientModuleModel>.CreateModel();
		}
		RefreshUIModuleState(UIMode.MiniMapMode);
		RefreshUIModuleState(UIMode.BloodMode);
		RefreshUIModuleState(UIMode.MoveMode);
		RefreshUIModuleState(UIMode.TaskMode);
		RefreshUIModuleState(UIMode.Setting);
		RefreshUIModuleState(UIMode.OperateBtnMode);
		RefreshUIModuleState(UIMode.MenuMode);
		RefreshUIModuleState(UIMode.CharacterBtnMode);
		RefreshUIModuleState(UIMode.LittleItemMode);
		RefreshUIModuleState(UIMode.ProtagonistBtnMode);
		RefreshUIModuleState(UIMode.LeftTopMenuMode);
	}

	public void RefreshUIModuleState(UIMode mode)
	{
		bool clientModule = Model<ClientModuleModel>.Interface.GetClientModule(ClientModuleModel.ClientModuleEnum.BattleMainUI, (int)mode);
		bool isProtagonist = Singleton<ProtagonistManager>.instance.IsProtagonist;
		switch (mode)
		{
		case UIMode.MiniMapMode:
			if (!Singleton<SystemUnlockManager>.instance.IsUnlock(1028))
			{
				MiniMapModeDisabled = true;
			}
			else
			{
				MiniMapModeDisabled = !clientModule | isProtagonist;
			}
			break;
		case UIMode.BloodMode:
			BloodBarDisabled = !clientModule | isProtagonist;
			break;
		case UIMode.MoveMode:
			MoveModeDisabled = !clientModule;
			break;
		case UIMode.TaskMode:
			SetTaskTipState(TaskTipDisableSourceEnum.ServerUIModule, clientModule);
			break;
		case UIMode.Setting:
			SettingBtnDisabled = !clientModule | isProtagonist;
			break;
		case UIMode.OperateBtnMode:
			OperateBtnDisabled = !clientModule;
			break;
		case UIMode.MenuMode:
			MenuRootDisabled = !clientModule | isProtagonist;
			break;
		case UIMode.CharacterBtnMode:
			CharacterBtnDisabled = !clientModule | isProtagonist;
			break;
		case UIMode.LittleItemMode:
			LittleItemDisabled = (!clientModule | isProtagonist) || (Model<BloodBottleModel>.HasInstance() && Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId == 0);
			break;
		case UIMode.ProtagonistBtnMode:
			ProtagonistBtnDisabled = !clientModule || !isProtagonist;
			break;
		case UIMode.LeftTopMenuMode:
			LeftTopMenuRootDisabled = (IsBack || hudType != HudType.MainWorldType || !clientModule) | isProtagonist;
			break;
		default:
			throw new NotImplementedException("不支持的类型！");
		}
	}

	private void OnBossRemoveHatred(BaseEventContent obj)
	{
		if (obj is RemoveBossHatredEvt)
		{
			haveBossHatred = false;
			curBossHatredEvt = null;
			if (Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_BATTLEMAIN, out var ui) && ui.GetUIView() is MonoBattleMainBaseView { bossInfoComp: { } bossInfoComp })
			{
				bossInfoComp.UnloadBossBloodBar();
			}
		}
	}

	private void OnBossAddHatred(BaseEventContent obj)
	{
		if (obj is AddBossHatredEvt addBossHatredEvt && !Singleton<ChaseBattleManager>.instance.IsInChaseBattle)
		{
			haveBossHatred = true;
			curBossHatredEvt = new AddBossHatredEvt();
			curBossHatredEvt.entityId = addBossHatredEvt.entityId;
			curBossHatredEvt.id = addBossHatredEvt.id;
			curBossHatredEvt.level = addBossHatredEvt.level;
			curBossHatredEvt.basicMaxHp = addBossHatredEvt.basicMaxHp;
			curBossHatredEvt.curMaxHp = addBossHatredEvt.curMaxHp;
			curBossHatredEvt.curHp = addBossHatredEvt.curHp;
			curBossHatredEvt.curHpPercentage = addBossHatredEvt.curHpPercentage;
			curBossHatredEvt.inPosture = addBossHatredEvt.inPosture;
			curBossHatredEvt.maxPosture = addBossHatredEvt.maxPosture;
			curBossHatredEvt.curPosture = addBossHatredEvt.curPosture;
			curBossHatredEvt.curPosturePercentage = addBossHatredEvt.curPosturePercentage;
			curBossHatredEvt.inWeak = addBossHatredEvt.inWeak;
			curBossHatredEvt.curWeakPercentage = addBossHatredEvt.curWeakPercentage;
			curBossHatredEvt.inBurst = addBossHatredEvt.inBurst;
			curBossHatredEvt.maxBurst = addBossHatredEvt.maxBurst;
			curBossHatredEvt.curBurst = addBossHatredEvt.curBurst;
			curBossHatredEvt.curBurstPercentage = addBossHatredEvt.curBurstPercentage;
			curBossHatredEvt.damageType = addBossHatredEvt.damageType;
			curBossHatredEvt.shareBossInfoUI = addBossHatredEvt.shareBossInfoUI;
			curBossHatredEvt.bossInfoGroupUid = addBossHatredEvt.bossInfoGroupUid;
			if (Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_BATTLEMAIN, out var ui) && ui.GetUIView() is MonoBattleMainBaseView { bossInfoComp: { } bossInfoComp })
			{
				bossInfoComp.OnBossAddHatred(addBossHatredEvt);
			}
		}
	}

	private void RefreshBloodBottleUIData(BaseEventContent obj)
	{
		if (obj is UpdateLittleItemEvt updateLittleItemEvt)
		{
			curEquipBottleUIData.bottleUid = updateLittleItemEvt.bottleUid;
			curEquipBottleUIData.itemId = updateLittleItemEvt.itemId;
		}
	}

	private void OnPlayerExpChange(BaseEventContent obj)
	{
		playerExpIsChange = true;
	}

	public void NeedReDisplayPlayerExp()
	{
		if (!playerExpIsChange)
		{
			NeedReDisplay = false;
		}
		else
		{
			NeedReDisplay = true;
		}
	}

	public void RestExpReDisplayState()
	{
		NeedReDisplay = false;
		playerExpIsChange = false;
	}

	public void InitHudComponentPartitioningManager()
	{
		if (HudCpQueueManager == null)
		{
			HudCpQueueManager = new UIQueueDisplayManager();
			HudCpQueueManager.EnablePriority(UIPosition.Center);
			HudCpQueueManager.GetSetting(UIPosition.UpperMiddle).IgnorePriorityRule = true;
			HudCpQueueManager.GetSetting(UIPosition.LowerMiddle).IgnorePriorityRule = true;
			HudCpQueueManager.GetSetting(UIPosition.MiddleBottom).IgnorePriorityRule = true;
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_HudUIEnqueue, OnUIEnqueue);
		}
	}

	public void UninitHudComponentPartitioningManager()
	{
		if (HudCpQueueManager != null)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_HudUIEnqueue, OnUIEnqueue);
			HudCpQueueManager = null;
		}
	}

	private void OnUIEnqueue(BaseEventContent obj)
	{
		if (obj is OnHudCpEnqueue onHudCpEnqueue)
		{
			HudPositionUIEnqueue(onHudCpEnqueue.position, onHudCpEnqueue.type, onHudCpEnqueue.uiData, onHudCpEnqueue.timeOutDuration, onHudCpEnqueue.priorityInQueue, onHudCpEnqueue.ignorePriorityRule, onHudCpEnqueue.clearQueueByCpItemType, onHudCpEnqueue.positionOffset);
		}
	}

	public void HudPositionUIEnqueue(UIPosition position, HudComponentType cpType, object data, float timeoutSeconds = 0f, int priorityInQueue = 0, bool ignorePriorityRule = false, bool clearQueueByCpTypeBeforeEnter = false, Vector2 posOffset = default(Vector2))
	{
		if (HudCpQueueManager == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("HudComponentPartitioningManager 未初始化");
			}
			return;
		}
		if (clearQueueByCpTypeBeforeEnter)
		{
			HudCpQueueManager.ClearQueueItemsByCpType(position, cpType);
		}
		HudCpQueueItem item = new HudCpQueueItem
		{
			Position = position,
			TimeoutSeconds = timeoutSeconds,
			IgnorePriorityRule = ignorePriorityRule,
			Priority = priorityInQueue,
			HudComponentType = cpType,
			HudComponentUIData = data,
			ComponentPositionOffset = posOffset
		};
		HudCpQueueManager.EnqueueHudCp(item);
	}

	public void HudPositionUIDequeue(UIPosition position)
	{
		if (HudCpQueueManager != null)
		{
			HudCpQueueManager.DequeueHudCp(position);
		}
	}

	public void EnablePriority(UIPosition priorityPosition)
	{
		if (HudCpQueueManager == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("HudComponentPartitioningManager 未初始化");
			}
		}
		else
		{
			HudCpQueueManager.EnablePriority(priorityPosition);
		}
	}

	public void DisablePriority()
	{
		if (HudCpQueueManager != null)
		{
			HudCpQueueManager.DisablePriority();
		}
	}

	public void SetIgnorePriorityRule(UIPosition position, bool ignore)
	{
		if (HudCpQueueManager == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("HudComponentPartitioningManager 未初始化");
			}
		}
		else
		{
			HudCpQueueManager.GetSetting(position).IgnorePriorityRule = ignore;
		}
	}
}
