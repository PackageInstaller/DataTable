using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.Interface;
using ACT.UI.ShopSubView;
using ACT.UI.ShopSubView.GiftCenterSecondSubView;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class BundleShop : BaseShopSecondSubView<BundleShopViewInputController>
{
	public LoopScrollRect loopScrollRect;

	private List<int> _commodityIds = new List<int>();

	private readonly HashSet<int> _redDotCommodityIds = new HashSet<int>();

	public int BundleId { get; set; }

	private void Awake()
	{
		PayModel payModel = Model<PayModel>.Interface;
		payModel.OnPaySuccess = (Action<string>)Delegate.Combine(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
		PayModel payModel2 = Model<PayModel>.Interface;
		payModel2.OnExchangeSuccess = (Action<int>)Delegate.Combine(payModel2.OnExchangeSuccess, new Action<int>(OnExchangeSuccess));
		loopScrollRect.OnItemShow.AddListener(OnItemShow);
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		PayModel payModel = Model<PayModel>.Interface;
		payModel.OnPaySuccess = (Action<string>)Delegate.Remove(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
		PayModel payModel2 = Model<PayModel>.Interface;
		payModel2.OnExchangeSuccess = (Action<int>)Delegate.Remove(payModel2.OnExchangeSuccess, new Action<int>(OnExchangeSuccess));
		loopScrollRect.OnItemShow.RemoveListener(OnItemShow);
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		Refresh();
		GetController()?.OnTabActive(tabItem);
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		loopScrollRect.GetComponent<ViewControlLayer>()?.Focus();
		GetController()?.OnTabDeActive(tabItem);
	}

	private void Refresh()
	{
		_commodityIds.Clear();
		if (ShopSecondTab.SubShopData.commodityIds != null)
		{
			_commodityIds.AddRange(ShopSecondTab.SubShopData.commodityIds);
		}
		_commodityIds.RemoveAll(ShouldNotShow);
		CacheRedDotCommodityIds();
		_commodityIds.Sort(SortCommodity);
		if (!loopScrollRect)
		{
			return;
		}
		loopScrollRect.totalCount = _commodityIds.Count;
		loopScrollRect.RefillCells();
		for (int i = 0; i < loopScrollRect.Children.Count; i++)
		{
			RectTransform rectTransform = loopScrollRect.Children[i];
			rectTransform.GetComponent<BetterAnimation>().GetSequence("Show").Goto(0f)
				.SetDelay((float)i * 0.05f)
				.Play();
			BundleItem component = rectTransform.GetComponent<BundleItem>();
			if ((bool)component && !component.IsBundleMode)
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Store/MonthlyCard_3");
			}
		}
	}

	private void OnItemShow(ILoopScrollDataSource item)
	{
		if (item is BundleItem bundleItem)
		{
			bundleItem.ShopId = (ShopSecondTab?.ParentTab?.ShopData?.id).GetValueOrDefault();
			bundleItem.SubShopId = ShopSecondTab?.TabIdentify ?? 0;
			bundleItem.BundleID = _commodityIds[bundleItem.index];
			bundleItem.rebateTimer.OnTimeOut = Refresh;
			bundleItem.GetComponent<BetterAnimation>()?.GetSequence("Show").Complete();
		}
	}

	private void CacheRedDotCommodityIds()
	{
		_redDotCommodityIds.Clear();
		int valueOrDefault = (ShopSecondTab?.ParentTab?.ShopData?.id).GetValueOrDefault();
		int num = ShopSecondTab?.TabIdentify ?? 0;
		if (valueOrDefault == 0 || num == 0)
		{
			return;
		}
		for (int i = 0; i < _commodityIds.Count; i++)
		{
			int num2 = _commodityIds[i];
			if (Model<ShopModel>.Interface.IsBundleRedDotActive(valueOrDefault, num, num2))
			{
				_redDotCommodityIds.Add(num2);
			}
		}
	}

	private int SortCommodity(int x, int y)
	{
		bool flag = _redDotCommodityIds.Contains(x);
		bool flag2 = _redDotCommodityIds.Contains(y);
		if (flag != flag2)
		{
			if (!flag)
			{
				return 1;
			}
			return -1;
		}
		int num = Model<ShopModel>.Interface.BundleLeftCount(x);
		int num2 = Model<ShopModel>.Interface.BundleLeftCount(y);
		if (num > 0 && num2 == 0)
		{
			return -1;
		}
		if (num == 0 && num2 > 0)
		{
			return 1;
		}
		return 0;
	}

	private bool ShouldNotShow(int commodityId)
	{
		if (ShopSecondTab.SubShopData.gmType != 1 && !Model<ShopModel>.Interface.GoodsData.ContainsKey(commodityId))
		{
			return true;
		}
		if (Model<ShopModel>.Interface.CommodityLeftTime(commodityId) == 0L)
		{
			return true;
		}
		Bundle data = CoreUtils.GetData(commodityId, RuntimeConfigs.data.bundles);
		if (data == null)
		{
			return CoreUtils.GetData(commodityId, RuntimeConfigs.data.monthlyPasss) == null;
		}
		if (IsPermanentLimitSoldOut(commodityId))
		{
			return true;
		}
		if (data.type != 5)
		{
			return false;
		}
		BundleData bundleData = Model<ShopModel>.Interface.BundleData;
		if (bundleData.BundleInfo.TryGetValue(commodityId, out var value))
		{
			return true;
		}
		if (data.prebundle == 0)
		{
			return false;
		}
		return !bundleData.BundleInfo.TryGetValue(data.prebundle, out value);
	}

	private bool IsPermanentLimitSoldOut(int commodityId)
	{
		Bundle data = CoreUtils.GetData(commodityId, RuntimeConfigs.data.bundles);
		if (data == null || data.limitCount <= 0)
		{
			return false;
		}
		if (data.limitRefreshType != 0)
		{
			return false;
		}
		return Model<ShopModel>.Interface.BundleLeftCount(commodityId) <= 0;
	}

	private void OnPaySuccess(string obj)
	{
		Refresh();
	}

	private void OnExchangeSuccess(int commodityId)
	{
		if (_commodityIds.Contains(commodityId))
		{
			Refresh();
		}
	}
}
