using System;
using System.Collections.Generic;
using ACT.UI.DataProxy;
using Bamboo.ImageCenter;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;

namespace ACT.UI;

public class CommonSubWorldEntranceRewards : MonoBehaviour
{
	[SerializeField]
	private CommonScrollBagComponent CommonScrollBagComponent;

	[SerializeField]
	private GameObject doubleGameObject;

	public Action<ItemUIComponentBase> OnItemShowAction;

	public void RefreshUI(List<ItemUnifierProxy> itemUnifierProxies, ImageAssetStation station)
	{
		RefreshUIInternal(itemUnifierProxies, station, ItemUIComponentBase.InitType.WorldSettlementRewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
	}

	public void RefreshUI(List<ItemUnifierProxy> itemUnifierProxies, ImageAssetStation station, ItemUIComponentBase.ItemCountShowType itemCountShowType)
	{
		RefreshUIInternal(itemUnifierProxies, station, ItemUIComponentBase.InitType.WorldSettlementRewardItem, itemCountShowType);
	}

	public void RefreshUI(List<ItemUnifierProxy> itemUnifierProxies, ImageAssetStation station, ItemUIComponentBase.InitType itemShowType, Action<ItemUIComponentBase> onItemShow)
	{
		OnItemShowAction = onItemShow;
		RefreshUIInternal(itemUnifierProxies, station, itemShowType, ItemUIComponentBase.ItemCountShowType.OneSide);
	}

	private void RefreshUIInternal(List<ItemUnifierProxy> itemUnifierProxies, ImageAssetStation station, ItemUIComponentBase.InitType itemShowType, ItemUIComponentBase.ItemCountShowType itemCountShowType)
	{
		CommonScrollBagComponent.OnItemShow = null;
		CommonScrollBagComponent commonScrollBagComponent = CommonScrollBagComponent;
		commonScrollBagComponent.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent.OnItemShow, new Action<ItemUIComponentBase>(OnItemShow));
		CommonScrollBagComponent.Station = station;
		CommonScrollBagComponent.ItemShowType = itemShowType;
		CommonScrollBagComponent.CountShowType = itemCountShowType;
		CommonScrollBagComponent.ItemSource = itemUnifierProxies;
	}

	private void OnItemShow(ItemUIComponentBase itemUIComponentBase)
	{
		OnItemShowAction?.Invoke(itemUIComponentBase);
	}

	public void UpdateDoubleTagVisible(bool isVisible)
	{
		doubleGameObject.SetActive(isVisible);
	}
}
