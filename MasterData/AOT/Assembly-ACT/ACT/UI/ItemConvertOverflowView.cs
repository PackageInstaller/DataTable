using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ItemConvertOverflowView : BaseUIView<ItemConvertOverFlowInputController>
{
	public CommonScrollBagComponent fromItemScrollBag;

	public CommonScrollBagComponent toItemScrollBag;

	public ActButton confirmButton;

	public ActButton cancelButton;

	public LocalizeStringEvent itemOverFlowDescription;

	[Header("手柄输入提示")]
	public ViewControlRoot viewControlRoot;

	public ViewControlLayer itemControlLayer;

	public ViewControlLayer btnGroupControlLayer;

	public GamePadTipsComp gamePadTipsComp;

	private ItemConvertOverflowViewData m_data;

	private readonly List<ItemUnifierProxy> _fromItems = new List<ItemUnifierProxy>();

	private readonly List<ItemUnifierProxy> _toItems = new List<ItemUnifierProxy>();

	private const int ItemOverFlowDes = 2840;

	private void Awake()
	{
		confirmButton?.SetBtnClick(OnConfirmButtonClick);
		cancelButton?.SetBtnClick(Close);
	}

	protected override void Init()
	{
		base.Init();
		m_data = uiViewData as ItemConvertOverflowViewData;
		List<ItemKv> list = m_data?.Items;
		if (list == null || list.Count <= 0)
		{
			Close();
		}
		else
		{
			RefreshItems();
		}
	}

	private void RefreshItems()
	{
		ReleaseItems();
		foreach (ItemKv item in m_data.Items)
		{
			if (item != null && item.count > 0 && RuntimeConfigs.data.itemDatas.TryGetValue(item.id, out var value))
			{
				List<ItemKv> deleteCompensate = value.deleteCompensate;
				if (deleteCompensate != null && deleteCompensate.Count > 0)
				{
					itemOverFlowDescription.SetReference(LocalizeTable.Common, 2840);
					itemOverFlowDescription.GetVariable<string>("0").Value = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.nameLocal);
					_fromItems.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.id, item.count));
					foreach (ItemKv item2 in value.deleteCompensate)
					{
						if (item2 != null && item2.id > 0 && item2.count > 0)
						{
							_toItems.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item2.id, (long)item.count * (long)item2.count));
						}
					}
					continue;
				}
			}
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"道具： {item.id} 的删除转化材料字段没配值，检查一下item表");
			}
		}
		if (_fromItems.Count == 0 || _toItems.Count == 0)
		{
			Close();
			return;
		}
		RefreshItemScrollBag(fromItemScrollBag, _fromItems);
		RefreshItemScrollBag(toItemScrollBag, _toItems);
	}

	private void RefreshItemScrollBag(CommonScrollBagComponent scrollBag, List<ItemUnifierProxy> items)
	{
		if (!(scrollBag == null))
		{
			scrollBag.ClearBag();
			scrollBag.Station = Station;
			scrollBag.ItemShowType = ItemUIComponentBase.InitType.RewardItem;
			scrollBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
			scrollBag.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
			scrollBag.ItemSource = items;
		}
	}

	private void ReleaseItems()
	{
		fromItemScrollBag?.ClearBag();
		toItemScrollBag?.ClearBag();
		ItemUnifierProxy.ItemUnifierPool.Release(_fromItems);
		ItemUnifierProxy.ItemUnifierPool.Release(_toItems);
		_fromItems.Clear();
		_toItems.Clear();
	}

	private void OnConfirmButtonClick()
	{
		m_data?.ConfirmAction?.Invoke();
		Close();
	}

	protected override void UnInit()
	{
		ReleaseItems();
		m_data = null;
		base.UnInit();
	}
}
