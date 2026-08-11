#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ActivityRewardSlider2ViewModel : OptionBase
{
	private int activityTypeId;

	private int progressId;

	private string iconPath;

	private int propId;

	private List<GameActivityRewardItemData> rewardItemList;

	private int point;

	private int pointMax;

	private string gameActivityPointText;

	private float gameOldActivityFill;

	private float gameActivityFill;

	private List<KnapsackItemViewModel> showRewardItemDataList;

	private InteractionRequest playEffectRequest;

	private InteractionRequest<float> openRewardDetailViewRequest;

	private bool isOpenWindow;

	private bool redPoint;

	private GameActivityRewardItemData curSelItem;

	public GameActivityRewardItemData CurSelItem => curSelItem;

	public string GameActivityPointText
	{
		get
		{
			return gameActivityPointText;
		}
		set
		{
			Set(ref gameActivityPointText, value, "GameActivityPointText");
		}
	}

	public string IconPath
	{
		get
		{
			return iconPath;
		}
		set
		{
			Set(ref iconPath, value, "IconPath");
		}
	}

	public int PropId => propId;

	public InteractionRequest PlayEffectRequest => playEffectRequest;

	public InteractionRequest<float> OpenRewardDetailViewRequest => openRewardDetailViewRequest;

	public int ActivityTypeId => activityTypeId;

	public int ProgressId => progressId;

	public float GameOldActivityFill => gameOldActivityFill;

	public float GameActivityFill => gameActivityFill;

	public List<GameActivityRewardItemData> RewardItemList => rewardItemList;

	public List<KnapsackItemViewModel> ShowRewardItemDataList => showRewardItemDataList;

	public ActivityRewardSlider2ViewModel(OptionBase parent)
	{
		base.parent = parent;
		iconPath = "empty";
		playEffectRequest = new InteractionRequest();
		openRewardDetailViewRequest = new InteractionRequest<float>();
		rewardItemList = new List<GameActivityRewardItemData>();
		showRewardItemDataList = new List<KnapsackItemViewModel>();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is GameActivityRewardItemData gameActivityRewardItemData)
			{
				if (optionArg.OptionName.Equals("Receive"))
				{
					SendGetReward(gameActivityRewardItemData);
				}
				else if (optionArg.OptionName.Equals("Open"))
				{
					ShowRewardView(gameActivityRewardItemData);
				}
			}
		}
		else if (obj is OpenViewArg obj2)
		{
			parent?.ItemOnClick(obj2);
		}
	}

	public void RefreshItemState(List<ActivityTaskData> activityTaskDataList)
	{
		gameOldActivityFill = GameActivityFill;
		bool flag = false;
		int num = 0;
		List<GameActivityRewardItemData> list = rewardItemList;
		int index = list.Count - 1;
		pointMax = list[index].ActiveLevel;
		foreach (GameActivityRewardItemData rewardItem in rewardItemList)
		{
			foreach (ActivityTaskData activityTaskData in activityTaskDataList)
			{
				if (rewardItem.IndexId == activityTaskData.Id)
				{
					flag = true;
					num = Mathf.Max(num, (int)activityTaskData.CompleteValue);
					rewardItem.SetState(activityTaskData.RewardState == 1);
					rewardItem.SetState(num);
					break;
				}
			}
		}
		if (!flag)
		{
			point = 0;
			GameActivityPointText = $"{point}/{pointMax}";
			gameActivityFill = 0f;
			{
				foreach (GameActivityRewardItemData rewardItem2 in rewardItemList)
				{
					rewardItem2.SetState(receive: false);
				}
				return;
			}
		}
		point = ((num >= pointMax) ? pointMax : num);
		GameActivityPointText = $"{point}/{pointMax}";
		gameActivityFill = CalcEvenSpacingFill(point);
		playEffectRequest.Raise();
	}

	private float CalcEvenSpacingFill(int curPoint)
	{
		if (rewardItemList == null || rewardItemList.Count == 0)
		{
			return 0f;
		}
		int count = rewardItemList.Count;
		List<GameActivityRewardItemData> list = rewardItemList;
		int index = list.Count - 1;
		int activeLevel = list[index].ActiveLevel;
		if (activeLevel <= 0)
		{
			return 0f;
		}
		int num = Mathf.Clamp(curPoint, 0, activeLevel);
		if (num == 0)
		{
			return 0f;
		}
		for (int i = 0; i < count; i++)
		{
			int activeLevel2 = rewardItemList[i].ActiveLevel;
			if (num <= activeLevel2)
			{
				int num2 = ((i != 0) ? rewardItemList[i - 1].ActiveLevel : 0);
				int num3 = Mathf.Max(1, activeLevel2 - num2);
				float num4 = (float)(num - num2) / (float)num3;
				return ((float)i + num4) / (float)count;
			}
		}
		return 1f;
	}

	public void RefreshData(int activityTypeId)
	{
		rewardItemList.Clear();
		this.activityTypeId = activityTypeId;
		DRActivityRankProgress[] dataRows = GameEntry.DataTable.GetDataTable<DRActivityRankProgress>().GetDataRows((DRActivityRankProgress p) => p.ActivityTypeId == this.activityTypeId);
		if (dataRows.Length == 0)
		{
			return;
		}
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(dataRows[0].UnlockPropId);
		if (dataRow != null)
		{
			IconPath = dataRow.Icon;
			propId = dataRow.Id;
		}
		progressId = dataRows[0].Progress;
		DRActivityRankProgress[] array = dataRows;
		foreach (DRActivityRankProgress dRActivityRankProgress in array)
		{
			GameActivityRewardItemData gameActivityRewardItemData = new GameActivityRewardItemData(this, dRActivityRankProgress.RewardId, dRActivityRankProgress.UnlockNum, dRActivityRankProgress.Id);
			DRActivityTaskReward dataRow2 = GameEntry.DataTable.GetDataRow<DRActivityTaskReward>(dRActivityRankProgress.RewardId);
			if (dataRow2 == null)
			{
				Log.Error($"活动任务奖励ID:{dRActivityRankProgress.RewardId}数据配置错误");
				break;
			}
			if (dataRow2.RewardType.Count != dataRow2.RewardId.Count || dataRow2.RewardType.Count != dataRow2.RewardNum.Count)
			{
				break;
			}
			List<KnapsackItemViewModel> list = new List<KnapsackItemViewModel>();
			for (int num2 = 0; num2 < dataRow2.RewardType.Count; num2++)
			{
				PropDataBase data = PropDataBase.CreateByType(dataRow2.RewardType[num2], dataRow2.RewardId[num2], dataRow2.RewardNum[num2]);
				KnapsackItemViewModel item = new KnapsackItemViewModel(this, data);
				list.Add(item);
			}
			gameActivityRewardItemData.SetRewardList(list);
			rewardItemList.Add(gameActivityRewardItemData);
		}
	}

	private async void SendGetReward(GameActivityRewardItemData data)
	{
		DRActivityRankProgress dataRow = GameEntry.DataTable.GetDataRow((DRActivityRankProgress p) => p.ActivityTypeId == activityTypeId && p.UnlockNum == data.ActiveLevel);
		if (dataRow == null)
		{
			return;
		}
		ActivityReward activityReward = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskRankProgressReward(0, dataRow.Id, ActivityTypeId);
		data.ReSetBtn();
		ActivityViewModelBase activityViewModel = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetActivityViewModel(activityTypeId);
		if (activityViewModel == null)
		{
			return;
		}
		List<ActivityTaskData> activityTaskDataList = activityViewModel.ActivityProgressList.FindAll((ActivityTaskData p) => p.GroupId == ProgressId);
		if (!activityReward.Result)
		{
			if (activityReward.ErrorCode == 200159)
			{
				RefreshItemState(activityTaskDataList);
			}
			else
			{
				parent?.ItemOnClick("RefreshRewardSlider");
			}
		}
		else
		{
			RefreshItemState(activityTaskDataList);
			PropGetViewModel propGetViewModel = new PropGetViewModel(parent, activityReward.Rewards);
			propGetViewModel.MergeProp();
			OpenViewArg obj = new OpenViewArg(typeof(PropGetWindow), propGetViewModel);
			parent?.ItemOnClick(obj);
		}
	}

	private void ShowRewardView(GameActivityRewardItemData rewardItemData)
	{
		showRewardItemDataList.Clear();
		foreach (KnapsackItemViewModel rewardItemData2 in rewardItemData.RewardItemDataList)
		{
			showRewardItemDataList.Add(rewardItemData2);
		}
		curSelItem = rewardItemData;
		openRewardDetailViewRequest.Raise(rewardItemData.Position);
		rewardItemData.ReSetBtn();
	}
}
