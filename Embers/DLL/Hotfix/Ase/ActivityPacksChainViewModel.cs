using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ActivityPacksChainViewModel : ActivityViewModelBase
{
	private List<ActivityPacksChainItemData> _itemDataList = new List<ActivityPacksChainItemData>();

	private DRActivityPacksChain _configData;

	private bool _showBuyAll;

	private string _buyTips;

	private string _priceIcon = "";

	private string _desc;

	private bool _isCashPrice;

	private bool _allBought;

	private float _curPrice;

	private string _curPriceText;

	private string _oriPriceText;

	private SimpleCommand<ActivityPacksChainItemData> _buyCmd;

	private ISubscription<UserPayNotify> userPayNotify;

	public SimpleCommand<ActivityPacksChainItemData> BuyCmd => _buyCmd;

	public bool ShowBuyAll
	{
		get
		{
			return _showBuyAll;
		}
		set
		{
			Set(ref _showBuyAll, value, "ShowBuyAll");
		}
	}

	public string BuyTips
	{
		get
		{
			return _buyTips;
		}
		set
		{
			Set(ref _buyTips, value, "BuyTips");
		}
	}

	public string PriceIcon
	{
		get
		{
			return _priceIcon;
		}
		set
		{
			Set(ref _priceIcon, value, "PriceIcon");
		}
	}

	public string Desc
	{
		get
		{
			return _desc;
		}
		set
		{
			Set(ref _desc, value, "Desc");
		}
	}

	public bool IsCashPrice
	{
		get
		{
			return _isCashPrice;
		}
		set
		{
			Set(ref _isCashPrice, value, "IsCashPrice");
		}
	}

	public string CurPriceText
	{
		get
		{
			return _curPriceText;
		}
		set
		{
			Set(ref _curPriceText, value, "CurPriceText");
		}
	}

	public string OriPriceText
	{
		get
		{
			return _oriPriceText;
		}
		set
		{
			Set(ref _oriPriceText, value, "OriPriceText");
		}
	}

	public bool AllBought
	{
		get
		{
			return _allBought;
		}
		set
		{
			Set(ref _allBought, value, "AllBought");
		}
	}

	public List<ActivityPacksChainItemData> ItemDataList => _itemDataList;

	public ActivityPacksChainViewModel()
	{
		_buyCmd = new SimpleCommand<ActivityPacksChainItemData>(TryBuy);
		userPayNotify = Singleton<NetworkSystem>.Instance.Subscribe<UserPayNotify>(OnUserPayNotify);
	}

	public override void Init(OpActViewModel opActViewModel, DRActivityType drData)
	{
		base.Init(opActViewModel, drData);
		_configData = GameEntry.DataTable.GetDataRow((DRActivityPacksChain p) => p.ActivityId == base.ActivityTypeId);
	}

	public override void SetServiceTaskData(List<ActivityTaskData> taskDataList)
	{
		base.SetServiceTaskData(taskDataList);
		if (taskDataList == null)
		{
			return;
		}
		_itemDataList.Clear();
		foreach (ActivityTaskData taskData in taskDataList)
		{
			DRPacksChainInclude dataRow = GameEntry.DataTable.GetDataRow<DRPacksChainInclude>(taskData.Id);
			if (dataRow == null)
			{
				continue;
			}
			int unlockTaskId = dataRow.UnlockTaskId;
			if (unlockTaskId > 0)
			{
				DRPacksChainInclude drPreData = GameEntry.DataTable.GetDataRow<DRPacksChainInclude>(unlockTaskId);
				if (drPreData != null)
				{
					taskDataList.Exists((ActivityTaskData p) => p.Id == drPreData.ActivityTaskId && taskData.CompleteState == 1);
				}
			}
			_itemDataList.Add(new ActivityPacksChainItemData(this, taskData));
		}
		_itemDataList.Sort((ActivityPacksChainItemData a, ActivityPacksChainItemData b) => a.Sort.CompareTo(b.Sort));
		RefreshItemState();
		RefreshPriceData();
	}

	private void RefreshItemState()
	{
		foreach (ActivityPacksChainItemData itemData in _itemDataList)
		{
			DRPacksChainInclude configData = itemData.ConfigData;
			int unlockChainIncludeId = configData.UnlockTaskId;
			bool unlock = false;
			if (unlockChainIncludeId <= 0)
			{
				unlock = true;
			}
			else if (GameEntry.DataTable.GetDataRow<DRPacksChainInclude>(unlockChainIncludeId) != null)
			{
				unlock = base.PbTaskDataList.Exists((ActivityTaskData p) => p.Id == unlockChainIncludeId && p.CompleteState == 1);
			}
			itemData.Unlock = unlock;
			itemData.Bought = itemData.TaskData.CompleteState == 1;
		}
	}

	private void RefreshPriceData()
	{
		if (_configData == null)
		{
			return;
		}
		ShowBuyAll = _configData.SoldOneTime;
		if (!ShowBuyAll)
		{
			return;
		}
		Desc = _configData.Desc;
		BuyTips = (_itemDataList.Exists((ActivityPacksChainItemData p) => p.Bought) ? "购买剩余礼包仅需" : "购买所有礼包仅需");
		PropDataBase propDataBase = PropDataBase.CreateByType(_configData.PricePropType, _configData.PricePropId);
		IsCashPrice = _configData.PricePropType == 99;
		PriceIcon = (IsCashPrice ? "" : propDataBase.Icon);
		float num = (IsCashPrice ? _configData.CurPriceRMB : ((float)_configData.CurPriceProp));
		float num2 = (IsCashPrice ? _configData.OriPriceRMB : ((float)_configData.OriPriceProp));
		AllBought = true;
		foreach (ActivityPacksChainItemData itemData in _itemDataList)
		{
			if (!itemData.Bought)
			{
				AllBought = false;
				continue;
			}
			num -= (float)itemData.ActPrice;
			num2 -= (float)itemData.CurPrice;
		}
		_curPrice = num;
		if (!AllBought)
		{
			CurPriceText = $"{num}";
			OriPriceText = $"{num2}";
		}
		else
		{
			CurPriceText = "已全部购买";
			OriPriceText = "";
		}
	}

	private void TryBuy(ActivityPacksChainItemData itemData)
	{
		if (!AllBought)
		{
			if (itemData == null)
			{
				BuyAll();
			}
			else
			{
				Buy(itemData);
			}
		}
	}

	private async void BuyAll()
	{
		_buyCmd.Enabled = false;
		if (!PropHelper.CheckPropEnough(_configData.PricePropId, (int)_curPrice))
		{
			Toast.ShowInfo("道具不足");
			_buyCmd.Enabled = true;
			return;
		}
		Loading loading = await Loading.Show();
		RewardGetData rewardGetData = await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestActivityPacksChainBuyAll(base.ActivityTypeId, _configData.Id);
		loading.Dispose();
		if (rewardGetData != null)
		{
			if (rewardGetData.PropList.Count > 0)
			{
				PropGetViewModel obj = new PropGetViewModel(parent, rewardGetData.PropList);
				parent?.ItemOnClick(obj);
			}
			base.PbTaskDataList.ForEach(delegate(ActivityTaskData p)
			{
				p.CompleteState = 1;
			});
			RefreshItemState();
			RefreshPriceData();
		}
		_buyCmd.Enabled = true;
	}

	private async void Buy(ActivityPacksChainItemData itemData)
	{
		if (itemData == null)
		{
			return;
		}
		_buyCmd.Enabled = false;
		if (itemData.IsCashPrice)
		{
			BuySdk(itemData);
			_buyCmd.Enabled = true;
			return;
		}
		if (!PropHelper.CheckPropEnough(itemData.ConfigData.PricePropId, itemData.CurPrice))
		{
			Toast.ShowInfo("道具不足");
			_buyCmd.Enabled = true;
			return;
		}
		int packChainId = itemData.TaskData.Id;
		Loading loading = await Loading.Show();
		RewardGetData rewardGetData = await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestActivityPacksChainBuy(base.ActivityTypeId, itemData.ConfigData.PackShopId);
		loading.Dispose();
		if (rewardGetData != null)
		{
			if (rewardGetData.PropList.Count > 0)
			{
				PropGetViewModel obj = new PropGetViewModel(parent, rewardGetData.PropList);
				parent?.ItemOnClick(obj);
			}
			ActivityTaskData activityTaskData = base.PbTaskDataList.Find((ActivityTaskData p) => p.Id == packChainId);
			if (activityTaskData != null)
			{
				activityTaskData.CompleteState = 1;
			}
			RefreshItemState();
			RefreshPriceData();
		}
		_buyCmd.Enabled = true;
	}

	private void BuySdk(ActivityPacksChainItemData itemData)
	{
		ShopDefinition.OpenSDKPay(itemData.CurPrice, itemData.ConfigData.PackShopId, "活动礼包链");
	}

	private async void OnUserPayNotify(UserPayNotify notify)
	{
		if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(notify.Error, "礼包购买失败"))
		{
			OpActivityService service = Singleton<ServiceSystem>.Instance.GetService<OpActivityService>();
			ActivitySingleServerData activitySingleServerData = await Singleton<ServiceSystem>.Instance.GetService<OpActivityService>().RequestSingleOpActData(base.ActivityTypeId);
			if (activitySingleServerData != null)
			{
				service.GetActivityVm()?.SetActivityData(base.ActivityTypeId, activitySingleServerData);
			}
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel obj2)
		{
			parent?.ItemOnClick(obj2);
		}
		else if (obj is ActivityPacksChainItemData itemData)
		{
			TryBuy(itemData);
		}
	}

	protected override void Dispose(bool disposing)
	{
		userPayNotify?.Dispose();
		userPayNotify = null;
		base.Dispose(disposing);
	}
}
