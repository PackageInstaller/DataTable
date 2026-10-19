using System;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.WaitSort;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ShopFirstTab : BaseTabToggle
{
	[Header("Normal")]
	public LocalizeStringEvent normalTabName;

	public BImage normalTabIcon;

	[Header("Select")]
	public LocalizeStringEvent selectTabName;

	public BImage selectTabIcon;

	public RedDotItem redDotItem;

	private int _shopId;

	private ShopData _shopData;

	public override int TabIdentify
	{
		get
		{
			return _shopId;
		}
		set
		{
			if (_shopId != value)
			{
				_shopId = value;
				_shopData = CoreUtils.GetData(_shopId, RuntimeConfigs.data.shopDatas);
				UpdateTabStyle();
				UpdateRedDot();
			}
		}
	}

	public override Func<bool> CanActive => () =>
	{
		if (_shopData == null)
		{
			return false;
		}
		if (TimeManager.ServerTime.NowTimestamp < _shopData.shopStartTs || TimeManager.ServerTime.NowTimestamp > _shopData.shopEndTs)
		{
			return false;
		}
		if (_shopData.subshopIds == null || _shopData.subshopIds.Length == 0)
		{
			return false;
		}
		int[] subshopIds = _shopData.subshopIds;
		foreach (int num in subshopIds)
		{
			if (!Singleton<SystemBlockManager>.instance.IsBlocked(SystemType.Shop, num) && HasListedCommodity(num))
			{
				return true;
			}
		}
		return false;
	};

	public ShopData ShopData => _shopData;

	protected override void OnTabActive()
	{
		base.OnTabActive();
		_animation?.GetSequence("Select")?.Play();
	}

	protected override void OnTabDeActive()
	{
		base.OnTabDeActive();
		_animation?.GetSequence("Normal")?.Play();
	}

	public void UpdateTabStyle()
	{
		if (_shopData != null)
		{
			normalTabName.SetTable("shortcommon");
			normalTabName.StringReference.TableEntryReference = _shopData.nameLocal;
			Station?.LoadImageAsync(210, _shopId, normalTabIcon).Forget();
			selectTabName.SetTable("shortcommon");
			selectTabName.StringReference.TableEntryReference = _shopData.nameLocal;
			Station?.LoadImageAsync(209, _shopId, selectTabIcon).Forget();
		}
	}

	private void UpdateRedDot()
	{
		if (redDotItem == null)
		{
			return;
		}
		if (_shopId == 0)
		{
			redDotItem.gameObject.SetActive(value: false);
			return;
		}
		string text = $"{RedDotPathDefine.Shop}|{_shopId}";
		if (!Singleton<RedDotManager>.instance.IsPathRegistered(text))
		{
			Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(text, active: false, 1027);
		}
		redDotItem.InitRedDot(text);
	}

	private bool HasListedCommodity(int subShopId)
	{
		SubshopData data = CoreUtils.GetData(subShopId, RuntimeConfigs.data.subshopDatas);
		if (data?.commodityIds == null || data.commodityIds.Length == 0)
		{
			return false;
		}
		int[] commodityIds = data.commodityIds;
		foreach (int key in commodityIds)
		{
			if (data.gmType == 1 || Model<ShopModel>.Interface.GoodsData.ContainsKey(key))
			{
				return true;
			}
		}
		return false;
	}
}
