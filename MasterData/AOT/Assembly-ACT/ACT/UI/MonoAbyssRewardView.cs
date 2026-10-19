using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoAbyssRewardView : BaseUIView<AbyssRewardViewInputController>
{
	public ActButton CloseButton;

	public ActButton ReceiveAllRewardButton;

	public GameObject ReceiveAllReddot;

	public LoopScrollRect RewardTabLoopScrollRect;

	public LoopScrollRect RewardItemLoopScrollRect;

	public GameObject GamepadTipsRoot;

	public Dictionary<AbyssRewardViewControllerType, List<GameObject>> ControlDownPromts;

	public Dictionary<AbyssRewardViewControllerType, List<GameObject>> ControlPromts;

	public ViewControlRoot ViewControlRoot;

	public Dictionary<AbyssRewardViewControllerType, ViewControlLayer> ControlLayerDic;

	public int SelectTabIndex = -1;

	private MonoAbyssListView _monoAbyssListView;

	private AbyssRewardViewControllerType ControlType
	{
		get
		{
			return GetController().ControlType;
		}
		set
		{
			GetController().ControlType = value;
		}
	}

	protected override void Init()
	{
		base.Init();
		CloseButton.SetBtnClick(Close);
		ReceiveAllRewardButton.SetBtnClick(OnClickReceiveAllRewardButtonHandle);
		RefreshUI();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	public void OnClickReceiveAllRewardButtonHandle()
	{
		G.service.AbyssTaskReward(0, Model<AbyssModel>.Interface.GroupId, 0, claimAll: true, (bool r, RepeatedField<UniversalItem> items) =>
		{
			if (r)
			{
				List<Item> newItems = ListPool<Item>.Get();
				foreach (UniversalItem item2 in items)
				{
					Item item = new Item
					{
						Id = item2.Uid,
						Count = item2.Count
					};
					newItems.Add(item);
				}
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(newItems), notSort: false, () =>
				{
					ListPool<Item>.Release(newItems);
				});
				RefreshTabItem();
				RewardItemLoopScrollRect.RefillCells();
			}
			Model<AbyssModel>.Interface.RefreshData();
		});
	}

	public async void RefreshUI()
	{
		SelectTabIndex = 0;
		_monoAbyssListView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ABYSSLIST) as MonoAbyssListView;
		RewardTabLoopScrollRect.ClearCells();
		RewardTabLoopScrollRect.totalCount = RuntimeConfigs.data.abyssDatas.Count;
		await UniTask.DelayFrame(1);
		RewardTabLoopScrollRect.RefillCells();
		AbyssRewardTabItem abyssRewardTabItem = RewardTabLoopScrollRect.GetItem(SelectTabIndex) as AbyssRewardTabItem;
		OnClickAbyssTabHandle(abyssRewardTabItem.abyssConfig, SelectTabIndex);
		bool isHasReceiveReward = GetIsHasReceiveReward();
		ReceiveAllRewardButton.Interactable(isHasReceiveReward);
		ReceiveAllReddot.SetActive(isHasReceiveReward);
	}

	public void RefreshTabItem()
	{
		RewardTabLoopScrollRect.RefreshCells();
		bool isHasReceiveReward = GetIsHasReceiveReward();
		ReceiveAllRewardButton.Interactable(isHasReceiveReward);
		ReceiveAllReddot.SetActive(isHasReceiveReward);
	}

	public void OnClickAbyssTabHandle(AbyssData abyssConfig, int index)
	{
		if (SelectTabIndex >= 0)
		{
			SetItemSelect(SelectTabIndex, value: false);
		}
		SelectTabIndex = index;
		SetItemSelect(SelectTabIndex, value: true);
		RewardItemLoopScrollRect.ClearCells();
		RewardItemLoopScrollRect.totalCount = abyssConfig.timeReward.Length;
		RewardItemLoopScrollRect.RefillCells();
	}

	public ActivityCenterModel.ActivityRewardState GetRewardState(int index)
	{
		AbyssStage abyssStage = Model<AbyssModel>.Interface.GetAbyssStage(SelectTabIndex);
		if (abyssStage == null)
		{
			return ActivityCenterModel.ActivityRewardState.Lock;
		}
		if (abyssStage.EvaluationClaimState.TryGetValue(index + 1, out var value) & value)
		{
			return ActivityCenterModel.ActivityRewardState.Received;
		}
		if (abyssStage.CompletedTargetsNum >= index + 1)
		{
			return ActivityCenterModel.ActivityRewardState.Receive;
		}
		return ActivityCenterModel.ActivityRewardState.Normal;
	}

	private void SetItemSelect(int index, bool value)
	{
		AbyssRewardTabItem abyssRewardTabItem = RewardTabLoopScrollRect.GetItem(index) as AbyssRewardTabItem;
		if (abyssRewardTabItem != null)
		{
			abyssRewardTabItem.SetSelect(value);
		}
	}

	private bool GetIsHasReceiveReward()
	{
		List<int> list = RuntimeConfigs.data.abyssDatas.Keys.ToList();
		foreach (AbyssStage abyssStage in Model<AbyssModel>.Interface.AbyssStages)
		{
			AbyssData abyssData = RuntimeConfigs.data.abyssDatas[list[abyssStage.Index]];
			for (int i = 1; i <= abyssData.abyssGoal.Length + 1; i++)
			{
				if (!(abyssStage.EvaluationClaimState.TryGetValue(i, out var value) & value) && abyssStage.CompletedTargetsNum >= i)
				{
					return true;
				}
			}
		}
		return false;
	}

	protected override void OnInputDeviceChange(DeviceInputMode inputMode)
	{
		GamepadTipsRoot.SetActive(inputMode == DeviceInputMode.Gamepad);
		if (inputMode == DeviceInputMode.Gamepad)
		{
			ChangeInventoryViewControl(ControlType);
		}
	}

	public void OnControllerActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	public async void ChangeInventoryViewControl(AbyssRewardViewControllerType controlType)
	{
		await UniTask.DelayFrame(2);
		AbyssRewardViewControllerType controlType2 = ControlType;
		ControlType = controlType;
		if (ControlLayerDic.ContainsKey(controlType))
		{
			ControlLayerDic[controlType].ReFocus();
		}
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		foreach (GameObject item in ControlDownPromts[controlType])
		{
			item.SetActive(value: true);
			LayoutRebuilder.ForceRebuildLayoutImmediate(item.GetComponent<RectTransform>());
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(GamepadTipsRoot.transform.GetChild(0).GetComponent<RectTransform>());
		for (int j = 0; j < ControlPromts[controlType2].Count; j++)
		{
			ControlPromts[controlType2][j].SetActive(value: false);
		}
		for (int k = 0; k < ControlPromts[controlType].Count; k++)
		{
			ControlPromts[controlType][k].SetActive(value: true);
		}
		if (ControlType == AbyssRewardViewControllerType.Tab)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		if (ControlType == AbyssRewardViewControllerType.Tab && dir == MoveDirection.Right)
		{
			ChangeInventoryViewControl(AbyssRewardViewControllerType.Item);
			return;
		}
		if (ControlType == AbyssRewardViewControllerType.Item && dir == MoveDirection.Left)
		{
			ChangeInventoryViewControl(AbyssRewardViewControllerType.Tab);
			return;
		}
		switch (dir)
		{
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		}
		if (ControlType == AbyssRewardViewControllerType.Tab)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void HandleConfirm()
	{
		if (!(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
			if (ControlType == AbyssRewardViewControllerType.Tab)
			{
				ChangeInventoryViewControl(AbyssRewardViewControllerType.Item);
			}
		}
	}
}
