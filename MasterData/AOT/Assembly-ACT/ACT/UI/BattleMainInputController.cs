using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.EventTrack;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.WaitSort;
using UnityEngine;

namespace ACT.UI;

public class BattleMainInputController : BaseUIViewInputController<MonoBattleMainBaseView>
{
	private readonly Dictionary<int, string> _SystemIdToActionDefine = new Dictionary<int, string>
	{
		{ 1044, "UI/BattlePass" },
		{ 1028, "UI/Map" },
		{ 1004, "UI/Bag" },
		{ 1017, "UI/Character" },
		{ 1008, "UI/Summary" },
		{ 1007, "UI/CardPool" },
		{ 3001, "UI/Activity" },
		{ 1011, "UI/Task" },
		{ 1030, "UI/SNSOpenMission" },
		{ 1013, "UI/Team" },
		{ 10351, "UI/Esc" }
	};

	private const int introWorldId = 4;

	private bool wheelOpen => View.WheelDisc.IsFocused;

	private bool IsInteracting => Singleton<GameState>.instance.InInteractObjectProcessing;

	private bool IsFacePushShortcutInputBlocked
	{
		get
		{
			if (Model<FacePushModel>.HasInstance())
			{
				return Model<FacePushModel>.Interface.Scheduler?.IsShortcutInputBlocked ?? false;
			}
			return false;
		}
	}

	private void SetSystemInputSetActive(int systemId, bool disable)
	{
		if (_SystemIdToActionDefine.TryGetValue(systemId, out var value))
		{
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, value, disable);
		}
	}

	private void OnSystemBlockStatusChanged(BaseEventContent obj)
	{
		if (obj is SystemBlockStatusChangedEvt systemBlockStatusChangedEvt)
		{
			SetSystemInputSetActive(systemBlockStatusChangedEvt.status.MainID, systemBlockStatusChangedEvt.status.Disabled);
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		Singleton<GameInputActionManager>.instance.SetGameInputState(GameInputState.Battle, active: true);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
		foreach (KeyValuePair<int, string> item in _SystemIdToActionDefine)
		{
			bool disable = Singleton<SystemBlockManager>.instance.IsBlocked(item.Key);
			SetSystemInputSetActive(item.Key, disable);
		}
		MonoECS.instance.SetPlayerInputMapActive(active: true);
		View.RefreshMenuListActive(MonoECS.instance.InputMode);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		Singleton<GameInputActionManager>.instance.SetGameInputState(GameInputState.Battle, active: false);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
		MonoECS.instance.SetPlayerInputMapActive(active: false);
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		View.RefreshMenuListActive(type);
	}

	private void SendEventTrack(SystemType systemType)
	{
		SystemOpen evt = EventTrackSolver.Instance.GetEvt<SystemOpen>();
		evt.id = (int)systemType;
		evt.type = 3;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void OpenSystemView(bool force, SystemType systemType, UI_TYPE uiType, bool Conditions = true)
	{
		if ((force || !IsFacePushShortcutInputBlocked) && (force || CanOpenNextView((!MonoECS.instance.IsNotInMain || CheckSubWorldOpenSystem(systemType)) & Conditions, systemType)))
		{
			SendEventTrack(systemType);
			Singleton<NewUIManager>.instance.OpenUIAsync(uiType, null, isneedinqueue: false);
			GameUtility.SendFinshStepGuideEvent((GuideConsts.GuideType)systemType);
		}
	}

	private bool CheckSubWorldOpenSystem(SystemType systemType)
	{
		if (Model<BattleMainModel>.Interface != null)
		{
			return Model<BattleMainModel>.Interface.curSubWorldHudTypeOpenSystems.Contains((int)systemType);
		}
		return false;
	}

	public async void OnOpenEsc(bool force)
	{
		if (force || !IsFacePushShortcutInputBlocked)
		{
			IsActive = false;
			SendEventTrack(SystemType.ESC);
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.HUdEsc);
			if (force || (CanOpenNextView(!MonoECS.instance.IsNotInMain) && Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.ESC)))
			{
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_ESC, null, isneedinqueue: false);
			}
			if (Model<BattleMainModel>.Interface.hudType != HudType.MainWorldType)
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.InSubWorldClickEscBtn, null);
			}
		}
	}

	public void OnOpenTeam(bool force)
	{
		force = force || Model<GuideModel>.Interface.IsInStrongGuide();
		if (!force && IsFacePushShortcutInputBlocked)
		{
			return;
		}
		if (!force)
		{
			bool flag = MonoECS.instance.playState == PlayState.UnBattle && !MonoECS.instance.IsNotInMain;
			bool flag2 = MonoECS.instance.playState == PlayState.UnBattle && CheckSubWorldOpenSystem(SystemType.Team);
			bool flag3 = CheckSubWorldOpenSystem(SystemType.Team) && MonoECS.instance.IsInTrainingground;
			if (!CanOpenNextView(flag | flag2 | flag3, SystemType.Team))
			{
				GameUtility.OpenToolTip(479);
				return;
			}
		}
		SendEventTrack(SystemType.Team);
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEAM, new TeamViewData
		{
			source = (MonoECS.instance.IsInTrainingground ? TeamProfileSource.Traininground : TeamProfileSource.World)
		}, isneedinqueue: false);
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.HudTeam);
	}

	public void OnOpenSNS(bool force)
	{
		if (force || !IsFacePushShortcutInputBlocked)
		{
			bool flag = MonoECS.instance.playState == PlayState.UnBattle && !MonoECS.instance.IsNotInMain;
			bool flag2 = MonoECS.instance.playState == PlayState.UnBattle && CheckSubWorldOpenSystem(SystemType.Message);
			bool flag3 = CheckSubWorldOpenSystem(SystemType.Message) && MonoECS.instance.IsInTrainingground;
			if (force || CanOpenNextView(flag | flag2 | flag3, SystemType.Message))
			{
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SNS, null, isneedinqueue: false).Forget();
				GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.HudSNS);
			}
		}
	}

	public void OnOpenMissionTarget(bool force)
	{
		if (force || !IsFacePushShortcutInputBlocked)
		{
			SendEventTrack(SystemType.Mission);
			if (force || CanOpenNextView(!MonoECS.instance.IsNotInMain))
			{
				View.taskManager.OnMissionTipClick();
			}
		}
	}

	protected override void OnEscPressed(bool value)
	{
		if (!Model<BattleMainModel>.Interface.IsBack && !IsFacePushShortcutInputBlocked && !value && !wheelOpen && !IsInteracting)
		{
			if (Singleton<ProtagonistManager>.instance.IsProtagonist)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPPROTAGONISTEXITVIEW);
			}
			else
			{
				OnOpenEsc(force: false);
			}
		}
	}

	protected override void OnBackPressed(bool value)
	{
	}

	[GameInputBindingBool("UI/View")]
	public void OnViewPressed(bool value)
	{
		if (IsFacePushShortcutInputBlocked)
		{
			return;
		}
		if (CanOpenNextView(MonoECS.instance.IsInTrainingground))
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TRAININGGROUND, null, isneedinqueue: false);
			return;
		}
		if ((Model<BattleMainModel>.Interface.hudType == HudType.RogueType) & value)
		{
			View.OpenRogueBagView();
		}
		if ((Model<BattleMainModel>.Interface.hudType == HudType.characterTutorial && View.characterTrialUI.activeSelf) & value)
		{
			EventSystemHelper.Click(View.characterTrialUI.GetComponent<BattleMainCharacterTrialComponent>().CharacterTrialTips);
		}
		if ((Model<BattleMainModel>.Interface.hudType == HudType.TempleType) & value)
		{
			View.templeUI?.templeBuffRecordEntry?.OnClick?.Invoke();
		}
	}

	[GameInputBindingBool("UI/Map")]
	private void OnMapPressed(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && value && !wheelOpen && !IsInteracting)
		{
			OpenSystemView(force: false, SystemType.MapUnLock, UI_TYPE.UI_LARGEMAP);
		}
	}

	[GameInputBindingBool("UI/BattlePass")]
	private void OnBattlePassPressed(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && Model<BattlePassModel>.Interface.AvailAble && value && !wheelOpen && !IsInteracting)
		{
			OpenSystemView(force: false, SystemType.BattlePass, UI_TYPE.UI_BATTLEPASS);
		}
	}

	[GameInputBindingBool("UI/MissionTarget")]
	private void OnMissionTargetPressed(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<InteractModel>.Interface.IsTabLongPress && !Model<BattleMainModel>.Interface.IsBack && value && !wheelOpen && !IsInteracting)
		{
			OnOpenMissionTarget(force: false);
		}
	}

	[GameInputBindingBool("UI/Bag")]
	private void OnBagPressed(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && value && !wheelOpen && !IsInteracting)
		{
			if (Model<BattleMainModel>.Interface.hudType == HudType.RogueType)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUEBAG);
			}
			else
			{
				OpenSystemView(force: false, SystemType.Bag, UI_TYPE.UI_BAGPANEL);
			}
		}
	}

	[GameInputBindingBool("UI/Character")]
	private void OnOpenCharacterPressed(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && value && !wheelOpen && !IsInteracting)
		{
			OpenSystemView(force: false, SystemType.CharacterView, UI_TYPE.UI_CHARACTER);
		}
	}

	[GameInputBindingBool("UI/Summary")]
	private void OnOpenSummaryPressed(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && value && !wheelOpen && !IsInteracting)
		{
			OpenSystemView(force: false, SystemType.HandBook, UI_TYPE.UI_HANDBOOK);
		}
	}

	[GameInputBindingBool("UI/CardPool")]
	private void OnOpenCardPoolPressed(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && value && !wheelOpen && !IsInteracting)
		{
			OpenSystemView(force: false, SystemType.DrawCard, UI_TYPE.UI_CARDDRAW);
		}
	}

	[GameInputBindingBool("UI/Activity")]
	private void OnOpenActivityPressed(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && value && !wheelOpen && Model<ActivityCenterModel>.HasInstance() && Model<ActivityCenterModel>.Interface.CheckIsHasOpeningActivity() && !IsInteracting)
		{
			OpenSystemView(force: false, SystemType.Activity, UI_TYPE.UI_ACTIVITYCENTER);
		}
	}

	[GameInputBindingBool("UI/Task")]
	private void OnOpenTaskPressed(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && value && !wheelOpen && !IsInteracting)
		{
			OpenSystemView(force: false, SystemType.Mission, UI_TYPE.UI_TASK);
		}
	}

	[GameInputBindingBool("UI/SNSOpenMission")]
	private void OpenSNS(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && value && !wheelOpen && !IsInteracting)
		{
			OnOpenSNS(force: false);
		}
	}

	[GameInputBindingBool("UI/Team")]
	private void OnOpenTeamPressed(bool value)
	{
		if (value && Model<GuideModel>.Interface.IsInStrongGuide())
		{
			OnOpenTeam(force: true);
		}
		else if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && value && !wheelOpen && !IsInteracting)
		{
			OnOpenTeam(force: false);
		}
	}

	[GameInputBindingBool("UI/MenuDisc")]
	private void OnMenuDiscSwitchPressed(bool value)
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist && !Model<BattleMainModel>.Interface.IsBack)
		{
			OnMenuDiscSwitch(force: false, value);
		}
	}

	public void OnMenuDiscSwitch(bool force, bool show)
	{
		if ((!force & show) && IsFacePushShortcutInputBlocked)
		{
			return;
		}
		bool flag = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.WheelComponent);
		bool flag2 = Singleton<GameManager>.instance.worldManager.ActiveWorldId == 4;
		bool flag3 = (Model<BattleMainModel>.Interface.hudType == HudType.MainWorldType || Model<BattleMainModel>.Interface.hudType == HudType.TrainingGroundType || Model<BattleMainModel>.Interface.hudType == HudType.TeamTeaching || Model<BattleMainModel>.Interface.hudType == HudType.characterTutorial) | flag2;
		if (!((MonoECS.instance.InputMode == DeviceInputMode.Gamepad || MonoECS.instance.InputMode == DeviceInputMode.KeyboardAndMouse) & flag & flag3))
		{
			return;
		}
		if (!force)
		{
			IBaseUIController topActivePanel = Singleton<NewUIManager>.instance.GetTopActivePanel();
			if (topActivePanel == null || topActivePanel.UIType != UI_TYPE.UI_BATTLEMAIN)
			{
				return;
			}
		}
		if (show && !View.WheelDisc.gameObject.activeSelf)
		{
			if (Mathf.Approximately(View.handleMode_MenuList.alpha, 1f))
			{
				View.handleMode_MenuList.alpha = 0f;
			}
			View.WheelDisc.UpdateGamePadTip();
			View.WheelDisc.gameObject.SetActive(show);
			View.WheelDisc.FocusIn();
		}
	}

	[GameInputBindingBool("UI/GuideToturial")]
	private void OnOpenGuideToturial(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && value && !IsFacePushShortcutInputBlocked && !wheelOpen && !IsInteracting)
		{
			if (View.tutorialComponent != null && View.tutorialComponent.isRunning)
			{
				View.tutorialComponent.OpenGraphicGuideView();
			}
			else if (View.tutorialComponent == null && LuminApplication.LogEnabled)
			{
				Debug.LogError("百科倒计时组件为空，检查battleMain预制");
			}
		}
	}

	[GameInputBindingBool("UI/SpecialProppickTrigger")]
	private void TriggerSpeicalDropPick(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && value && !IsFacePushShortcutInputBlocked && !wheelOpen && !IsInteracting && View.normalPickingView != null && View.normalPickingView.specialItemTip.isShowing)
		{
			View.normalPickingView.specialItemTip.OpenTargetView();
		}
	}

	[GameInputBindingBool("UI/TextLibrary")]
	private void OpenTextLibraryView(bool value)
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist & value)
		{
			GameUtility.OpenToolTip(2563);
		}
		else if (!Model<BattleMainModel>.Interface.IsBack && value && !IsFacePushShortcutInputBlocked && !wheelOpen && !IsInteracting && View.textLibraryPropPick != null && View.textLibraryPropPick.isShowing && Singleton<TextLibraryManager>.instance.HasData)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTLIBRARY, new TextLibraryViewData
			{
				targetJumpTextDataId = Model<TextLibraryModel>.Interface.lastUnLockTextLibraryId
			});
			Model<TextLibraryModel>.Interface.lastUnLockTextLibraryId = 0;
		}
	}

	[GameInputBindingVector2("Player/Move")]
	private void OnPlayerMove(Vector2 dir)
	{
		if (!wheelOpen)
		{
			if (Model<BattleMainModel>.Interface.IsBack && dir != Vector2.zero)
			{
				dir = Vector2.right;
			}
			GamePlayerInput.GetCurrent().OnPlayerMove(dir);
		}
	}

	[GameInputBindingBool("Player/Jump")]
	private void OnPlayerJump(bool value)
	{
		if (!wheelOpen)
		{
			GamePlayerInput.GetCurrent().OnPlayerJump(value);
		}
	}

	[GameInputBindingBool("Player/Dodge", true)]
	private void OnPlayerDodge(bool value)
	{
		if (!wheelOpen)
		{
			GamePlayerInput.GetCurrent().OnPlayerDodge(value);
		}
	}

	private void SendGuideFinshStepEvent(string actionPath)
	{
		if (Model<GuideModel>.Interface.IsInStrongGuide())
		{
			GuideInputFinshStepEvt guideInputFinshStepEvt = new GuideInputFinshStepEvt();
			guideInputFinshStepEvt.InputActionPath = actionPath;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_FinshCurrentGuideStep, guideInputFinshStepEvt);
			Singleton<EventManager>.instance.ReleaseEvt(guideInputFinshStepEvt);
		}
	}

	[GameInputBindingBool("Player/RegularAttack", true)]
	private void OnPlayerRegularAttack(bool value)
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist && !wheelOpen)
		{
			GamePlayerInput.GetCurrent().OnPlayerRegularAttack(value);
		}
	}

	[GameInputBindingBool("Player/SkillAttack")]
	private void OnPlayerSkillAttack(bool value)
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist && !wheelOpen)
		{
			GamePlayerInput.GetCurrent().OnPlayerSkillAttack(value);
		}
	}

	[GameInputBindingBool("Player/Vibrate")]
	private void OnPlayerVibrate(bool value)
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist && !wheelOpen)
		{
			GamePlayerInput.GetCurrent().OnPlayerVibrate(value);
		}
	}

	[GameInputBindingBool("Player/Switch1Character")]
	private void OnPlayerSwitchCharacter1(bool value)
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist && !wheelOpen)
		{
			GamePlayerInput.GetCurrent().OnPlayerSwitchCharacter1(value);
		}
	}

	[GameInputBindingBool("Player/Switch2Character")]
	private void OnPlayerSwitchCharacter2(bool value)
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist && !wheelOpen)
		{
			GamePlayerInput.GetCurrent().OnPlayerSwitchCharacter2(value);
		}
	}

	[GameInputBindingBool("Player/Switch3Character")]
	private void OnPlayerSwitchCharacter3(bool value)
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist && !wheelOpen)
		{
			GamePlayerInput.GetCurrent().OnPlayerSwitchCharacter3(value);
		}
	}

	[GameInputBindingBool("UI/Interact")]
	private void OnPlayerInteract(bool value)
	{
		if (!Model<BattleMainModel>.Interface.IsBack)
		{
			if (!wheelOpen)
			{
				GamePlayerInput.GetCurrent().OnPlayerInteract(value);
			}
			if (value && !wheelOpen && !Singleton<NewUIManager>.instance.IsUIManagerBusy())
			{
				Model<InteractModel>.Interface.OnInteract();
			}
		}
	}

	[GameInputBindingFloat("UI/SwitchInteractGamePadX")]
	private void OnPlayerInteractSwitchGamePadX(float value)
	{
		if (!Model<BattleMainModel>.Interface.IsBack && !wheelOpen && value != 0f && Model<InteractModel>.Interface.NeedShowHint)
		{
			Model<InteractModel>.Interface.UpdateSwitchInteractTypeByGamePad(MathF.Sign(value) > 0);
		}
	}

	[GameInputBindingFloat("UI/SwitchInteractGamePadY")]
	private void OnPlayerInteractSwitchGamePadY(float value)
	{
		if (!Model<BattleMainModel>.Interface.IsBack && !wheelOpen && value != 0f)
		{
			Model<InteractModel>.Interface.UpdateBtnSelectIndexByManual(MathF.Sign(value) < 0);
		}
	}

	[GameInputBindingBool("UI/SwitchInteract")]
	private void OnPlayerInteractSwitchClick(bool value)
	{
		if (!Model<BattleMainModel>.Interface.IsBack)
		{
			if (!wheelOpen)
			{
				GamePlayerInput.GetCurrent().OnPlayerInteractSwitch(value);
			}
			if (value && !wheelOpen && Model<InteractModel>.Interface.NeedShowHint)
			{
				Model<InteractModel>.Interface.UpdateSwitchInteractType();
			}
		}
	}

	[GameInputBindingBool("Player/ShortCut")]
	private void OnPlayerItemShortcut(bool value)
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist && !Model<BattleMainModel>.Interface.IsBack && !wheelOpen)
		{
			GamePlayerInput.GetCurrent().OnPlayerItemShortcut(value);
		}
	}

	[GameInputBindingBool("Player/Claw")]
	private void OnPlayerClaw(bool value)
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist && !Model<BattleMainModel>.Interface.IsBack && !wheelOpen)
		{
			GamePlayerInput.GetCurrent().OnPlayerClaw(value);
		}
	}

	[GameInputBindingFloat("UI/ScrollWheelY")]
	private void ScrollWheel(float value)
	{
		if (Model<BattleMainModel>.Interface.IsBack || value == 0f || wheelOpen)
		{
			return;
		}
		if (Model<InteractModel>.Interface.CurInteractType != CurInteractType.None)
		{
			Model<InteractModel>.Interface.UpdateBtnSelectIndexByManual(MathF.Sign(value) < 0);
			if (Model<InteractModel>.Interface.CurInteractType == CurInteractType.Common && Model<InteractModel>.Interface.CommonInteractBtnCount == 1)
			{
				CinemachineDynamicFOVBrain.Instance?.OnZoomFov(value);
			}
		}
		else
		{
			CinemachineDynamicFOVBrain.Instance?.OnZoomFov(value);
		}
	}

	[GameInputBindingVector2("UI/ZoomFovGamePadY")]
	private void OnPlayerZoomFovGamePadY(Vector2 value)
	{
		if (!Model<BattleMainModel>.Interface.IsBack && value.y != 0f && !wheelOpen && Mathf.Abs(value.y) > Mathf.Abs(value.x) && Model<InteractModel>.Interface.CurInteractType != CurInteractType.Elevator && (Model<InteractModel>.Interface.CurInteractType != CurInteractType.Common || Model<InteractModel>.Interface.CommonInteractBtnCount == 1))
		{
			CinemachineDynamicFOVBrain.Instance?.OnZoomFov(value.y);
		}
	}

	[GameInputBindingBool("UI/ZoomFovPageUp")]
	private void OnPlayerZoomFovPageUp(bool value)
	{
		if (value && !Model<BattleMainModel>.Interface.IsBack && !wheelOpen)
		{
			CinemachineDynamicFOVBrain.Instance?.OnZoomFov(1f);
		}
	}

	[GameInputBindingBool("UI/ZoomFovPageDown")]
	private void OnPlayerZoomFovPageDown(bool value)
	{
		if (value && !Model<BattleMainModel>.Interface.IsBack && !wheelOpen)
		{
			CinemachineDynamicFOVBrain.Instance?.OnZoomFov(-1f);
		}
	}

	[GameInputBindingBool("UI/StopChallenge")]
	private void OnStopChallenge(bool value)
	{
		if (value && !Model<BattleMainModel>.Interface.IsBack && !wheelOpen)
		{
			Model<BigWorldChallengeProgressModel>.Interface.InputStopChallenge();
		}
	}
}
