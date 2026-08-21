#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class PhasedActivity6ViewModel : PhasedActivityViewModel
{
	private bool achievementRed;

	private bool rewardRed;

	private string rewardText;

	private string achievementProgressText;

	private bool achievementComplete;

	private bool rewardComplete;

	private ISubscription<ClimbTowerRedPointMeaasger> subscription_climbTowerActivity;

	private bool getUpdateRedMessage;

	private bool getUpdateRedMessageValue;

	private int maxActivityRank;

	private List<ActivityTaskData> towerTaskData;

	private string activityDesc;

	private List<ReceiveItemViewModel> rewardItemViewModels;

	protected override bool useUpdateRedPoint => false;

	public List<ReceiveItemViewModel> RewardItemViewModels => rewardItemViewModels;

	public string AcitivityDesc
	{
		get
		{
			return activityDesc;
		}
		set
		{
			Set(ref activityDesc, value, "AcitivityDesc");
		}
	}

	public bool AchievementRed
	{
		get
		{
			return achievementRed;
		}
		set
		{
			Set(ref achievementRed, value, "AchievementRed");
		}
	}

	public bool RewardRed
	{
		get
		{
			return rewardRed;
		}
		set
		{
			Set(ref rewardRed, value, "RewardRed");
		}
	}

	public string RewardText
	{
		get
		{
			return rewardText;
		}
		set
		{
			Set(ref rewardText, value, "RewardText");
		}
	}

	public string AchievementProgressText
	{
		get
		{
			return achievementProgressText;
		}
		set
		{
			Set(ref achievementProgressText, value, "AchievementProgressText");
		}
	}

	public bool AchievementComplete
	{
		get
		{
			return achievementComplete;
		}
		set
		{
			Set(ref achievementComplete, value, "AchievementComplete");
		}
	}

	public bool RewardComplete
	{
		get
		{
			return rewardComplete;
		}
		set
		{
			Set(ref rewardComplete, value, "RewardComplete");
		}
	}

	public int MaxActivityRank => maxActivityRank;

	public List<ActivityTaskData> TowerTaskData => towerTaskData;

	public override void Init(OpActViewModel opActViewModel, DRActivityType drData)
	{
		base.Init(opActViewModel, drData);
		subscription_climbTowerActivity = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<ClimbTowerRedPointMeaasger>(OnClimbTowerChange);
	}

	private void OnClimbTowerChange(ClimbTowerRedPointMeaasger messager)
	{
		getUpdateRedMessage = true;
		getUpdateRedMessageValue = messager.AreaRedPoint || messager.TalentRedPoint;
		UpdateRed();
		getUpdateRedMessage = false;
	}

	public override void SetServiceTaskData(List<ActivityTaskData> taskDataList)
	{
		base.SetServiceTaskData(taskDataList);
		AcitivityDesc = _drActivityType.Desc.Replace("\\n", "\n");
		rewardItemViewModels = GetCopyDrop(_drActivityType.RewardId);
		int level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
		long maxCopyOpenIndex = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().MaxCopyOpenIndex;
		for (int i = 0; i < taskDataList.Count; i++)
		{
			DRActivityRankTask dataRow = GameEntry.DataTable.GetDataRow<DRActivityRankTask>(taskDataList[i].Id);
			if (dataRow == null)
			{
				continue;
			}
			int activityTaskId = dataRow.ActivityTaskId;
			DRActivityTask dataRow2 = GameEntry.DataTable.GetDataRow<DRActivityTask>(activityTaskId);
			if (dataRow2 == null)
			{
				continue;
			}
			int num = dataRow2.RequireValue[0];
			DRCopy dataRow3 = GameEntry.DataTable.GetDataRow<DRCopy>(num);
			if (dataRow3 != null)
			{
				CopyData copyById = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(num);
				if (copyById == null)
				{
					copyById = CopyData.CreateActivityCopy(dataRow3, _drActivityType.Id);
					copyById.UpdatePlayerLevel(level);
					copyById.UpdateTaskProgress(maxCopyOpenIndex);
					Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddActivityTowerCopyData(num, copyById);
				}
			}
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is ActivityTabItemData2 tab)
		{
			CheckUnLock(tab);
		}
		else if (obj is ReceiveItemViewModel receiveItemViewModel)
		{
			OpenViewArg obj2 = receiveItemViewModel.OpenPopupWindow(parent);
			parent?.ItemOnClick(obj2);
		}
		else if (obj is TowerEnterCopyViewModel)
		{
			parent?.ItemOnClick(obj);
		}
		else if (obj is ViewBackArg viewBackArg && viewBackArg.Obj is TowerActivityAreaViewModel)
		{
			UpdateRed();
		}
	}

	private List<ReceiveItemViewModel> GetCopyDrop(int rewardId)
	{
		List<ReceiveItemViewModel> list = new List<ReceiveItemViewModel>();
		DRCopyDrop dataRow = GameEntry.DataTable.GetDataRow((DRCopyDrop p) => p.RewardGroupId == rewardId);
		if (dataRow != null)
		{
			if (dataRow.PropTypeShow.Count != dataRow.PropIDShow.Count)
			{
				return null;
			}
			for (int num = 0; num < dataRow.PropTypeShow.Count; num++)
			{
				PropDataBase propDataBase = PropDataBase.CreateByType(dataRow.PropTypeShow[num], dataRow.PropIDShow[num]);
				if (propDataBase == null)
				{
					Log.Error($"CopyDrop2 配置表，Id【{dataRow.Id}】CopyDrop.PropTypeShow {dataRow.PropTypeShow[num]}，CopyDrop.PropIDShow {dataRow.PropIDShow[num]}配置有误！");
					continue;
				}
				ReceiveItemViewModel receiveItemViewModel = new ReceiveItemViewModel(propDataBase, this);
				list.Add(receiveItemViewModel);
				if (dataRow.IsShowNum.Count > num && dataRow.IsShowNum[num] == 1 && dataRow.PropNumShow.Count > num)
				{
					receiveItemViewModel.SetCountRange(dataRow.PropNumShow[num]);
				}
				else
				{
					receiveItemViewModel.SetCountRange("");
				}
			}
		}
		return list;
	}

	public override async UniTask SetLastPlayCopyData(CopyData lastPlay)
	{
		if (Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCurChallengeTowerLayer() <= 0)
		{
			TowerActivityAreaViewModel userData = new TowerActivityAreaViewModel(this, lastPlay);
			(await GameEntry.UI.LoadWindow<TowerActivityAreaWindow>("OperatingActivity/TownChallenge/TowerActivityAreaWindow", userData)).Show();
		}
	}

	public override bool UpdateRed(bool notifyParent = true)
	{
		if (getUpdateRedMessage)
		{
			base.Red = getUpdateRedMessageValue;
			base.UpdateRed(notifyParent);
			return getUpdateRedMessageValue;
		}
		UpdateRedPoint();
		bool flag = false;
		for (int i = 0; i < base.PhasedItemList.Count - 1; i++)
		{
			if (base.PhasedItemList[i].StateEnum != ActivityTabStateEnum.Lock)
			{
				switch (Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetTowerOneAreaRedPoint(base.PhasedItemList[i].TagId))
				{
				case -1:
					Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SetTowerActivityRedPoint(base.PhasedItemList[i].TagId, 0);
					base.PhasedItemList[i].AreaRedPoint = true;
					flag = true;
					break;
				case 0:
					base.PhasedItemList[i].AreaRedPoint = true;
					flag = true;
					break;
				case 1:
					base.PhasedItemList[i].AreaRedPoint = false;
					break;
				}
			}
		}
		if (Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetTowerUpTalentRedPoint(broadcastMessage: false))
		{
			flag = true;
		}
		InitMaxActivityRank();
		RewardRed = SetRewardRedPoint();
		RefreshAchievementProgress();
		AchievementRed = Singleton<ServiceSystem>.Instance.GetService<IActivityAchievementService>().ByActivityTypeGetRedPoint(base.ActivityTypeId);
		flag = (base.Red = flag || RewardRed);
		base.UpdateRed(notifyParent);
		return flag;
	}

	private void InitMaxActivityRank()
	{
		maxActivityRank = int.MinValue;
		for (int i = 0; i < base.PhasedItemList.Count; i++)
		{
			int tagId = base.PhasedItemList[i].TagId;
			if (tagId >= maxActivityRank)
			{
				maxActivityRank = tagId;
			}
		}
	}

	private bool SetRewardRedPoint()
	{
		bool result = false;
		int num = 0;
		InitTowerTaskData();
		for (int i = 0; i < towerTaskData.Count; i++)
		{
			if (towerTaskData[i].CompleteState == 1)
			{
				num++;
			}
			if (towerTaskData[i].CompleteState == 1 && towerTaskData[i].RewardState == 0)
			{
				result = true;
				break;
			}
			result = false;
		}
		if (num == towerTaskData.Count)
		{
			RewardText = "已完成";
		}
		else
		{
			RewardText = $"玩法奖励：{num}/{towerTaskData.Count}";
		}
		if (num == towerTaskData.Count)
		{
			RewardComplete = true;
		}
		return result;
	}

	public void InitTowerTaskData()
	{
		towerTaskData = new List<ActivityTaskData>();
		string value = maxActivityRank.ToString();
		for (int i = 0; i < base.PbTaskDataList.Count; i++)
		{
			if (base.PbTaskDataList[i].Id != maxActivityRank && base.PbTaskDataList[i].Id.ToString().StartsWith(value))
			{
				towerTaskData.Add(base.PbTaskDataList[i]);
			}
		}
	}

	private void RefreshAchievementProgress()
	{
		List<ActivityAchievementData> list = Singleton<ServiceSystem>.Instance.GetService<IActivityAchievementService>().ByActivityTypeGetAchievementDataList(base.ActivityTypeId);
		if (list == null || list.Count <= 0)
		{
			Debug.Log($"该活动{base.ActivityTypeId}成就出错");
			return;
		}
		float num = 0f;
		for (int i = 0; i < list.Count; i++)
		{
			if (new ActivityAchievementItemData(this, list[i]).Config.state == ActivityAchievementState.Collected)
			{
				num++;
			}
		}
		float num2 = ((list.Count > 0) ? (num / (float)list.Count) : 0f);
		if (num2 >= 1f)
		{
			AchievementComplete = true;
		}
		AchievementProgressText = $"进度：{num2:P0}";
	}
}
