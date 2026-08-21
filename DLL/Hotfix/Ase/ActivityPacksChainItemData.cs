namespace Ase;

public class ActivityPacksChainItemData : OptionBase
{
	private ActivityTaskData _taskData;

	private DRPacksChainInclude _configData;

	private int _packsIndex;

	private KnapsackItemViewModel _rewardItemData;

	private string _priceIcon = "";

	private bool _isCashPrice;

	private string _priceText;

	private int _curPrice;

	private int _actPrice;

	private int _sort;

	private bool _unlock;

	private bool _bought;

	public ActivityTaskData TaskData => _taskData;

	public DRPacksChainInclude ConfigData => _configData;

	public bool Unlock
	{
		get
		{
			return _unlock;
		}
		set
		{
			Set(ref _unlock, value, "Unlock");
		}
	}

	public bool Bought
	{
		get
		{
			return _bought;
		}
		set
		{
			Set(ref _bought, value, "Bought");
		}
	}

	public int PacksIndex
	{
		get
		{
			return _packsIndex;
		}
		set
		{
			Set(ref _packsIndex, value, "PacksIndex");
		}
	}

	public KnapsackItemViewModel RewardItemData => _rewardItemData;

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

	public string PriceText
	{
		get
		{
			return _priceText;
		}
		set
		{
			Set(ref _priceText, value, "PriceText");
		}
	}

	public int CurPrice
	{
		get
		{
			return _curPrice;
		}
		set
		{
			Set(ref _curPrice, value, "CurPrice");
		}
	}

	public int ActPrice
	{
		get
		{
			return _actPrice;
		}
		set
		{
			Set(ref _actPrice, value, "ActPrice");
		}
	}

	public int Sort
	{
		get
		{
			return _sort;
		}
		set
		{
			Set(ref _sort, value, "Sort");
		}
	}

	public ActivityPacksChainItemData()
	{
	}

	public ActivityPacksChainItemData(OptionBase parent, ActivityTaskData taskData)
	{
		base.parent = parent;
		_rewardItemData = new KnapsackItemViewModel(this);
		RefreshData(taskData);
	}

	private void RefreshData(ActivityTaskData taskData)
	{
		if (taskData == null)
		{
			return;
		}
		DRPacksChainInclude dataRow = GameEntry.DataTable.GetDataRow<DRPacksChainInclude>(taskData.Id);
		if (dataRow == null)
		{
			return;
		}
		_taskData = taskData;
		_configData = dataRow;
		PacksIndex = dataRow.Order;
		DRActivityTaskReward dataRow2 = GameEntry.DataTable.GetDataRow<DRActivityTaskReward>(dataRow.RewardId);
		if (dataRow2 != null)
		{
			int type = ((dataRow2.RewardType.Count > 0) ? dataRow2.RewardType[0] : 0);
			int propId = ((dataRow2.RewardId.Count > 0) ? dataRow2.RewardId[0] : 0);
			int count = ((dataRow2.RewardNum.Count > 0) ? dataRow2.RewardNum[0] : 0);
			PropDataBase propDataBase = PropDataBase.CreateByType(type, propId, count);
			if (propDataBase != null && !propDataBase.Empty)
			{
				_rewardItemData.Refresh(propDataBase);
			}
		}
		IsCashPrice = dataRow.PricePropType == 99;
		CurPrice = (IsCashPrice ? ((int)dataRow.CurPriceRMB) : dataRow.CurPriceProp);
		ActPrice = (IsCashPrice ? ((int)dataRow.ActPriceRMB) : dataRow.ActPriceProp);
		PriceText = ((CurPrice > 0) ? $"{CurPrice}" : "免费");
		PropDataBase propDataBase2 = PropDataBase.CreateByType(dataRow.PricePropType, dataRow.PricePropId);
		PriceIcon = ((CurPrice <= 0) ? "" : (propDataBase2?.Icon ?? ""));
	}

	public void OnBuyBtnClick()
	{
		if (Bought)
		{
			Toast.ShowInfo("礼包已购买");
		}
		else if (!Unlock)
		{
			Toast.ShowInfo("礼包未解锁");
		}
		else
		{
			parent?.ItemOnClick(this);
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel obj2)
		{
			parent?.ItemOnClick(obj2);
		}
	}
}
