using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.Model;
using ACT.UI.InputController;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class RaidDoubleReward : ActivityCenterBaseUIView<RaidDoubleRewardController>
{
	[SerializeField]
	private TimeAndDesItem timeAndDesItem;

	[SerializeField]
	private TextMeshProUGUI countText;

	[SerializeField]
	private LoopVerticalScrollRect loopVerticalScrollRect;

	public GameObject GamepadTipsRoot;

	public bool useAnimation;

	public Animator uiEffectAnimator;

	public BetterAnimation betterAnimation;

	private int activityId => Model<ActivityCenterModel>.Interface.SelectActivityId;

	private ActivityCenterData activityCenterData => Model<ActivityCenterModel>.Interface.GetActivityCenterData(activityId);

	public int SelectedIndex { get; private set; } = -1;

	public TimeAndDesItem TimeAndDesItem => timeAndDesItem;

	protected override void Init()
	{
		RefreshUI();
		RefreshLoopVerticalScrollRect();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").Play();
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Power_Refresh, OnRefresh);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Instance/Double_Open");
	}

	private void OnRefresh(BaseEventContent obj)
	{
		RefreshUI();
	}

	private void RefreshLoopVerticalScrollRect()
	{
		List<int> challengeList = Model<ActivityCenterModel>.Interface.GetChallengeList(activityId);
		if (loopVerticalScrollRect != null)
		{
			loopVerticalScrollRect.ClearCells();
			loopVerticalScrollRect.totalCount = challengeList.Count;
			loopVerticalScrollRect.RefillCells();
			SelectItem((challengeList.Count <= 0) ? (-1) : 0);
		}
	}

	private void RefreshUI()
	{
		timeAndDesItem.Init(activityCenterData, -1L);
		(int, int) todayLeftDoubleRewardCount = Model<ActivityCenterModel>.Interface.GetTodayLeftDoubleRewardCount(activityId);
		if (countText != null)
		{
			countText.SetText("{0:0}/{1:0}", todayLeftDoubleRewardCount.Item1, todayLeftDoubleRewardCount.Item2);
		}
	}

	protected override void UnInit()
	{
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide").Play();
		}
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Power_Refresh, OnRefresh);
	}

	public void OnClose()
	{
		(Singleton<NewUIManager>.instance.GetTopActiveUI().GetUIView() as ActivityCenterView)?.Exit();
	}

	public void OnInputModeChange(DeviceInputMode deviceInputMode)
	{
		if (GamepadTipsRoot != null)
		{
			GamepadTipsRoot.SetActive(deviceInputMode == DeviceInputMode.Gamepad);
		}
		RefreshSelectedItemState();
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		if (!(loopVerticalScrollRect == null) && loopVerticalScrollRect.totalCount > 0 && (dir == MoveDirection.Up || dir == MoveDirection.Down))
		{
			int num = ((SelectedIndex >= 0) ? SelectedIndex : 0);
			num = ((dir != MoveDirection.Up) ? (num + 1) : (num - 1));
			SelectItem(Mathf.Clamp(num, 0, loopVerticalScrollRect.totalCount - 1));
		}
	}

	public void OnGoto()
	{
		GetSelectedItem()?.GotoRaid();
	}

	private void SelectItem(int index)
	{
		if (SelectedIndex == index)
		{
			RefreshSelectedItemState();
			return;
		}
		GetSelectedItem()?.SetGamepadSelected(selected: false);
		SelectedIndex = index;
		if (SelectedIndex >= 0)
		{
			RaidDoubleRewardItem selectedItem = GetSelectedItem();
			if (selectedItem == null)
			{
				loopVerticalScrollRect.ScrollToCell(SelectedIndex, 0f);
				selectedItem = GetSelectedItem();
			}
			selectedItem?.SetGamepadSelected(selected: true);
			if (selectedItem != null && EventSystemHelper.Available)
			{
				EventSystemHelper.SetSelectedGameObject(selectedItem.GetSelectableGameObject());
			}
		}
	}

	private void RefreshSelectedItemState()
	{
		int num = ((loopVerticalScrollRect != null) ? loopVerticalScrollRect.ItemIndexStart : 0);
		while (loopVerticalScrollRect != null && num < loopVerticalScrollRect.ItemIndexEnd)
		{
			if (loopVerticalScrollRect.GetItem(num) is RaidDoubleRewardItem raidDoubleRewardItem)
			{
				raidDoubleRewardItem.SetGamepadSelected(num == SelectedIndex && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
			}
			num++;
		}
	}

	private RaidDoubleRewardItem GetSelectedItem()
	{
		if (loopVerticalScrollRect == null || SelectedIndex < 0)
		{
			return null;
		}
		return loopVerticalScrollRect.GetItem(SelectedIndex) as RaidDoubleRewardItem;
	}
}
