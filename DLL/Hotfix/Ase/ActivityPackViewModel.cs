using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ActivityPackViewModel : ActivityViewModelBase
{
	private DRActivityPacks _drActivityPacks;

	private string _packName;

	private string _packDesc;

	private ShopExcData _shopExcData;

	private float _packNowPrice;

	private string _nowPriceText;

	private string _oriPriceText;

	private bool _packBought;

	private List<ActivityPackItemData> _itemDataList = new List<ActivityPackItemData>();

	private SimpleCommand _buyPackCmd;

	private ISubscription<UserPayNotify> userPayNotify;

	public string PackName
	{
		get
		{
			return _packName;
		}
		private set
		{
			Set(ref _packName, value, "PackName");
		}
	}

	public string PackDesc
	{
		get
		{
			return _packDesc;
		}
		private set
		{
			Set(ref _packDesc, value, "PackDesc");
		}
	}

	public string NowPriceText
	{
		get
		{
			return _nowPriceText;
		}
		private set
		{
			Set(ref _nowPriceText, value, "NowPriceText");
		}
	}

	public string OriPriceText
	{
		get
		{
			return _oriPriceText;
		}
		private set
		{
			Set(ref _oriPriceText, value, "OriPriceText");
		}
	}

	public bool PackBought
	{
		get
		{
			return _packBought;
		}
		private set
		{
			Set(ref _packBought, value, "PackBought");
		}
	}

	public List<ActivityPackItemData> ItemDataList => _itemDataList;

	public SimpleCommand BuyPackCmd => _buyPackCmd;

	public ActivityPackViewModel()
	{
		_buyPackCmd = new SimpleCommand(BuyPack);
		userPayNotify = Singleton<NetworkSystem>.Instance.Subscribe<UserPayNotify>(OnUserPayNotify);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ActivityPackItemData activityPackItemData)
		{
			if (activityPackItemData.DrData != null)
			{
				RequestGetReward(activityPackItemData.DrData.Id);
			}
		}
		else if (obj is PropDataBase propDataBase)
		{
			OpenPropInfo(propDataBase);
		}
	}

	public override void Init(OpActViewModel opActViewModel, DRActivityType drData)
	{
		base.Init(opActViewModel, drData);
		_drActivityPacks = GameEntry.DataTable.GetDataRow((DRActivityPacks p) => p.ActivityId == base.ActivityTypeId);
		if (_drActivityPacks != null)
		{
			PackName = _drActivityPacks.Name;
			PackDesc = _drActivityPacks.Desc;
			_packNowPrice = _drActivityPacks.CurPrice;
			NowPriceText = _drActivityPacks.CurPriceText;
			OriPriceText = _drActivityPacks.OriPriceText;
		}
	}

	public override void SetServiceTaskData(List<ActivityTaskData> taskDataList)
	{
		base.SetServiceTaskData(taskDataList);
		if (taskDataList == null || _drActivityPacks == null)
		{
			return;
		}
		ActivityTaskData activityTaskData = taskDataList.Find((ActivityTaskData p) => p.Id == _drActivityPacks.UnlockTaskId);
		if (activityTaskData == null)
		{
			return;
		}
		PackBought = activityTaskData.CompleteState == 1;
		foreach (ActivityTaskData taskData in taskDataList)
		{
			DRActivityPacksInclude drData = GameEntry.DataTable.GetDataRow<DRActivityPacksInclude>(taskData.Id);
			if (drData != null)
			{
				ActivityPackItemData activityPackItemData = _itemDataList.Find((ActivityPackItemData p) => p.DrData?.Id == drData.Id);
				if (activityPackItemData == null)
				{
					_itemDataList.Add(new ActivityPackItemData(this, drData, taskData));
				}
				else
				{
					activityPackItemData.RefreshTaskData(taskData);
				}
			}
		}
		_itemDataList.RemoveAll((ActivityPackItemData p) => p.DrData == null || !taskDataList.Exists(delegate(ActivityTaskData task)
		{
			DRActivityPacksInclude dataRow = GameEntry.DataTable.GetDataRow<DRActivityPacksInclude>(task.Id);
			return p.DrData.Id == dataRow?.Id;
		}));
	}

	public override ActivityTaskData OnTaskRateNotify(ActivityTaskRateNotify rateNotify)
	{
		ActivityTaskData activityTaskData = base.OnTaskRateNotify(rateNotify);
		if (_drActivityPacks == null)
		{
			return activityTaskData;
		}
		if (activityTaskData.Id == _drActivityPacks.UnlockTaskId)
		{
			PackBought = activityTaskData.CompleteState == 1;
		}
		(_itemDataList?.Find((ActivityPackItemData p) => p.DrData?.Id == rateNotify.Id))?.RefreshTaskData(activityTaskData);
		return activityTaskData;
	}

	private void BuyPack()
	{
		if (_drActivityPacks != null)
		{
			ShopDefinition.OpenSDKPay((int)_packNowPrice, _drActivityPacks.PackShopId, PackName);
		}
	}

	private void OnUserPayNotify(UserPayNotify notify)
	{
	}

	private async void RequestGetReward(int id)
	{
		Loading loading = await Loading.Show();
		ActivityReward activityReward = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskReward(base.ActivityTypeId, id);
		loading?.Dispose();
		if (activityReward.Result && !activityReward.RewardEmpty())
		{
			PropGetViewModel obj = new PropGetViewModel(parent, activityReward.Rewards);
			parent.ItemOnClick(obj);
		}
	}

	private void OpenPropInfo(PropDataBase propDataBase)
	{
		if (propDataBase != null && !propDataBase.Empty)
		{
			parent?.ItemOnClick(PropHelper.OpenPopupWindow(propDataBase, parent, null, showOutsideMask: true, showOwnCount: false));
		}
	}

	public override bool OnTaskRewardGot(int id)
	{
		bool result = base.OnTaskRewardGot(id);
		if (_itemDataList != null)
		{
			ActivityPackItemData activityPackItemData = _itemDataList.Find(delegate(ActivityPackItemData p)
			{
				DRActivityPacksInclude drData = p.DrData;
				return drData != null && drData.Id == id;
			});
			if (activityPackItemData == null)
			{
				return result;
			}
			activityPackItemData.OnRewardGot();
		}
		return result;
	}

	public override bool UpdateRed(bool notifyParent = true)
	{
		base.Red = base.PbTaskDataList != null && base.PbTaskDataList.Exists((ActivityTaskData p) => p.CompleteState == 1 && p.RewardState == 0);
		return base.UpdateRed(notifyParent);
	}
}
