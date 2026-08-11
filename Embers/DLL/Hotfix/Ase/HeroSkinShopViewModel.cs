using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;
using Sirenix.Utilities;

namespace Ase;

public class HeroSkinShopViewModel : OptionBase
{
	private int curSubTabIndex;

	private TabItemData curSubTabItemData;

	private InteractionRequest refreshSubTabsRst = new InteractionRequest();

	private InteractionRequest refreshShopInfoRst = new InteractionRequest();

	private List<HeroSkinShopItemData> _filterDataList = new List<HeroSkinShopItemData>();

	private bool waitRefresh;

	private long leftRefreshTime = -1L;

	private string leftRefreshTimeText = "";

	private Timer timer;

	private bool openBuyWindowEnabled = true;

	private ShopInfoData _shopInfoData;

	public ShopInfoData ShopInfoData => _shopInfoData;

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

	public InteractionRequest RefreshShopInfoRst => refreshShopInfoRst;

	public List<HeroSkinShopItemData> FilterDataList => _filterDataList;

	public HeroSkinShopViewModel()
	{
	}

	public HeroSkinShopViewModel(OptionBase parent, int subTabIndex = 0)
	{
		base.parent = parent;
		CurSubTabIndex = subTabIndex;
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().BindShopNotify(OnShopNotify);
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
		RefreshShopData(HeroDefinition.GetHeroSkinShopMainId(), CurSubTabIndex, reRequest);
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetData().SetRead(CurSubTabIndex);
	}

	private void OnShopNotify(ShopRefreshNotify notify)
	{
		refreshSubTabsRst.Raise();
		RefreshShopData(HeroDefinition.GetHeroSkinShopMainId(), CurSubTabIndex, reRequest: false);
	}

	public async Task RequestData()
	{
		await RefreshShopsDatas(HeroDefinition.GetHeroSkinShopMainId());
	}

	private async Task RefreshShopsDatas(int mainShopId)
	{
		await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestShopDatas(mainShopId);
		refreshSubTabsRst.Raise();
	}

	private async void RefreshShopData(int mainShopId, int shopId, bool reRequest)
	{
		Loading loading = await Loading.Show();
		if (reRequest)
		{
			_shopInfoData = await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestShopData(mainShopId, shopId);
		}
		else
		{
			_shopInfoData = Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetData().GetShopData(mainShopId, shopId);
		}
		_filterDataList.Clear();
		if (_shopInfoData == null)
		{
			waitRefresh = false;
			leftRefreshTime = 0L;
			LeftRefreshTimeText = string.Empty;
		}
		else
		{
			if (_shopInfoData.WaitRefresh)
			{
				waitRefresh = true;
				leftRefreshTime = _shopInfoData.RefreshEndTime;
				LeftRefreshTimeText = "刷新倒计时:" + Utility.DateTime.GetLeftDateTime(leftRefreshTime, "dd\\天hh\\时mm\\分");
			}
			else
			{
				waitRefresh = false;
				leftRefreshTime = 0L;
				LeftRefreshTimeText = string.Empty;
			}
			_shopInfoData.ShopExcDatas.Values.ForEach(delegate(ShopExcData p)
			{
				_filterDataList.Add(new HeroSkinShopItemData(this, p));
			});
			FilterListSort();
		}
		loading.Dispose();
		refreshShopInfoRst.Raise();
	}

	private void FilterListSort()
	{
		_filterDataList.RemoveAll((HeroSkinShopItemData p) => p.GetSoldOutHide());
		_filterDataList.Sort(delegate(HeroSkinShopItemData a, HeroSkinShopItemData b)
		{
			bool flag = a.ExcData.QuotaNum < 0 || a.ExcData.LeftExc > 0;
			bool flag2 = b.ExcData.QuotaNum < 0 || b.ExcData.LeftExc > 0;
			return (flag != flag2) ? ((!flag) ? 1 : (-1)) : (a.ExcData.Sort.CompareTo(b.ExcData.Sort) * 10 + a.ExcData.ExcId.CompareTo(b.ExcData.ExcId));
		});
	}

	public void OnHeroSkinExchangeSucceed(HeroSkinExchangeViewModel excVm)
	{
		HeroSkinShopItemData heroSkinShopItemData = _filterDataList.Find((HeroSkinShopItemData p) => p.ConfigId == excVm.HeroSkinId);
		if (heroSkinShopItemData != null)
		{
			heroSkinShopItemData.Bought = true;
			if (heroSkinShopItemData.GetSoldOutHide())
			{
				RefreshShopData(HeroDefinition.GetHeroSkinShopMainId(), CurSubTabIndex, reRequest: false);
			}
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabItemData)
		{
			SetSubTabSelected(tabItemData, reRequest: true);
		}
		else if (obj is HeroSkinShopItemData selectShopItemData)
		{
			OpenHeroSkinBuyWindow(selectShopItemData);
		}
		else if (obj is OptionArg optionArg && "OnHeroSkinExchangeSucceed".Equals(optionArg.OptionName) && optionArg.Obj is HeroSkinExchangeViewModel excVm)
		{
			OnHeroSkinExchangeSucceed(excVm);
		}
	}

	private void OpenHeroSkinBuyWindow(HeroSkinShopItemData selectShopItemData)
	{
		if (openBuyWindowEnabled)
		{
			openBuyWindowEnabled = false;
			parent.ItemOnClick(new OpenViewArg(typeof(HeroSkinBuyWindow), new HeroSkinBuyViewModel(parent, _filterDataList, selectShopItemData), delegate
			{
				openBuyWindowEnabled = true;
			}));
		}
	}

	private void OnComplete()
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
				RefreshShopData(HeroDefinition.GetHeroSkinShopMainId(), CurSubTabIndex, reRequest: true);
			}
			if (leftRefreshTime >= 0)
			{
				LeftRefreshTimeText = "刷新倒计时:" + Utility.DateTime.GetLeftDateTime(leftRefreshTime, "dd\\天hh\\时mm\\分");
			}
		}
	}

	private void CancleTimer()
	{
		if (timer != null)
		{
			timer.Cancel();
			timer = null;
		}
	}

	public override void Dispose()
	{
		CancleTimer();
		Singleton<ServiceSystem>.Instance.GetService<IShopService>().RemoveBindShopNotify(OnShopNotify);
		base.Dispose();
	}
}
