#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Sirenix.Utilities;

namespace Ase;

public class HomeShopWindowViewModel : OptionBase
{
	private long startShopId;

	private long curShopId;

	private long selfShopId;

	private string tipsText;

	private InteractionRequest<HomeShopInfoData> refreshShopInfoRst = new InteractionRequest<HomeShopInfoData>();

	private SimpleCommand openShopListCmd;

	private List<ShopGoodItemData> _filterDataList = new List<ShopGoodItemData>();

	private HomeFriendShopListViewModel friendShopListVm;

	private PropExchangeViewModel exchangeViewModel;

	private long leftRefreshTime = -1L;

	private string leftRefreshTimeText = "";

	private Timer timer;

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

	public string TipsText
	{
		get
		{
			return tipsText;
		}
		set
		{
			Set(ref tipsText, value, "TipsText");
		}
	}

	public SimpleCommand OpenShopListCmd => openShopListCmd;

	public InteractionRequest<HomeShopInfoData> RefreshShopInfoRst => refreshShopInfoRst;

	public List<ShopGoodItemData> FilterDataList => _filterDataList;

	public HomeShopWindowViewModel()
	{
	}

	public HomeShopWindowViewModel(OptionBase parent, long shopId)
	{
		base.parent = parent;
		selfShopId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
		startShopId = shopId;
		openShopListCmd = new SimpleCommand(OpenShopListView);
		TipsText = GameEntry.DataTable.GetDataRow<DRBuildingInfo>(3)?.PlayDesc ?? "";
		TipsText = TipsText.Replace("\\n", "\n");
		exchangeViewModel = new PropExchangeViewModel(this);
		AddChild(exchangeViewModel);
	}

	public async Task<bool> OnOpenBefore()
	{
		return await RefreshShopData(startShopId, reRequest: false);
	}

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ShopGoodItemData goodItemData)
		{
			OnGoodItemClick(goodItemData);
		}
		else if (obj is OptionArg optionArg)
		{
			if ("OnConfirmExc".Equals(optionArg.OptionName))
			{
				await OnConfirmExc();
			}
		}
		else if (obj is PropGetViewModel userData)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData));
		}
		else if (obj is HomeShopListItemData homeShopListItemData)
		{
			RefreshShopData(homeShopListItemData.PlayerData.Uid, reRequest: false);
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
	}

	public bool StartTimer()
	{
		try
		{
			timer = Timer.Register(1f, OnComplete, null, isLooped: true, useRealTime: true);
		}
		catch (Exception)
		{
			Log.Error("ShopWindow：开启计时器失败");
			return false;
		}
		return true;
	}

	private async Task OnGoodItemClick(ShopGoodItemData goodItemData)
	{
		if (goodItemData != null)
		{
			ShopDefinition.OnShopGoodItemClick(goodItemData.ExcData, exchangeViewModel, this, "HomeShop");
		}
	}

	private async Task<bool> RefreshShopData(long shopId, bool reRequest)
	{
		showViewRequest.Raise(new ShowViewArg(exchangeViewModel, isShow: false));
		Loading loading = null;
		IHomeLandService service = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>();
		new HomeShopInfoData();
		bool isSelfShop = selfShopId.Equals(shopId);
		HomeShopInfoData homeShopInfoData;
		if (isSelfShop)
		{
			if (reRequest)
			{
				loading = await Loading.Show();
				await service.RequestShopData();
			}
			homeShopInfoData = service.GetSelfHomeShopData();
		}
		else
		{
			if (reRequest)
			{
				loading = await Loading.Show();
				await service.RequestEnterFriendShop(shopId);
			}
			homeShopInfoData = service.GetFriendHomeShopData(shopId);
			if (homeShopInfoData == null)
			{
				if (loading == null)
				{
					loading = await Loading.Show();
				}
				await service.RequestEnterFriendShop(shopId);
				homeShopInfoData = service.GetFriendHomeShopData(shopId);
			}
		}
		loading?.Dispose();
		if (!isSelfShop)
		{
			if (homeShopInfoData == null)
			{
				return false;
			}
			if (!homeShopInfoData.GetFriendOpenState())
			{
				Toast.ShowInfo("今天新加的好友不能购买");
				return false;
			}
		}
		curShopId = shopId;
		_filterDataList.Clear();
		homeShopInfoData?.ShopExcDatas.Values.ForEach(delegate(ShopExcData p)
		{
			if (p.Prop != null)
			{
				_filterDataList.Add(new ShopGoodItemData(this, p));
			}
		});
		FilterListSort();
		refreshShopInfoRst.Raise(homeShopInfoData);
		RefreshTimer();
		return true;
	}

	private async void RefreshFriendShopList(bool request)
	{
		List<HomeShopInfoData> shopDatas = ((!request) ? Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetAllFriendHomeShopDatas() : (await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().RequestAllFriendShopList()));
		friendShopListVm?.Refresh(curShopId, shopDatas);
	}

	private void RefreshTimer()
	{
		ITimeService service = Singleton<ServiceSystem>.Instance.GetService<ITimeService>();
		if (service != null)
		{
			leftRefreshTime = service.GetLeftUpdateSeconds();
			LeftRefreshTimeText = "刷新倒计时:" + Utility.DateTime.GetLeftDateTime(leftRefreshTime, "hh\\时mm\\分");
		}
	}

	private async Task OnConfirmExc()
	{
		object exchangeData = exchangeViewModel.ExchangeData;
		if (exchangeData is HomeShopExcData shopExcData)
		{
			Loading loading = await Loading.Show();
			List<PropDataBase> list = ((!curShopId.Equals(selfShopId)) ? (await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().RequestFriendShopBuy(curShopId, shopExcData.ExcId, exchangeViewModel.UseCount)) : (await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().RequestShopBuy(shopExcData.ExcId, exchangeViewModel.UseCount)));
			loading.Dispose();
			if (list != null)
			{
				PropGetViewModel userData = new PropGetViewModel(this, list);
				openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData));
				OnExchangeSucceed(shopExcData.ExcId, exchangeViewModel.UseCount);
				exchangeViewModel.SetData(shopExcData);
				showViewRequest.Raise(new ShowViewArg(exchangeViewModel, isShow: false));
			}
		}
		exchangeViewModel.OnEnable();
	}

	private void OnExchangeSucceed(int gridId, int buyCount)
	{
		if (friendShopListVm != null)
		{
			RefreshFriendShopList(request: false);
		}
		foreach (ShopGoodItemData filterData in _filterDataList)
		{
			if (filterData.ExcData.ExcId == gridId)
			{
				filterData.OnExchangeSucceed(buyCount);
				break;
			}
		}
		FilterListSort();
	}

	private async void OpenShopListView()
	{
		openShopListCmd.Enabled = false;
		IHomeLandService service = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>();
		bool valueOrDefault = service?.GetHomeShopViewModel()?.GetFriendHomeShopRefreshRed() == true;
		if ((service?.GetHomeShopViewModel()?.CheckFriendHomeShopOpened() == true) & valueOrDefault)
		{
			service?.GetHomeShopViewModel()?.SetFriendHomeShopRefreshRead();
		}
		Loading obj = await Loading.Show();
		bool request = false;
		if (friendShopListVm == null)
		{
			request = true;
			friendShopListVm = new HomeFriendShopListViewModel(this);
		}
		OpenViewArg context = new OpenViewArg(typeof(HomeFriendShopListView), friendShopListVm, "HomeShop", isOpenWindow: false);
		openWindowRequest.Raise(context, delegate
		{
			openShopListCmd.Enabled = true;
		});
		RefreshFriendShopList(request);
		obj.Dispose();
	}

	public void OnBtnBackClick()
	{
		if (startShopId != selfShopId || curShopId == selfShopId)
		{
			Close();
		}
		else
		{
			RefreshShopData(selfShopId, reRequest: false);
		}
	}

	private void FilterListSort()
	{
		_filterDataList.Sort(delegate(ShopGoodItemData a, ShopGoodItemData b)
		{
			bool flag = a.ExcData.QuotaNum < 0 || a.ExcData.LeftExc > 0;
			bool flag2 = b.ExcData.QuotaNum < 0 || b.ExcData.LeftExc > 0;
			return (flag != flag2) ? ((!flag) ? 1 : (-1)) : a.ExcData.ExcId.CompareTo(b.ExcData.ExcId);
		});
		refreshShopInfoRst.Raise(null);
	}

	private void OnComplete()
	{
		leftRefreshTime--;
		if (leftRefreshTime == 0L)
		{
			RefreshShopData(curShopId, reRequest: true);
		}
		if (leftRefreshTime >= 0)
		{
			LeftRefreshTimeText = "刷新倒计时:" + Utility.DateTime.GetLeftDateTime(leftRefreshTime, "hh\\时mm\\分");
		}
	}

	private void CancelTimer()
	{
		if (timer != null)
		{
			timer.Cancel();
			timer = null;
		}
	}

	public override void Close()
	{
		CancelTimer();
		base.Close();
	}
}
