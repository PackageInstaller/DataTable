using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class TotalRechargeReward : ActivityCenterBaseUIView<TotalRechargeRewardController>
{
	[SerializeField]
	private TimeAndDesItem timeAndDesItem;

	[SerializeField]
	private ActButton gotoShopButton;

	[SerializeField]
	private TextMeshProUGUI nextProgressText;

	[SerializeField]
	private GameObject nextProgressTextRoot;

	[SerializeField]
	private GameObject accomplishTextRoot;

	[SerializeField]
	private Slider nextProgressFill;

	[SerializeField]
	private List<TotalRechargeRewardItem> rechargeRewardItems = new List<TotalRechargeRewardItem>(8);

	[SerializeField]
	private TotalRechargeRewardItem welcomeRewardItem;

	[SerializeField]
	private ViewControlRoot rechargeRewardControlRoot;

	[SerializeField]
	private ViewControlLayer rechargeRewardControlLayer;

	private ActivityCenterData _activityCenterData;

	private ActivityTotalRechargeInfo _activityInfo;

	protected override void Init()
	{
		gotoShopButton?.SetBtnClick(OnClickGotoShop);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateActivity, OnActivityUpdate);
		RefreshUI();
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateActivity, OnActivityUpdate);
	}

	public void OnClose()
	{
		ActivityCenterView?.Exit();
	}

	public void OnClickActivityDetail()
	{
		timeAndDesItem?.OnClickActivityDetailButtonHandle();
	}

	public void OnInputModeChange(DeviceInputMode inputMode)
	{
		if (inputMode == DeviceInputMode.Gamepad)
		{
			FocusRechargeReward();
		}
	}

	public void FocusRechargeReward()
	{
		rechargeRewardControlLayer?.Focus();
	}

	public void ExecuteNavigate(MoveDirection direction)
	{
		if (!(rechargeRewardControlRoot == null) && !(rechargeRewardControlLayer == null) && rechargeRewardControlLayer.IsFocused)
		{
			switch (direction)
			{
			case MoveDirection.Left:
				rechargeRewardControlRoot.SelectLeft();
				break;
			case MoveDirection.Right:
				rechargeRewardControlRoot.SelectRight();
				break;
			case MoveDirection.Up:
				rechargeRewardControlRoot.SelectUp();
				break;
			case MoveDirection.Down:
				rechargeRewardControlRoot.SelectDown();
				break;
			}
		}
	}

	public void OnGamepadConfirm()
	{
		if (!(rechargeRewardControlLayer == null) && rechargeRewardControlLayer.IsFocused && !(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void OnGamepadReceiveWelcomeReward()
	{
		if (!(welcomeRewardItem == null) && welcomeRewardItem.gameObject.activeInHierarchy)
		{
			welcomeRewardItem.OnGamepadSubmit();
		}
	}

	public void OnGamepadGotoShop()
	{
		OnClickGotoShop();
	}

	private void OnActivityUpdate(BaseEventContent content)
	{
		if (content is ActivityCenterInfo activityCenterInfo && activityCenterInfo.activityId == Model<ActivityCenterModel>.Interface.SelectActivityId)
		{
			RefreshUI();
		}
	}

	private void RefreshUI()
	{
		int selectActivityId = Model<ActivityCenterModel>.Interface.SelectActivityId;
		_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(selectActivityId);
		_activityInfo = Model<ActivityCenterModel>.Interface.GetActivityTotalRechargeInfo(selectActivityId);
		if (_activityCenterData != null && _activityInfo != null)
		{
			timeAndDesItem?.Init(_activityCenterData, -1L);
			RefreshRewardItems();
			RefreshProgress();
		}
	}

	private void RefreshRewardItems()
	{
		ActivityData staticActivityData = _activityCenterData.StaticActivityData;
		if (staticActivityData?.activityChallengGroup == null)
		{
			return;
		}
		ActivityChallengeGroup activityChallengeGroup = null;
		ActivityChallengeGroup activityChallengeGroup2 = null;
		int[] activityChallengGroup = staticActivityData.activityChallengGroup;
		for (int i = 0; i < activityChallengGroup.Length; i++)
		{
			ActivityChallengeGroup data = CoreUtils.GetData(activityChallengGroup[i], RuntimeConfigs.data.activityChallengeGroups);
			if (data != null && data.challengeId != null)
			{
				if (data.challengeId.Length > 1)
				{
					activityChallengeGroup = data;
				}
				else if (data.challengeId.Length == 1)
				{
					activityChallengeGroup2 = data;
				}
			}
		}
		for (int j = 0; j < rechargeRewardItems.Count; j++)
		{
			TotalRechargeRewardItem totalRechargeRewardItem = rechargeRewardItems[j];
			if (!(totalRechargeRewardItem == null))
			{
				if (activityChallengeGroup == null || j >= activityChallengeGroup.challengeId.Length)
				{
					totalRechargeRewardItem.gameObject.SetActive(value: false);
					continue;
				}
				totalRechargeRewardItem.gameObject.SetActive(value: true);
				totalRechargeRewardItem.Refresh(_activityInfo, activityChallengeGroup.id, activityChallengeGroup.challengeId[j], isWelcomeReward: false, Station);
			}
		}
		if (!(welcomeRewardItem == null))
		{
			welcomeRewardItem.gameObject.SetActive(activityChallengeGroup2 != null);
			if (activityChallengeGroup2 != null)
			{
				welcomeRewardItem.Refresh(_activityInfo, activityChallengeGroup2.id, activityChallengeGroup2.challengeId[0], isWelcomeReward: true, Station);
			}
		}
	}

	private void RefreshProgress()
	{
		long totalRecharge = _activityInfo.TotalRecharge;
		long num = 0L;
		long num2 = 0L;
		foreach (TotalRechargeRewardItem rechargeRewardItem in rechargeRewardItems)
		{
			if (!(rechargeRewardItem == null) && rechargeRewardItem.gameObject.activeSelf)
			{
				num = Math.Max(num, rechargeRewardItem.RequiredRecharge);
				if (rechargeRewardItem.RequiredRecharge > totalRecharge && (num2 == 0L || rechargeRewardItem.RequiredRecharge < num2))
				{
					num2 = rechargeRewardItem.RequiredRecharge;
				}
			}
		}
		long num3 = ((num2 > 0) ? num2 : num);
		bool flag = num > 0 && totalRecharge >= num;
		nextProgressTextRoot?.SetActive(!flag);
		accomplishTextRoot?.SetActive(flag);
		if (nextProgressText != null)
		{
			nextProgressText.SetText($"{totalRecharge}/{num3}");
		}
		if (nextProgressFill != null)
		{
			nextProgressFill.value = ((num3 > 0) ? Mathf.Clamp01((float)totalRecharge / (float)num3) : 1f);
		}
	}

	private void OnClickGotoShop()
	{
		if (_activityCenterData?.StaticActivityData != null && int.TryParse(_activityCenterData.StaticActivityData.activityJump, out var result))
		{
			RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(result);
			JumpResult jumpResult = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
			if (jumpResult.ShowType == JumpResult.JumpShowType.CanJump)
			{
				Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
			}
			jumpResult.Release();
		}
	}
}
