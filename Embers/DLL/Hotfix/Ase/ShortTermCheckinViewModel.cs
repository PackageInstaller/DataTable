using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class ShortTermCheckinViewModel : ActivityViewModelBase
{
	private int _checkinDay;

	private int realReceiveDay;

	private List<ShortTermCheckinItemData> _itemDataList = new List<ShortTermCheckinItemData>();

	private float progress;

	private string progressText;

	private OpActProgressTarget progressTarget;

	private SimpleCommand<JumpWindowParams> openWindowCmd;

	public SimpleCommand<JumpWindowParams> OpenWindowCmd => openWindowCmd;

	public List<ShortTermCheckinItemData> ItemDataList => _itemDataList;

	public float Progress
	{
		get
		{
			return progress;
		}
		set
		{
			Set(ref progress, value, "Progress");
		}
	}

	public string ProgressText
	{
		get
		{
			return progressText;
		}
		set
		{
			Set(ref progressText, value, "ProgressText");
		}
	}

	public ShortTermCheckinViewModel()
	{
		openWindowCmd = new SimpleCommand<JumpWindowParams>(OpenWindow);
	}

	public async void InitProgressTarget(OpActProgressTarget target)
	{
		progressTarget = target;
		await RefreshProgressData();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ShortTermCheckinItemData shortTermCheckinItemData)
		{
			if (shortTermCheckinItemData.Highlight)
			{
				RequestCheckin(shortTermCheckinItemData.Id);
			}
			else
			{
				OpenPropInfo(shortTermCheckinItemData.PropDataBase);
			}
		}
	}

	private void OpenGameScoreWindow()
	{
		if (_itemDataList.Count <= 3 && _checkinDay >= 3 && realReceiveDay >= 3 && !GameEntry.BuiltinData.OpenTestFlight && Singleton<ServiceSystem>.Instance.GetService<IGameNewsTipService>().CheckOpenScoreWindow(2))
		{
			parent.ItemOnClick(this);
		}
	}

	private async void RequestCheckin(int id)
	{
		Loading loading = await Loading.Show();
		ActivityReward activityReward = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskReward(base.ActivityTypeId, id);
		loading?.Dispose();
		if (activityReward.Result && !activityReward.RewardEmpty())
		{
			PropGetViewModel propGetViewModel = new PropGetViewModel(parent, activityReward.Rewards);
			parent.ItemOnClick(propGetViewModel);
			realReceiveDay++;
			await propGetViewModel.WaitForClose();
			OpenGameScoreWindow();
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
		if (taskDataList == null)
		{
			return;
		}
		foreach (ActivityTaskData taskData in taskDataList)
		{
			DRActivitySign drActivitySign = GameEntry.DataTable.GetDataRow<DRActivitySign>(taskData.Id);
			if (drActivitySign != null && drActivitySign.ShowType == 1)
			{
				ShortTermCheckinItemData shortTermCheckinItemData = _itemDataList.Find((ShortTermCheckinItemData p) => p.Id == drActivitySign.Id);
				if (shortTermCheckinItemData == null)
				{
					_itemDataList.Add(new ShortTermCheckinItemData(this, drActivitySign, taskData));
				}
				else
				{
					shortTermCheckinItemData.RefreshTaskData(taskData);
				}
			}
		}
		_itemDataList.RemoveAll((ShortTermCheckinItemData p) => !taskDataList.Exists(delegate(ActivityTaskData r)
		{
			DRActivitySign dataRow = GameEntry.DataTable.GetDataRow<DRActivitySign>(r.Id);
			return p.Id == dataRow?.Id;
		}));
		_itemDataList.Sort((ShortTermCheckinItemData a, ShortTermCheckinItemData b) => (a.Day >= b.Day) ? 1 : (-1));
		RefreshTomorrowTag();
	}

	public void SortItemDataList()
	{
		_itemDataList.Sort((ShortTermCheckinItemData a, ShortTermCheckinItemData b) => (a.Day >= b.Day) ? 1 : (-1));
	}

	public override ActivityTaskData OnTaskRateNotify(ActivityTaskRateNotify rateNotify)
	{
		ActivityTaskData activityTaskData = base.OnTaskRateNotify(rateNotify);
		(_itemDataList?.Find((ShortTermCheckinItemData p) => p.Id == rateNotify.Id))?.RefreshTaskData(activityTaskData);
		RefreshTomorrowTag();
		return activityTaskData;
	}

	public override bool OnTaskRewardGot(int id)
	{
		bool result = base.OnTaskRewardGot(id);
		if (_itemDataList != null)
		{
			ShortTermCheckinItemData shortTermCheckinItemData = _itemDataList.Find((ShortTermCheckinItemData p) => p.Id == id);
			if (shortTermCheckinItemData == null)
			{
				return result;
			}
			shortTermCheckinItemData.OnRewardGot();
		}
		return result;
	}

	public override bool UpdateRed(bool notifyParent = true)
	{
		base.Red = base.PbTaskDataList != null && base.PbTaskDataList.Exists((ActivityTaskData p) => p.CompleteState == 1 && p.RewardState == 0);
		return base.UpdateRed(notifyParent);
	}

	private async Task RefreshProgressData()
	{
		if (progressTarget != OpActProgressTarget.None)
		{
			if (progressTarget == OpActProgressTarget.MapExplore)
			{
				(List<PbIdValue>, int) tuple = await Singleton<ServiceSystem>.Instance.GetService<IMapService>().GetCollectionsForStory(base.AdditionalParameter1);
				Progress = (float)tuple.Item2 / 100f;
				ProgressText = $"{tuple.Item2}%";
			}
			else if (progressTarget == OpActProgressTarget.CopyType4ZoneStar)
			{
				int copyType4StarByZone = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyType4StarByZone(base.AdditionalParameter1);
				ProgressText = $"{copyType4StarByZone}";
			}
			else if (progressTarget == OpActProgressTarget.TotalRecharge && base.PbTaskDataList != null && base.PbTaskDataList.Count > 0)
			{
				ProgressText = $"{base.PbTaskDataList[0].CompleteValue}";
			}
		}
	}

	private void RefreshTomorrowTag()
	{
		_checkinDay = 0;
		if (_itemDataList == null)
		{
			return;
		}
		foreach (ActivityTaskData pbTaskData in base.PbTaskDataList)
		{
			DRActivitySign dataRow = GameEntry.DataTable.GetDataRow<DRActivitySign>(pbTaskData.Id);
			if (dataRow != null && dataRow.ShowType == 1 && pbTaskData.CompleteState == 1)
			{
				_checkinDay++;
			}
		}
		foreach (ShortTermCheckinItemData itemData in _itemDataList)
		{
			itemData.SetTomorrowTag(itemData.Day == _checkinDay + 1);
		}
	}

	private async void OpenWindow(JumpWindowParams param)
	{
		if (!string.IsNullOrEmpty(param.WindowName))
		{
			OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(param, parent, "ShortTermCheckin", delegate
			{
				openWindowCmd.Enabled = true;
			});
			if (openViewArg != null)
			{
				openWindowCmd.Enabled = false;
				parent?.ItemOnClick(openViewArg);
			}
		}
	}
}
