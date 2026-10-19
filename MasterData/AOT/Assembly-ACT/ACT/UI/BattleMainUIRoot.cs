using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class BattleMainUIRoot : MonoBehaviour, IBattleMainComponent
{
	private MonoBattleMainBaseView _view;

	private HudType curHudType => Model<BattleMainModel>.Interface.hudType;

	public void Initialize(MonoBattleMainBaseView view)
	{
		_view = view;
		GameUtility.npcInfoRoot.gameObject.SetActive(value: true);
		Model<BattleMainModel>.Interface.RefreshHUD += ChangeCurHudState;
		Model<BattleMainModel>.Interface.OnSettingBtnDisabledChangeEventHandler += OnSettingBtnDisabledChangeEventHandler;
		Model<BattleMainModel>.Interface.PerspectiveStateChange += SetPerspectiveUIRoot;
		Singleton<ProtagonistManager>.instance.PlayerControlStateChange += OnPlayerControlStateChange;
	}

	public void UnInitialize()
	{
		GameUtility.npcInfoRoot.gameObject.SetActive(value: false);
		Model<BattleMainModel>.Interface.RefreshHUD -= ChangeCurHudState;
		Model<BattleMainModel>.Interface.OnSettingBtnDisabledChangeEventHandler -= OnSettingBtnDisabledChangeEventHandler;
		Model<BattleMainModel>.Interface.PerspectiveStateChange -= SetPerspectiveUIRoot;
		Singleton<ProtagonistManager>.instance.PlayerControlStateChange -= OnPlayerControlStateChange;
		RemoveEventManagerListeners();
	}

	private void AddEventManagerListeners()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.LeftBtn_Hide, OnHideLeaveBtn);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleMainRefreshCanvasGroup, OnBattleMainRefreshCanvasGroup);
	}

	private void RemoveEventManagerListeners()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.LeftBtn_Hide, OnHideLeaveBtn);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleMainRefreshCanvasGroup, OnBattleMainRefreshCanvasGroup);
	}

	private void OnSettingBtnDisabledChangeEventHandler()
	{
		if (!_view.IsDestroyed)
		{
			bool settingBtnDisabled = Model<BattleMainModel>.Interface.SettingBtnDisabled;
			_view.EscButton.SetActive(!settingBtnDisabled);
		}
	}

	private void OnPlayerControlStateChange(PlayerControlState obj)
	{
		Model<BattleMainModel>.Interface.InitUIModuleState();
	}

	public void OpenComponent()
	{
		ChangeCurHudState();
		ChangeMainUIState(state: true);
		AddEventManagerListeners();
	}

	public void CloseComponent()
	{
		_view.missionInstruction.SetActive(value: false);
		RemoveEventManagerListeners();
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	public void ChangeCurHudState()
	{
		RefreshHUDTopUIDisPlay();
		_view.RefreshCharacterEntryRedDotVisibility();
		UpdateUICanvasGroupState(_view.customUIRoot, active: true);
		UpdateUICanvasGroupState(_view.BattleStateRoot, active: true);
		UpdateUICanvasGroupState(_view.menuRoot, !Model<BattleMainModel>.Interface.IsBack);
		UpdateSubWorldUIState();
		switch (curHudType)
		{
		case HudType.MainWorldType:
			EventSystemHelper.SetSelectedGameObject(null);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RefreshEscitem, null);
			_view.taskManager.OnBattleMainCompletelyShow();
			GameUtility.RefreshItemRedDot();
			_view.miniMapNew.Init(_view.Station);
			break;
		case HudType.hideBattleUIType:
			UpdateUICanvasGroupState(_view.customUIRoot, active: false);
			UpdateUICanvasGroupState(_view.BattleStateRoot, active: false);
			break;
		case HudType.RaidType:
		case HudType.characterTutorial:
		case HudType.CharacterTeamTutorial:
		case HudType.TeamTeaching:
		{
			InRaidInfo evt5 = Singleton<EventManager>.instance.GetEvt<InRaidInfo>();
			evt5.showsEscItemSystemIds = Model<BattleMainModel>.Interface.curSubWorldHudTypeOpenSystems;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.EnterRaid, evt5);
			Singleton<EventManager>.instance.ReleaseEvt(evt5);
			break;
		}
		case HudType.TempleType:
		{
			InTempleInfo evt4 = Singleton<EventManager>.instance.GetEvt<InTempleInfo>();
			evt4.showsEscItemSystemIds = Model<BattleMainModel>.Interface.curSubWorldHudTypeOpenSystems;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.TempleInstance, evt4);
			Singleton<EventManager>.instance.ReleaseEvt(evt4);
			break;
		}
		case HudType.AbyssType:
		{
			InAbyssInfo evt3 = Singleton<EventManager>.instance.GetEvt<InAbyssInfo>();
			evt3.showsEscItemSystemIds = Model<BattleMainModel>.Interface.curSubWorldHudTypeOpenSystems;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.EnterAbyss, evt3);
			Singleton<EventManager>.instance.ReleaseEvt(evt3);
			break;
		}
		case HudType.TrainingGroundType:
		{
			InTrainingGroundInfo evt2 = Singleton<EventManager>.instance.GetEvt<InTrainingGroundInfo>();
			evt2.showsEscItemSystemIds = Model<BattleMainModel>.Interface.curSubWorldHudTypeOpenSystems;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.EnterTrainingGround, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
			break;
		}
		case HudType.RogueType:
		{
			InRogueInfo evt = Singleton<EventManager>.instance.GetEvt<InRogueInfo>();
			evt.showsEscItemSystemIds = Model<BattleMainModel>.Interface.curSubWorldHudTypeOpenSystems;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.EnterRogue, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			break;
		}
		}
	}

	private void RefreshHUDTopUIDisPlay()
	{
		bool flag = Model<BattleMainModel>.Interface.hudType == HudType.MainWorldType || Model<BattleMainModel>.Interface.hudType == HudType.hideBattleUIType;
		HudType hudType = Model<BattleMainModel>.Interface.hudType;
		if (hudType == HudType.RaidType || (uint)(hudType - 4) <= 1u)
		{
			RuntimeConfigs.data.raids.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value);
			Model<BattleMainModel>.Interface.SetTaskTipState(BattleMainModel.TaskTipDisableSourceEnum.WorldType, value != null && value.bindMissionGroupId != 0);
		}
		else
		{
			Model<BattleMainModel>.Interface.SetTaskTipState(BattleMainModel.TaskTipDisableSourceEnum.WorldType, flag);
		}
		Model<BattleMainModel>.Interface.RefreshUIModuleState(UIMode.MiniMapMode);
		Model<BattleMainModel>.Interface.RefreshUIModuleState(UIMode.LeftTopMenuMode);
		UpdateUICanvasGroupState(_view.subWorldRoot, !flag);
		_view.LeaveSubWorldBtn.SetActive(!flag);
	}

	private void UpdateUICanvasGroupState(CanvasGroup group, bool active)
	{
		if (!(group == null))
		{
			group.alpha = (active ? 1 : 0);
			group.interactable = active;
			group.blocksRaycasts = active;
		}
	}

	private void UpdateSubWorldUIState()
	{
		RuntimeConfigs.data.raids.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value);
		_view.raidSceneUI.SetActive(GetRaidSceneUIVisible(value));
		_view.trainingGroundUI.SetActive(curHudType == HudType.TrainingGroundType);
		_view.templeUI?.gameObject.SetActive(curHudType == HudType.TempleType);
		_view.abyssUI.SetActive(curHudType == HudType.AbyssType);
		_view.characterTutrialUI.SetActive(curHudType == HudType.characterTutorial && !Model<RaidModel>.Interface.ShowTrialTips && (value == null || value.bindMissionGroupId == 0));
		_view.rogueUIRoot.SetActive(curHudType == HudType.RogueType);
		_view.characterTeamTutorial.SetActive(curHudType == HudType.CharacterTeamTutorial && (value == null || value.bindMissionGroupId == 0));
		_view.teamTeachingTarget.SetActive(curHudType == HudType.TeamTeaching);
		_view.characterTrialUI.SetActive(curHudType == HudType.characterTutorial && Model<RaidModel>.Interface.ShowTrialTips);
	}

	private bool GetRaidSceneUIVisible(Raid raid)
	{
		if (curHudType == HudType.RaidType)
		{
			if (raid != null)
			{
				return raid.bindMissionGroupId == 0;
			}
			return true;
		}
		if (curHudType == HudType.characterTutorial && raid != null && raid.tryRole.Length != 0 && CoreUtils.GetData(raid.tryRole[0], RuntimeConfigs.data.entityCharacterProbations).isShow != 0)
		{
			return true;
		}
		return false;
	}

	public void ChangeMainUIState(bool state)
	{
		UpdateUICanvasGroupState(_view.BattleStateRoot, state);
		UpdateUICanvasGroupState(_view.customUIRoot, state);
		_view.missionInstruction.SetActive(state);
	}

	public void OnHideLeaveBtn(BaseEventContent obj)
	{
		_view.LeaveSubWorldBtn.SetActive(value: false);
	}

	private void OnBattleMainRefreshCanvasGroup(BaseEventContent obj)
	{
		if (obj is RefreshBattleMainRefreshCanvasGroup refreshBattleMainRefreshCanvasGroup)
		{
			_view.SetCanvasGroup(refreshBattleMainRefreshCanvasGroup.isActive);
		}
	}

	private void SetPerspectiveUIRoot(PlayerPerspectiveState perspectiveState)
	{
		bool flag = perspectiveState == PlayerPerspectiveState.Back;
		UpdateUICanvasGroupState(_view.leftTopUIRoot, !flag);
		UpdateUICanvasGroupState(_view.menuRoot, !flag);
	}
}
