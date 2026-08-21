using System;
using System.Collections.Generic;

namespace Ase;

public class LongTermCheckinViewModel : ActivityViewModelBase
{
	private int _alreadyCheckinDay;

	private float _extraProgress;

	private int _totalDay;

	private List<LongTermCheckinItemData> _itemDataList = new List<LongTermCheckinItemData>();

	private List<LongTermCheckinItemData> _extraItemDataList = new List<LongTermCheckinItemData>();

	public int AlreadyCheckinDay
	{
		get
		{
			return _alreadyCheckinDay;
		}
		set
		{
			Set(ref _alreadyCheckinDay, value, "AlreadyCheckinDay");
		}
	}

	public float ExtraProgress
	{
		get
		{
			return _extraProgress;
		}
		set
		{
			Set(ref _extraProgress, value, "ExtraProgress");
		}
	}

	public int TotalDay => _totalDay;

	public List<LongTermCheckinItemData> ItemDataList => _itemDataList;

	public List<LongTermCheckinItemData> ExtraItemDataList => _extraItemDataList;

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is LongTermCheckinItemData longTermCheckinItemData)
		{
			if (longTermCheckinItemData.Highlight)
			{
				RequestCheckin(longTermCheckinItemData.Id);
			}
			else
			{
				OpenPropInfo(longTermCheckinItemData.PropDataBase);
			}
		}
	}

	private async void RequestCheckin(int id)
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

	public override void SetServiceTaskData(List<ActivityTaskData> taskDataList)
	{
		base.SetServiceTaskData(taskDataList);
		_itemDataList.Clear();
		_extraItemDataList.Clear();
		if (taskDataList == null)
		{
			return;
		}
		int num = -1;
		foreach (ActivityTaskData taskData in taskDataList)
		{
			DRActivitySign dataRow = GameEntry.DataTable.GetDataRow<DRActivitySign>(taskData.Id);
			if (dataRow != null)
			{
				if (dataRow.ShowType == 1)
				{
					num = Math.Max(num, taskData.TargetValue);
					_itemDataList.Add(new LongTermCheckinItemData(this, dataRow, taskData));
				}
				else if (dataRow.ShowType == 2)
				{
					_extraItemDataList.Add(new LongTermCheckinItemData(this, dataRow, taskData));
				}
			}
		}
		_totalDay = num;
		RefreshProgress();
		_itemDataList.Sort((LongTermCheckinItemData a, LongTermCheckinItemData b) => (a.Day >= b.Day) ? 1 : (-1));
		_extraItemDataList.Sort((LongTermCheckinItemData a, LongTermCheckinItemData b) => (a.Day >= b.Day) ? 1 : (-1));
	}

	private void RefreshProgress()
	{
		if (base.PbTaskDataList == null)
		{
			AlreadyCheckinDay = 0;
			ExtraProgress = 0f;
			return;
		}
		int num = 0;
		foreach (ActivityTaskData pbTaskData in base.PbTaskDataList)
		{
			DRActivitySign dataRow = GameEntry.DataTable.GetDataRow<DRActivitySign>(pbTaskData.Id);
			if (dataRow != null && dataRow.ShowType == 1 && pbTaskData.CompleteState == 1)
			{
				num++;
			}
		}
		AlreadyCheckinDay = num;
		ExtraProgress = ((_totalDay <= 0) ? 1f : Math.Min((float)AlreadyCheckinDay / (float)_totalDay, 1f));
	}

	public override ActivityTaskData OnTaskRateNotify(ActivityTaskRateNotify rateNotify)
	{
		ActivityTaskData activityTaskData = base.OnTaskRateNotify(rateNotify);
		(_itemDataList?.Find((LongTermCheckinItemData p) => p.Id == rateNotify.Id))?.RefreshTaskData(activityTaskData);
		(_extraItemDataList?.Find((LongTermCheckinItemData p) => p.Id == rateNotify.Id))?.RefreshTaskData(activityTaskData);
		RefreshProgress();
		return activityTaskData;
	}

	public override bool OnTaskRewardGot(int id)
	{
		bool result = base.OnTaskRewardGot(id);
		if (_itemDataList != null)
		{
			_itemDataList.Find((LongTermCheckinItemData p) => p.Id == id)?.OnRewardGot();
		}
		if (_extraItemDataList != null)
		{
			LongTermCheckinItemData longTermCheckinItemData = _extraItemDataList.Find((LongTermCheckinItemData p) => p.Id == id);
			if (longTermCheckinItemData == null)
			{
				return result;
			}
			longTermCheckinItemData.OnRewardGot();
		}
		return result;
	}

	public override bool UpdateRed(bool notifyParent = true)
	{
		base.Red = base.PbTaskDataList != null && base.PbTaskDataList.Exists((ActivityTaskData p) => p.CompleteState == 1 && p.RewardState == 0);
		return base.UpdateRed(notifyParent);
	}
}
