#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class TowerActivityAreaViewModel : OptionBase
{
	private const int RankType = 11;

	private int multiRankTypeId;

	private int score;

	private SimpleCommand<string> optCmd;

	private PhasedActivity6ViewModel activity6ViewModel;

	private List<ActivityTaskData> towerTaskDatas;

	private bool rewardRedPoint;

	private string rewardNum;

	private int maxActivityRank;

	private int activityTypeId;

	public List<ActivityTabItemData2> ActivityTabItemData2 => activity6ViewModel.PhasedItemList;

	public SimpleCommand<string> OptCmd
	{
		get
		{
			return optCmd;
		}
		set
		{
			optCmd = value;
		}
	}

	public List<ActivityTaskData> TowerTaskDatas
	{
		get
		{
			return towerTaskDatas;
		}
		set
		{
			towerTaskDatas = value;
		}
	}

	public bool RewardRedPoint
	{
		get
		{
			return rewardRedPoint;
		}
		set
		{
			Set(ref rewardRedPoint, value, "RewardRedPoint");
		}
	}

	public string RewardNum
	{
		get
		{
			return rewardNum;
		}
		set
		{
			Set(ref rewardNum, value, "RewardNum");
		}
	}

	public int MaxActivityRank
	{
		get
		{
			return maxActivityRank;
		}
		set
		{
			maxActivityRank = value;
		}
	}

	public int Score
	{
		get
		{
			return score;
		}
		set
		{
			Set(ref score, value, "Score");
		}
	}

	public TowerActivityAreaViewModel(PhasedActivity6ViewModel phasedActivity6ViewModel, CopyData lastPlatCoptData)
	{
		activity6ViewModel = phasedActivity6ViewModel;
		GetCurrentTowerRankTypeId();
		RefreshTowerTopRankScoreAsync();
		for (int i = 0; i < activity6ViewModel.PhasedItemList.Count; i++)
		{
			activity6ViewModel.PhasedItemList[i].SetParent(this);
		}
		TowerTaskDatas = new List<ActivityTaskData>();
		InitMaxActivityRank();
		InitTowerDatas();
		SetRewardText();
		optCmd = new SimpleCommand<string>(OnOpt);
		parent = activity6ViewModel;
		SetRewardRedPointImg();
	}

	private void InitMaxActivityRank()
	{
		for (int i = 0; i < activity6ViewModel.PhasedItemList.Count; i++)
		{
			int activityRankId = activity6ViewModel.PhasedItemList[i].TagId;
			DRActivityRankTask[] dataRows = GameEntry.DataTable.GetDataRows((DRActivityRankTask x) => x.ActivityRankId == activityRankId);
			if (dataRows != null && dataRows.Length != 0)
			{
				activityTypeId = dataRows[0].ActivityTypeId;
				break;
			}
		}
		MaxActivityRank = int.MinValue;
		for (int num = 0; num < activity6ViewModel.PhasedItemList.Count; num++)
		{
			int tagId = activity6ViewModel.PhasedItemList[num].TagId;
			if (tagId >= MaxActivityRank)
			{
				MaxActivityRank = tagId;
			}
		}
	}

	private void SetRewardText()
	{
		int num = 0;
		for (int i = 0; i < towerTaskDatas.Count; i++)
		{
			if (towerTaskDatas[i].CompleteState == 1)
			{
				num++;
			}
		}
		RewardNum = $"<color=#ffc962>{num}</color>/{towerTaskDatas.Count}";
	}

	public void SetRewardRedPointImg()
	{
		RewardRedPoint = SetRewardRedPoint();
	}

	private bool SetRewardRedPoint()
	{
		InitTowerDatas();
		for (int i = 0; i < towerTaskDatas.Count; i++)
		{
			if (towerTaskDatas[i].CompleteState == 1 && towerTaskDatas[i].RewardState == 0)
			{
				RewardRedPoint = true;
				break;
			}
			RewardRedPoint = false;
		}
		return RewardRedPoint;
	}

	public void InitTowerDatas()
	{
		towerTaskDatas.Clear();
		string value = maxActivityRank.ToString();
		for (int i = 0; i < activity6ViewModel.PbTaskDataList.Count; i++)
		{
			if (activity6ViewModel.PbTaskDataList[i].Id != maxActivityRank && activity6ViewModel.PbTaskDataList[i].Id.ToString().StartsWith(value))
			{
				TowerTaskDatas.Add(activity6ViewModel.PbTaskDataList[i]);
			}
		}
	}

	public async UniTask OpenTowerCopy(CopyData lastPlatCoptData)
	{
		if (lastPlatCoptData == null)
		{
			return;
		}
		for (int i = 0; i < activity6ViewModel.PhasedItemList.Count; i++)
		{
			int activityRankId = activity6ViewModel.PhasedItemList[i].TagId;
			DRActivityRankTask[] dataRows = GameEntry.DataTable.GetDataRows((DRActivityRankTask x) => x.ActivityRankId == activityRankId);
			activityTypeId = dataRows[0].ActivityTypeId;
			for (int num = 0; num < dataRows.Length; num++)
			{
				int activityTaskId = dataRows[num].ActivityTaskId;
				if (GameEntry.DataTable.GetDataRow<DRActivityTask>(activityTaskId).RequireValue[0] == lastPlatCoptData.Id)
				{
					await EnterTowerCopy(activityRankId, lastPlatCoptData.Id);
					return;
				}
			}
		}
	}

	private void OnOpt(string optName)
	{
		if ("OpenRewardWindow".Equals(optName))
		{
			TowerRewardViewModel userData = new TowerRewardViewModel(this, maxActivityRank, TowerTaskDatas, activityTypeId);
			openWindowRequest.Raise(new OpenViewArg(typeof(TowerRewardWindow), userData), delegate
			{
				optCmd.Enabled = true;
			});
		}
		else if ("OpenGameExplain".Equals(optName))
		{
			DRGameExplain dataRow = GameEntry.DataTable.GetDataRow<DRGameExplain>(7001);
			if (dataRow != null)
			{
				string title = dataRow.Title;
				string content = dataRow.Content;
				GamePlayTipsViewModel userData2 = new GamePlayTipsViewModel(this, title, content);
				openWindowRequest.Raise(new OpenViewArg(typeof(GamePlayTipsWindow), userData2));
			}
		}
		else if ("OpenRankWindow".Equals(optName))
		{
			RankViewModel userData3 = new RankViewModel(this, multiRankTypeId);
			openWindowRequest.Raise(new OpenViewArg(typeof(RankWindow), userData3), delegate
			{
				optCmd.Enabled = true;
			});
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is ActivityTabItemData2 { StateEnum: not ActivityTabStateEnum.Lock } activityTabItemData)
			{
				EnterTowerCopy(activityTabItemData.TagId, 0);
			}
		}
		else if (obj is ReceiveItemViewModel receiveItemViewModel)
		{
			OpenViewArg openViewArg = receiveItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is TowerEnterCopyViewModel)
		{
			parent?.ItemOnClick(obj);
		}
		else if (obj is ViewBackArg viewBackArg)
		{
			if (viewBackArg.Obj is TowerEnterCopyViewModel)
			{
				InitMaxActivityRank();
				InitTowerDatas();
				SetRewardText();
				SetRewardRedPointImg();
			}
			RefreshTowerTopRankScoreAsync();
		}
		else
		{
			parent?.ItemOnClick(obj);
		}
	}

	private async UniTask EnterTowerCopy(int tagId, int lastPlayCopyId)
	{
		activity6ViewModel.GetActivityTaskItemByRankId(tagId);
		List<ActivityTaskItemData> showActivityTaskItemDataList = activity6ViewModel.ShowActivityTaskItemDataList;
		List<TowerCopyItemViewModel> list = new List<TowerCopyItemViewModel>(5);
		for (int i = 0; i < showActivityTaskItemDataList.Count; i++)
		{
			int taskId = showActivityTaskItemDataList[i].TaskId;
			DRActivityTask dataRow = GameEntry.DataTable.GetDataRow<DRActivityTask>(taskId);
			if (dataRow != null)
			{
				int copyId = dataRow.RequireValue[0];
				CopyData copyById = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(copyId);
				TowerCopyItemViewModel item = new TowerCopyItemViewModel(showActivityTaskItemDataList[i].TaskState == ActivityTaskStateEnum.Finished || showActivityTaskItemDataList[i].TaskState == ActivityTaskStateEnum.Accept, copyById, !copyById.IsLock);
				list.Add(item);
			}
		}
		int index = 0;
		for (int j = 0; j < ActivityTabItemData2.Count; j++)
		{
			if (ActivityTabItemData2[j].TagId == tagId)
			{
				index = j;
				break;
			}
		}
		TowerEnterCopyViewModel userData = new TowerEnterCopyViewModel(this, list, index, TowerTaskDatas, lastPlayCopyId, activityTypeId);
		(await GameEntry.UI.LoadWindow<TowerEnterCopyWindow>("OperatingActivity/TownChallenge/TowerEnterCopyWindow", userData)).Show();
		if (Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetTowerOneAreaRedPoint(tagId) != 0)
		{
			return;
		}
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SetTowerActivityRedPoint(tagId, 1);
		for (int k = 0; k < activity6ViewModel.PhasedItemList.Count; k++)
		{
			if (activity6ViewModel.PhasedItemList[k].TagId == tagId)
			{
				activity6ViewModel.PhasedItemList[k].AreaRedPoint = false;
			}
		}
	}

	private void GetCurrentTowerRankTypeId()
	{
		multiRankTypeId = 24;
		DRRankType[] dataRows = GameEntry.DataTable.GetDataRows((DRRankType p) => p.Type == 11);
		if (dataRows == null || dataRows.Length == 0)
		{
			return;
		}
		foreach (DRRankType dRRankType in dataRows)
		{
			if (RankDefinition.GetRankState(dRRankType.StartTime, dRRankType.EndTime, dRRankType.OffTime) == RankDefinition.RankState.InProgress)
			{
				multiRankTypeId = dRRankType.Id;
				break;
			}
		}
	}

	public async void RefreshTowerTopRankScoreAsync()
	{
		try
		{
			IRankService service = Singleton<ServiceSystem>.Instance.GetService<IRankService>();
			if (service == null)
			{
				Score = 0;
				return;
			}
			DRRank dataRow = GameEntry.DataTable.GetDataRow((DRRank p) => p.RankType == multiRankTypeId);
			if (dataRow == null)
			{
				Score = 0;
				return;
			}
			long selfUid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
			List<PbChallengeCopyRankInfo> list = await service.RequestTowerCopyRankData(11, dataRow.RankTarget);
			if (list == null || list.Count <= 0)
			{
				Score = 0;
				return;
			}
			List<PbChallengeCopyRankInfo> list2 = list.FindAll((PbChallengeCopyRankInfo p) => p.Players.Exists((PbSuitboxCopyRankSingleUserInfo v) => v.UserId == selfUid));
			if (list2.Count <= 0)
			{
				Score = 0;
				return;
			}
			PbChallengeCopyRankInfo myData = list2[0];
			list2.ForEach(delegate(PbChallengeCopyRankInfo p)
			{
				if (p.Rank < myData.Rank)
				{
					myData = p;
				}
			});
			Score = myData.Score;
		}
		catch (Exception ex)
		{
			Log.Error("刷新爬塔排行榜分数失败: " + ex.Message + "\n" + ex.StackTrace);
			Score = 0;
		}
	}

	public void GetTabLockFinishInfo()
	{
		activity6ViewModel.GetTabLockFinishInfo();
	}
}
