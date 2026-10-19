using System;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using Fundamental;
using Runtime.WaitSort;
using UnityEngine.Localization.Components;

namespace ACT.UI.ShopSubView;

public class ShopSecondTab : BaseTabToggle
{
	private ShopFirstTab _parentTab;

	public LocalizeStringEvent tabName;

	public LocalizeStringEvent selectedTabName;

	public RedDotItem redDotItem;

	private int _subShopId;

	private SubshopData _subShopData;

	public ShopFirstTab ParentTab
	{
		get
		{
			return _parentTab;
		}
		set
		{
			if (!(_parentTab == value))
			{
				_parentTab = value;
				UpdateRedDot();
			}
		}
	}

	public override int TabIdentify
	{
		get
		{
			return _subShopId;
		}
		set
		{
			if (_subShopId != value)
			{
				_subShopId = value;
				_subShopData = CoreUtils.GetData(_subShopId, RuntimeConfigs.data.subshopDatas);
				UpdateTabStyle();
				UpdateCanActiveLogic();
				UpdateRedDot();
			}
		}
	}

	public SubshopData SubShopData => _subShopData;

	public override Func<bool> CanActive { get; set; }

	private void UpdateTabStyle()
	{
		if (!(tabName == null) && _subShopData != null)
		{
			tabName.SetTable("shortcommon");
			tabName.StringReference.TableEntryReference = _subShopData.nameLocal;
			if (!(selectedTabName == null))
			{
				selectedTabName.SetTable("shortcommon");
				selectedTabName.StringReference.TableEntryReference = _subShopData.nameLocal;
			}
		}
	}

	private void UpdateRedDot()
	{
		if (redDotItem == null)
		{
			return;
		}
		int valueOrDefault = (ParentTab?.ShopData?.id).GetValueOrDefault();
		if (valueOrDefault == 0 || _subShopId == 0)
		{
			redDotItem.gameObject.SetActive(value: false);
			return;
		}
		string text = $"{RedDotPathDefine.Shop}|{valueOrDefault}|{_subShopId}";
		if (!Singleton<RedDotManager>.instance.IsPathRegistered(text))
		{
			Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(text, active: false, 1027);
		}
		redDotItem.InitRedDot(text);
	}

	private void UpdateCanActiveLogic()
	{
		CanActive = (IsBundleSubShop() ? new Func<bool>(CheckBundleCanActive) : new Func<bool>(DefaultCanActive));
	}

	private bool IsBundleSubShop()
	{
		if (_subShopData?.commodityIds == null)
		{
			return false;
		}
		int[] commodityIds = _subShopData.commodityIds;
		for (int i = 0; i < commodityIds.Length; i++)
		{
			if (CoreUtils.GetData(commodityIds[i], RuntimeConfigs.data.bundles) != null)
			{
				return true;
			}
		}
		return false;
	}

	private bool CheckBundleCanActive()
	{
		if (!DefaultCanActive())
		{
			return false;
		}
		if (_subShopData == null || _subShopData.commodityIds == null || _subShopData.commodityIds.Length == 0)
		{
			return false;
		}
		bool flag = ParentTab.Content is RecommendView;
		int[] commodityIds = _subShopData.commodityIds;
		foreach (int num in commodityIds)
		{
			if ((Model<ShopModel>.Interface.GoodsData.TryGetValue(num, out var value) || _subShopData.gmType == 1) && (!flag || Model<ShopModel>.Interface.BundleLeftCount(num) != 0) && (value == null || value.EndTime <= 0 || value.EndTime >= TimeManager.ServerTime.NowTimestampSecond))
			{
				return true;
			}
		}
		return false;
	}

	private bool DefaultCanActive()
	{
		if (Singleton<SystemBlockManager>.instance.IsBlocked(SystemType.Shop, _subShopId))
		{
			return false;
		}
		if (!HasListedCommodity())
		{
			return false;
		}
		if (_subShopData.soldoutType == 1)
		{
			return !AreAllListedCommoditiesSoldOut();
		}
		return true;
	}

	private bool HasListedCommodity()
	{
		if (_subShopData?.commodityIds == null || _subShopData.commodityIds.Length == 0)
		{
			return false;
		}
		int[] commodityIds = _subShopData.commodityIds;
		foreach (int key in commodityIds)
		{
			if (_subShopData.gmType == 1 || Model<ShopModel>.Interface.GoodsData.ContainsKey(key))
			{
				return true;
			}
		}
		return false;
	}

	private bool AreAllListedCommoditiesSoldOut()
	{
		int valueOrDefault = (ParentTab?.ShopData?.id).GetValueOrDefault();
		bool result = false;
		int[] commodityIds = _subShopData.commodityIds;
		foreach (int num in commodityIds)
		{
			if (_subShopData.gmType == 1 || Model<ShopModel>.Interface.GoodsData.ContainsKey(num))
			{
				result = true;
				if (!IsCommoditySoldOut(valueOrDefault, num))
				{
					return false;
				}
			}
		}
		return result;
	}

	private bool IsCommoditySoldOut(int shopId, int commodityId)
	{
		if (CoreUtils.GetData(commodityId, RuntimeConfigs.data.bundles) != null)
		{
			return Model<ShopModel>.Interface.BundleLeftCount(commodityId) == 0;
		}
		if (CoreUtils.GetData(commodityId, RuntimeConfigs.data.skinShops) != null)
		{
			return Model<ShopModel>.Interface.SkinItemLeftCount(commodityId) == 0;
		}
		ACT.Config.ExchangeShop data = CoreUtils.GetData(commodityId, RuntimeConfigs.data.exchangeShops);
		if (data == null)
		{
			return false;
		}
		int num = Model<ShopModel>.Interface.ExchangeItemLeftCount(shopId, _subShopId, commodityId);
		if (num != -1)
		{
			return num == 0;
		}
		SkinShop data2 = CoreUtils.GetData(data.itemId, RuntimeConfigs.data.skinShops);
		if (data2 != null)
		{
			return Model<ShopModel>.Interface.SkinItemLeftCount(data2.id) == 0;
		}
		return false;
	}
}
