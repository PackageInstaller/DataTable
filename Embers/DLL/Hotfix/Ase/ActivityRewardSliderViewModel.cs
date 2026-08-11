using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ActivityRewardSliderViewModel : OptionBase
{
	private int activityId;

	private int rankId;

	private int groupId;

	private List<KnapsackItemViewModel> rewardItemList;

	private int maxPoint;

	private int curPoint;

	private string pointText;

	private float pointFill;

	private int state;

	private bool red;

	private InteractionRequest refreshItemRequest;

	public int ActivityId => activityId;

	public int GroupId => groupId;

	public string PointText
	{
		get
		{
			return pointText;
		}
		set
		{
			Set(ref pointText, value, "PointText");
		}
	}

	public float PointFill
	{
		get
		{
			return pointFill;
		}
		set
		{
			Set(ref pointFill, value, "PointFill");
		}
	}

	public List<KnapsackItemViewModel> RewardItemList => rewardItemList;

	public InteractionRequest RefreshItemRequest => refreshItemRequest;

	public bool Red => red;

	public ActivityRewardSliderViewModel(OptionBase parent)
	{
		base.parent = parent;
		rewardItemList = new List<KnapsackItemViewModel>();
		refreshItemRequest = new InteractionRequest();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			SendGetReward(knapsackItemViewModel);
		}
	}

	private async void SendGetReward(KnapsackItemViewModel knapsackItemViewModel)
	{
		if (!knapsackItemViewModel.IsActive || curPoint < knapsackItemViewModel.ExValue)
		{
			parent?.ItemOnClick(knapsackItemViewModel);
			return;
		}
		DRActivityRankProgress dataRow = GameEntry.DataTable.GetDataRow((DRActivityRankProgress p) => p.ActivityTypeId == ActivityId && p.UnlockNum == knapsackItemViewModel.ExValue);
		if (dataRow == null)
		{
			return;
		}
		ActivityReward activityReward = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskRankProgressReward(0, dataRow.Id, activityId);
		if (!activityReward.Result)
		{
			if (activityReward.ErrorCode == 200159)
			{
				knapsackItemViewModel.IsActive = false;
				knapsackItemViewModel.New = false;
				CheckRedPoint();
			}
			else
			{
				parent?.ItemOnClick("RefreshRewardSlider");
			}
		}
		else
		{
			knapsackItemViewModel.IsActive = false;
			knapsackItemViewModel.New = false;
			CheckRedPoint();
			PropGetViewModel userData = new PropGetViewModel(parent, activityReward.Rewards);
			OpenViewArg obj = new OpenViewArg(typeof(PropGetWindow), userData);
			parent?.ItemOnClick(obj);
			parent?.ItemOnClick("RefreshRewardSlider");
		}
	}

	public void RefreshData(int activityId, int rankId)
	{
		rewardItemList.Clear();
		this.activityId = activityId;
		this.rankId = rankId;
		DRActivityRankProgress[] dataRows = GameEntry.DataTable.GetDataTable<DRActivityRankProgress>().GetDataRows((DRActivityRankProgress p) => p.ActivityTypeId == this.activityId);
		foreach (DRActivityRankProgress dRActivityRankProgress in dataRows)
		{
			if (dRActivityRankProgress.ShowType != 0 || dRActivityRankProgress.UnlockRange.FindAll((int p) => p.Equals(groupId)).Count != 0)
			{
				DRActivityTaskReward dataRow = GameEntry.DataTable.GetDataRow<DRActivityTaskReward>(dRActivityRankProgress.RewardId);
				if (dataRow != null)
				{
					PropDataBase data = PropDataBase.CreateByType(dataRow.RewardType[0], dataRow.RewardId[0], dataRow.RewardNum[0]);
					KnapsackItemViewModel knapsackItemViewModel = new KnapsackItemViewModel(this, data);
					knapsackItemViewModel.ExValue = dRActivityRankProgress.UnlockNum;
					knapsackItemViewModel.ExValueText = $"{dRActivityRankProgress.UnlockNum}";
					rewardItemList.Add(knapsackItemViewModel);
					groupId = dRActivityRankProgress.Progress;
				}
			}
		}
		if (rewardItemList.Count > 0)
		{
			base.IsVisible = true;
			List<KnapsackItemViewModel> list = rewardItemList;
			int num = list.Count - 1;
			maxPoint = list[num].ExValue;
		}
		else
		{
			base.IsVisible = false;
		}
		refreshItemRequest.Raise();
	}

	public void RefreshItemState(List<ActivityTaskData> activityTaskDataList)
	{
		if (activityTaskDataList.Count == 0)
		{
			foreach (KnapsackItemViewModel rewardItem in rewardItemList)
			{
				rewardItem.New = false;
			}
			curPoint = 0;
			PointText = $"{curPoint}/{maxPoint}";
			PointFill = 0f;
		}
		else
		{
			int num = (int)activityTaskDataList[0].CompleteValue;
			curPoint = ((num >= maxPoint) ? maxPoint : num);
			PointText = $"{curPoint}/{maxPoint}";
			float num2 = num;
			List<KnapsackItemViewModel> list = rewardItemList;
			int index = list.Count - 1;
			PointFill = num2 / (float)list[index].ExValue;
			CheckRedPoint(activityTaskDataList);
		}
	}

	private void CheckRedPoint(List<ActivityTaskData> activityTaskDataList)
	{
		foreach (KnapsackItemViewModel rewardItem in rewardItemList)
		{
			foreach (ActivityTaskData activityTaskData in activityTaskDataList)
			{
				if (GameEntry.DataTable.GetDataRow((DRActivityRankProgress p) => p.UnlockNum == rewardItem.ExValue && p.ActivityTypeId == ActivityId).Id == activityTaskData.Id)
				{
					rewardItem.New = activityTaskData.CompleteValue >= rewardItem.ExValue;
					if (activityTaskData.RewardState == 1)
					{
						rewardItem.New = false;
						rewardItem.IsActive = false;
					}
				}
			}
		}
		CheckRedPoint();
	}

	private void CheckRedPoint()
	{
		red = false;
		foreach (KnapsackItemViewModel rewardItem in rewardItemList)
		{
			if (rewardItem.New)
			{
				red = true;
				return;
			}
		}
		parent?.ItemOnClick("RedPoint");
	}
}
