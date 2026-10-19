using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.Sound;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ActivityCompanionMission : ActivityCenterBaseUIView<ActivityCompanionMissionController>
{
	public TimeAndDesItem timeAndDesItem;

	public CommonScrollBagComponent rewardBag;

	public LocalizeStringEvent rewardTitleText;

	public ActButton confirmButton;

	[SerializeField]
	private GamePadTipsComp _gamePadTipsComp;

	[SerializeField]
	private List<GameObject> _mainControlPrompts = new List<GameObject>();

	[SerializeField]
	private GameObject _gotoPrompt;

	[SerializeField]
	private int _hideJumpTipId;

	public ViewControlRoot ViewControlRoot;

	public ViewControlLayer RewardControlLayer;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private readonly List<ItemUnifierProxy> _rewards = new List<ItemUnifierProxy>();

	private ActivityCenterData _activityCenterData;

	private ActivityData _activityData;

	private int _jumpId;

	private uint _loopSoundId;

	private ActivityCompanionMissionControlType ControlType => GetController()?.ControlType ?? ActivityCompanionMissionControlType.Main;

	protected override void Init()
	{
		base.Init();
		GetController().ControlType = ActivityCompanionMissionControlType.Main;
		ActivityCenterView?.LeftPart?.SetActive(value: true);
		BindButtons();
		RefreshActivityData();
		RefreshBaseInfo();
		RefreshRewardPreview();
		RefreshJumpState();
		PlayOpenAnimation();
		PlayLoopSound();
	}

	protected override void UnInit()
	{
		StopLoopSound();
		PlayCloseAnimation();
		base.UnInit();
		if (ControlType == ActivityCompanionMissionControlType.Reward)
		{
			ChangeControlType(ActivityCompanionMissionControlType.Main);
		}
		_gamePadTipsComp?.ClearAllPrompts();
		SetMainControlPromptsVisible(visible: false);
		SetActiveIfChanged(_gotoPrompt, active: false);
		rewardBag.ItemSource = null;
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		_rewards.Clear();
		_activityCenterData = null;
		_activityData = null;
	}

	private void PlayOpenAnimation()
	{
		_betterAnimation?.GetSequence("Show")?.Play();
	}

	private void PlayCloseAnimation()
	{
		_betterAnimation?.GetSequence("Hide")?.Play();
	}

	private void PlayLoopSound()
	{
		StopLoopSound();
		_loopSoundId = Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Mission/UI_Interface_Mission_Companion2601_Open", new AudioPlayOptions
		{
			attachTarget = transform,
			IsLoop = true
		});
	}

	private void StopLoopSound()
	{
		if (_loopSoundId != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(_loopSoundId);
			_loopSoundId = 0u;
		}
	}

	private void BindButtons()
	{
		confirmButton.SetBtnClick(OnGotoButtonClicked);
	}

	private void RefreshActivityData()
	{
		int selectActivityId = Model<ActivityCenterModel>.Interface.SelectActivityId;
		_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(selectActivityId);
		_activityData = _activityCenterData?.StaticActivityData;
		int.TryParse(_activityData?.activityJump, out _jumpId);
		ActivityChallengeGroup challengeGroup = GetChallengeGroup();
		GetChallengeData();
		if (rewardTitleText != null && challengeGroup != null)
		{
			rewardTitleText.SetTable("shortcommon");
			rewardTitleText.StringReference.TableEntryReference = challengeGroup.stageName;
		}
	}

	private ActivityChallengeGroup GetChallengeGroup()
	{
		int valueOrDefault = (_activityData?.activityChallengGroup?.FirstOrDefault()).GetValueOrDefault();
		if (!RuntimeConfigs.data.activityChallengeGroups.TryGetValue(valueOrDefault, out var value))
		{
			return null;
		}
		return value;
	}

	private ActivityChallengeData GetChallengeData()
	{
		int valueOrDefault = (_activityData?.activityChallengGroup?.FirstOrDefault()).GetValueOrDefault();
		if (valueOrDefault == 0 || !RuntimeConfigs.data.activityChallengeGroups.TryGetValue(valueOrDefault, out var value))
		{
			return null;
		}
		int key = value.challengeId?.FirstOrDefault() ?? 0;
		if (!RuntimeConfigs.data.activityChallengeDatas.TryGetValue(key, out var value2))
		{
			return null;
		}
		return value2;
	}

	private void RefreshBaseInfo()
	{
		if (_activityCenterData != null)
		{
			timeAndDesItem.Init(_activityCenterData, -1L);
		}
	}

	private void RefreshRewardPreview()
	{
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		_rewards.Clear();
		int valueOrDefault = (GetChallengeGroup()?.challengeId?.FirstOrDefault()).GetValueOrDefault();
		if (valueOrDefault != 0 && RuntimeConfigs.data.activityChallengeDatas.TryGetValue(valueOrDefault, out var value) && value.rewardsPreview != null)
		{
			foreach (ItemKv item in value.rewardsPreview)
			{
				_rewards.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.id, item.count));
			}
		}
		_rewards.Sort(SortUtility.SortItemUnifierProxy2);
		rewardBag.ItemShowType = ItemUIComponentBase.InitType.RewardItem;
		rewardBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		rewardBag.ItemSource = _rewards;
	}

	private void RefreshJumpState()
	{
		JumpResult jumpResult = GetJumpResult();
		bool active = jumpResult.ShowType == JumpResult.JumpShowType.CanJump || jumpResult.ShowType == JumpResult.JumpShowType.Forbidden || jumpResult.ShowType == JumpResult.JumpShowType.Hide;
		confirmButton.Interactable(active);
		jumpResult.Release();
		RefreshGamepadControlPrompts();
	}

	private JumpResult GetJumpResult()
	{
		if (_jumpId <= 0)
		{
			return new JumpResult(JumpResult.JumpShowType.Hide, null);
		}
		return Model<JumpModel>.Interface.CanJump(ItemJumpHelper.GetRunTimeJumpData(_jumpId));
	}

	private void OnGotoButtonClicked()
	{
		JumpResult jumpResult = GetJumpResult();
		if (jumpResult.ShowType == JumpResult.JumpShowType.CanJump)
		{
			RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(_jumpId);
			runTimeJumpData.FromSystem = SystemType.Activity;
			Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
			ReportGotoActivity();
		}
		else if (jumpResult.ShowType == JumpResult.JumpShowType.Forbidden)
		{
			GameUtility.OpenJumpResultTips(jumpResult);
		}
		else if (jumpResult.ShowType == JumpResult.JumpShowType.Hide && _hideJumpTipId > 0)
		{
			GameUtility.OpenToolTip(_hideJumpTipId);
		}
		jumpResult.Release();
		RefreshJumpState();
	}

	private void ReportGotoActivity()
	{
		ActivityChallengeGroup challengeGroup = GetChallengeGroup();
		ActivityChallengeData challengeData = GetChallengeData();
		if (_activityData != null && challengeGroup != null && challengeData != null)
		{
			ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
			evt.activityId = _activityData.id;
			evt.challengeGroupId = challengeGroup.id;
			evt.challengeId = challengeData.id;
			evt.status = 2;
			evt.isPopup = false;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	public void OpenActivityDetail()
	{
		timeAndDesItem?.OnClickActivityDetailButtonHandle();
	}

	public void OnActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	public new void OnInputDeviceChange(DeviceInputMode type)
	{
		RefreshGamepadControlPrompts();
		if (type == DeviceInputMode.Gamepad)
		{
			if (ControlType == ActivityCompanionMissionControlType.Reward)
			{
				RewardControlLayer?.ReFocus();
			}
			else
			{
				ViewControlRoot?.ReFocus();
			}
		}
	}

	public void ExecuteNavigate(MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Left:
			ViewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot?.SelectRight();
			break;
		}
	}

	public void OnSelectReward()
	{
		if (ControlType != ActivityCompanionMissionControlType.Reward && _rewards.Count != 0)
		{
			ChangeControlType(ActivityCompanionMissionControlType.Reward);
		}
	}

	public void ChangeControlType(ActivityCompanionMissionControlType controlType)
	{
		GetController().ControlType = controlType;
		if (controlType == ActivityCompanionMissionControlType.Reward)
		{
			RewardControlLayer?.ReFocus();
		}
		else
		{
			RewardControlLayer?.UnFocus();
		}
		RefreshGamepadControlPrompts();
	}

	private void RefreshGamepadControlPrompts()
	{
		bool flag = ControlType == ActivityCompanionMissionControlType.Main && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		SetMainControlPromptsVisible(flag);
		SetActiveIfChanged(_gotoPrompt, flag && confirmButton.IsInteractable());
		if (!(_gamePadTipsComp == null))
		{
			if (ControlType == ActivityCompanionMissionControlType.Reward)
			{
				_gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction);
			}
			else
			{
				_gamePadTipsComp.RegisterInputActions(GamePadTipHelper.BackAction);
			}
		}
	}

	private void SetMainControlPromptsVisible(bool visible)
	{
		for (int i = 0; i < _mainControlPrompts.Count; i++)
		{
			if (_mainControlPrompts[i] != null)
			{
				_mainControlPrompts[i].SetActive(visible);
			}
		}
	}

	private static void SetActiveIfChanged(GameObject gameObject, bool active)
	{
		if (gameObject != null && gameObject.activeSelf != active)
		{
			gameObject.SetActive(active);
		}
	}

	public void OnConfirm()
	{
		if (ControlType == ActivityCompanionMissionControlType.Reward && !(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void OnGoto()
	{
		if (ControlType != ActivityCompanionMissionControlType.Reward && confirmButton.IsInteractable())
		{
			confirmButton.OnSubmit(null);
		}
	}
}
