using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class AbyssRewardItem : LoopScrollBaseItem, ISelectHandler, IEventSystemHandler, IDeselectHandler, ISubmitHandler
{
	public GameObject S;

	public GameObject A;

	public GameObject B;

	public CommonScrollBagComponent commonScrollBagComponent;

	public ActButton ReceiveButton;

	public GameObject Normal;

	public GameObject Lock;

	public GameObject Received;

	public List<GameObject> SelectHandle;

	public ViewControlLayer ViewControlLayer;

	private MonoAbyssListView _monoAbyssListView;

	private MonoAbyssRewardView _monoAbyssRewardView;

	private int rewardIndex;

	private List<ItemUnifierProxy> itemUnifierProxys;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		RefreshUI(idx);
	}

	private void RefreshUI(int index)
	{
		_monoAbyssListView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ABYSSLIST) as MonoAbyssListView;
		if (_monoAbyssListView == null)
		{
			return;
		}
		_monoAbyssRewardView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ABYSSREWARD) as MonoAbyssRewardView;
		if (_monoAbyssRewardView == null)
		{
			return;
		}
		ReceiveButton.SetBtnClick(OnClickReceiveButtonHandle);
		AbyssData abyssData = _monoAbyssListView.GetAbyssData(_monoAbyssRewardView.SelectTabIndex);
		if (abyssData == null)
		{
			return;
		}
		S.SetActive(index == 0);
		A.SetActive(index == 1);
		B.SetActive(index == 2);
		rewardIndex = abyssData.timeReward.Length - 1 - index;
		Collection collection = RuntimeConfigs.data.collections[abyssData.timeReward[rewardIndex]];
		List<Item> list = new List<Item>();
		foreach (ItemKv item2 in collection.certain)
		{
			Item item = new Item
			{
				Id = item2.id,
				Count = item2.count
			};
			list.Add(item);
		}
		itemUnifierProxys = ListPool<ItemUnifierProxy>.Get();
		ItemUnifierProxy.ItemUnifierPool.GetList(list, itemUnifierProxys);
		commonScrollBagComponent.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		commonScrollBagComponent.ItemSource = itemUnifierProxys;
		ActivityCenterModel.ActivityRewardState rewardState = _monoAbyssRewardView.GetRewardState(rewardIndex);
		ReceiveButton.gameObject.SetActive(rewardState == ActivityCenterModel.ActivityRewardState.Receive);
		Received.SetActive(rewardState == ActivityCenterModel.ActivityRewardState.Received);
		Normal.SetActive(rewardState == ActivityCenterModel.ActivityRewardState.Normal);
		Lock.SetActive(rewardState == ActivityCenterModel.ActivityRewardState.Lock);
	}

	private void OnClickReceiveButtonHandle()
	{
		_monoAbyssListView.GetAbyssData(_monoAbyssRewardView.SelectTabIndex);
		G.service.AbyssTaskReward(rewardIndex + 1, Model<AbyssModel>.Interface.GroupId, _monoAbyssRewardView.SelectTabIndex, claimAll: false, (bool r, RepeatedField<UniversalItem> items) =>
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
				RefreshUI(index);
				_monoAbyssRewardView.RefreshTabItem();
			}
			Model<AbyssModel>.Interface.RefreshData();
		});
	}

	public void OnSelect(BaseEventData eventData)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			for (int i = 0; i < SelectHandle.Count; i++)
			{
				SelectHandle[i].SetActive(value: true);
			}
		}
		_monoAbyssRewardView.ControlLayerDic[AbyssRewardViewControllerType.ItemReward] = ViewControlLayer;
	}

	public void OnDeselect(BaseEventData eventData)
	{
		for (int i = 0; i < SelectHandle.Count; i++)
		{
			SelectHandle[i].SetActive(value: false);
		}
	}

	public void OnSubmit(BaseEventData eventData)
	{
		if (ReceiveButton.gameObject.activeSelf && ReceiveButton.IsInteractable())
		{
			ReceiveButton.OnSubmit(eventData);
		}
	}
}
