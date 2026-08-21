#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Sirenix.Utilities;

namespace Ase;

public class ShopViewDataBase : OptionBase
{
	protected int curTabIndex;

	protected int curSubTabIndex;

	protected TabItemData curSubTabItemData;

	protected InteractionRequest refreshSubTabsRst = new InteractionRequest();

	protected InteractionRequest<ShopInfoData> refreshShopInfoRst = new InteractionRequest<ShopInfoData>();

	public bool WaitRefreshShopInfo;

	protected List<ShopGoodItemData> _filterDataList = new List<ShopGoodItemData>();

	protected ShopInfoData curShopInfoData;

	protected string shopTips = string.Empty;

	protected bool waitRefresh;

	protected long leftRefreshTime = -1L;

	protected string leftRefreshTimeText = "";

	protected Timer timer;

	public int CurTabIndex
	{
		get
		{
			return curTabIndex;
		}
		set
		{
			Set(ref curTabIndex, value, "CurTabIndex");
		}
	}

	public int CurSubTabIndex
	{
		get
		{
			return curSubTabIndex;
		}
		set
		{
			Set(ref curSubTabIndex, value, "CurSubTabIndex");
		}
	}

	public string LeftRefreshTimeText
	{
		get
		{
			return leftRefreshTimeText;
		}
		private set
		{
			Set(ref leftRefreshTimeText, value, "LeftRefreshTimeText");
		}
	}

	public InteractionRequest RefreshSubTabsRst => refreshSubTabsRst;

	public InteractionRequest<ShopInfoData> RefreshShopInfoRst => refreshShopInfoRst;

	public List<ShopGoodItemData> FilterDataList => _filterDataList;

	public ShopInfoData CurShopInfoData
	{
		get
		{
			return curShopInfoData;
		}
		protected set
		{
			Set(ref curShopInfoData, value, "CurShopInfoData");
			ShopTips = value?.Tips ?? string.Empty;
		}
	}

	public string ShopTips
	{
		get
		{
			return shopTips;
		}
		protected set
		{
			Set(ref shopTips, value, "ShopTips");
		}
	}

	public ShopViewDataBase()
	{
	}

	public ShopViewDataBase(OptionBase parent, int subTabIndex = 0)
	{
		base.parent = parent;
		CurSubTabIndex = subTabIndex;
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().BindShopNotify(OnShopNotify);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabItemData)
		{
			SetSubTabSelected(tabItemData, reRequest: true);
		}
		else if (obj is ShopGoodItemData obj2)
		{
			parent?.ItemOnClick(obj2);
		}
		else if (obj is OptionArg optionArg)
		{
			if ("OnConfirmExc".Equals(optionArg.OptionName))
			{
				parent?.ItemOnClick(optionArg);
			}
			else if ("RefetchShopInfo".Equals(optionArg.OptionName))
			{
				RefreshShopData(CurTabIndex, CurSubTabIndex, reRequest: true);
			}
		}
	}

	public new async Task<bool> OnOpen()
	{
		if (timer != null)
		{
			return true;
		}
		try
		{
			timer = Timer.Register(1f, OnComplete, null, isLooped: true, useRealTime: true);
		}
		catch (Exception)
		{
			Log.Error("ShopViewDataBase：开启计时器失败");
			return false;
		}
		return true;
	}

	private void OnShopNotify(ShopRefreshNotify notify)
	{
		refreshSubTabsRst.Raise();
		RefreshShopData(CurTabIndex, CurSubTabIndex, reRequest: false);
	}

	public void SetSubTabSelected(TabItemData tabItemData, bool reRequest)
	{
		if (curSubTabItemData != null)
		{
			curSubTabItemData.IsSelected = false;
		}
		tabItemData.IsSelected = true;
		curSubTabItemData = tabItemData;
		CurSubTabIndex = tabItemData.TabIndex;
		RefreshShopData(CurTabIndex, CurSubTabIndex, reRequest);
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetData().SetRead(CurSubTabIndex);
	}

	public virtual async UniTask RequestData()
	{
		await RequestData(CurTabIndex);
	}

	protected async Task RequestData(int mainShopId)
	{
		await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestShopDatas(mainShopId);
		refreshSubTabsRst.Raise();
	}

	protected async UniTask RefreshShopData(int mainShopId, int shopId, bool reRequest)
	{
		ShopInfoData shopInfoData;
		if (reRequest)
		{
			Loading loading = await Loading.Show();
			shopInfoData = await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestShopData(mainShopId, shopId);
			loading?.Dispose();
		}
		else
		{
			shopInfoData = Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetData().GetShopData(mainShopId, shopId);
		}
		CurShopInfoData = shopInfoData;
		_filterDataList.Clear();
		if (shopInfoData == null)
		{
			waitRefresh = false;
			leftRefreshTime = 0L;
			LeftRefreshTimeText = string.Empty;
		}
		else
		{
			if (shopInfoData.WaitRefresh)
			{
				waitRefresh = true;
				leftRefreshTime = shopInfoData.RefreshEndTime;
				LeftRefreshTimeText = "刷新倒计时:" + Utility.DateTime.GetLeftDateTime(leftRefreshTime, "dd\\天hh\\时mm\\分");
			}
			else
			{
				waitRefresh = false;
				leftRefreshTime = 0L;
				LeftRefreshTimeText = string.Empty;
			}
			shopInfoData.ShopExcDatas.Values.ForEach(delegate(ShopExcData p)
			{
				_filterDataList.Add(new ShopGoodItemData(this, p));
			});
			FilterListSort();
		}
		WaitRefreshShopInfo = true;
		refreshShopInfoRst.Raise(shopInfoData);
	}

	public void OnExchangeSucceed(int mainShopId, int shopId, int excId, int useCount)
	{
		if (mainShopId != CurTabIndex || CurSubTabIndex != shopId)
		{
			return;
		}
		foreach (ShopGoodItemData filterData in _filterDataList)
		{
			if (filterData.ExcData.MainShopId == mainShopId && filterData.ExcData.ShopId == shopId && filterData.ExcData.ExcId == excId)
			{
				filterData.OnExchangeSucceed(useCount);
				break;
			}
		}
		FilterListSort();
		WaitRefreshShopInfo = true;
		refreshShopInfoRst.Raise(null);
	}

	protected void FilterListSort()
	{
		ShopDefinition.FilterListSort(_filterDataList);
	}

	protected void OnComplete()
	{
		for (int i = 0; i < _filterDataList.Count; i++)
		{
			_filterDataList[i].OnTimerUpdate();
		}
		if (waitRefresh)
		{
			leftRefreshTime--;
			if (leftRefreshTime == 0L)
			{
				RefreshShopData(CurTabIndex, CurSubTabIndex, reRequest: true);
			}
			if (leftRefreshTime >= 0)
			{
				LeftRefreshTimeText = "刷新倒计时:" + Utility.DateTime.GetLeftDateTime(leftRefreshTime, "dd\\天hh\\时mm\\分");
			}
		}
	}

	protected void CancelTimer()
	{
		if (timer != null)
		{
			timer.Cancel();
			timer = null;
		}
	}

	public override void Dispose()
	{
		CancelTimer();
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().RemoveBindShopNotify(OnShopNotify);
		base.Dispose();
	}
}
