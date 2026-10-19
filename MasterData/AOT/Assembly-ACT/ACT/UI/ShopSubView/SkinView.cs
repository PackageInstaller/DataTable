using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI.CommonComponent.CoinComponent;
using ACT.UI.Interface;
using UnityEngine.UI;

namespace ACT.UI.ShopSubView;

public class SkinView : BaseShopFirstSubView<SkinShopInputController>
{
	public LoopScrollRect skinLoopScrollRect;

	private SubshopData _subShopData;

	private List<int> _skinCommodityIds = new List<int>();

	protected override void Awake()
	{
		base.Awake();
		skinLoopScrollRect.OnItemShow.AddListener(OnSkinItemShow);
		ShopModel shopModel = Model<ShopModel>.Interface;
		shopModel.OnCommodityDataUpdate = (Action)Delegate.Combine(shopModel.OnCommodityDataUpdate, new Action(OnSkinDataChanged));
		ShopModel shopModel2 = Model<ShopModel>.Interface;
		shopModel2.OnShopDataUpdate = (Action)Delegate.Combine(shopModel2.OnShopDataUpdate, new Action(OnSkinDataChanged));
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		ShopModel shopModel = Model<ShopModel>.Interface;
		shopModel.OnCommodityDataUpdate = (Action)Delegate.Remove(shopModel.OnCommodityDataUpdate, new Action(OnSkinDataChanged));
		ShopModel shopModel2 = Model<ShopModel>.Interface;
		shopModel2.OnShopDataUpdate = (Action)Delegate.Remove(shopModel2.OnShopDataUpdate, new Action(OnSkinDataChanged));
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		_subShopData = CoreUtils.GetData(GetTargetOrDefaultSubShopId(), RuntimeConfigs.data.subshopDatas);
		Refresh();
		FocusIn();
		GetController()?.OnTabActive(tabItem);
		PlayFirstTabAnimation();
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		FocusOut();
		GetController()?.OnTabDeActive(tabItem);
	}

	private void Refresh()
	{
		RefreshCoinGroup();
		_skinCommodityIds.Clear();
		if (_subShopData?.commodityIds != null)
		{
			int[] commodityIds = _subShopData.commodityIds;
			foreach (int num in commodityIds)
			{
				if (_subShopData.gmType == 1 || Model<ShopModel>.Interface.GoodsData.ContainsKey(num))
				{
					_skinCommodityIds.Add(num);
				}
			}
		}
		_skinCommodityIds.RemoveAll(ShouldNotShow);
		_skinCommodityIds.Sort(SortCommodity);
		skinLoopScrollRect.totalCount = _skinCommodityIds.Count;
		skinLoopScrollRect.RefillCells();
		PlaySKinItemAnimation();
		ShopView.gamePadTipsComp.RegisterInputActions(new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeTable = "Common",
			localizeKey = 508
		}, new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeTable = "Common",
			localizeKey = 606
		});
	}

	private void OnSkinItemShow(ILoopScrollDataSource arg0)
	{
		if (arg0 is SkinItem skinItem)
		{
			skinItem.SkinShopId = _skinCommodityIds[skinItem.index];
			skinItem.ShopId = _shopFirstTab.TabIdentify;
			skinItem.SubShopId = _subShopData.id;
			skinItem.timerComponent.OnTimeOut = OnSkinDataChanged;
		}
	}

	private void RefreshCoinGroup()
	{
		if (_coinGroup == null)
		{
			return;
		}
		int[] array = _subShopData?.moneyId;
		if (array == null || array.Length <= 0)
		{
			_coinGroup.RefreshCoinComponents();
			return;
		}
		CoinComponentConfig[] array2 = new CoinComponentConfig[_subShopData.moneyId.Length];
		for (int i = 0; i < _subShopData.moneyId.Length; i++)
		{
			int num = _subShopData.moneyId[i];
			array2[i] = new CoinComponentConfig
			{
				itemId = num,
				hasPlusButton = (num == 98 || num == 97)
			};
		}
		_coinGroup.RefreshCoinComponents(array2);
	}

	private int SortCommodity(int x, int y)
	{
		int num = 0;
		int num2 = Model<ShopModel>.Interface.SkinItemLeftCount(x);
		int num3 = Model<ShopModel>.Interface.SkinItemLeftCount(y);
		bool flag = num2 == 0;
		bool flag2 = num3 == 0;
		if (flag != flag2)
		{
			num = (flag ? 1 : (-1));
		}
		if (num == 0)
		{
			int discountTagPriority = GetDiscountTagPriority(x);
			num = GetDiscountTagPriority(y) - discountTagPriority;
		}
		if (num == 0)
		{
			int num4 = CoreUtils.GetData(x, RuntimeConfigs.data.skinShops)?.quality ?? 0;
			num = (CoreUtils.GetData(y, RuntimeConfigs.data.skinShops)?.quality ?? 0) - num4;
		}
		if (num == 0)
		{
			num = y - x;
		}
		return num;
	}

	private int GetDiscountTagPriority(int commodityId)
	{
		SkinShop data = CoreUtils.GetData(commodityId, RuntimeConfigs.data.skinShops);
		if (data?.tag == null || data.tag.Length == 0)
		{
			return 0;
		}
		if (data.tag.Contains(1))
		{
			return 2;
		}
		return 1;
	}

	private bool ShouldNotShow(int commodityId)
	{
		if (_subShopData.gmType != 1 && !Model<ShopModel>.Interface.GoodsData.ContainsKey(commodityId))
		{
			return true;
		}
		return Model<ShopModel>.Interface.CommodityLeftTime(commodityId) == 0;
	}

	private void OnSkinDataChanged()
	{
		Refresh();
	}

	private void PlaySKinItemAnimation()
	{
		for (int i = 0; i < skinLoopScrollRect.Children.Count; i++)
		{
			SkinItem component = skinLoopScrollRect.Children[i].GetComponent<SkinItem>();
			component?.betterAnimation?.GetSequence("Show").Goto(0f).SetDelay(0.03f * (float)i)
				.Play();
			component?.tagBetterAnimation?.GetSequence("Show").Goto(0f).SetDelay(0.03f * (float)i)
				.Play();
		}
	}
}
