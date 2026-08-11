#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;

namespace Ase;

public class ActivityAchievementService : IActivityAchievementService
{
	private Dictionary<int, Dictionary<int, ActivityAchievementData>> activityAchievementStateCache = new Dictionary<int, Dictionary<int, ActivityAchievementData>>();

	private Dictionary<int, Dictionary<int, ActivityAchievementTaskData>> activityAchievementTaskDataCache = new Dictionary<int, Dictionary<int, ActivityAchievementTaskData>>();

	private Dictionary<int, bool> blockedActivityAchievementRedPointSet = new Dictionary<int, bool>();

	public ActivityAchievementService()
	{
		try
		{
			DRLibraryTower[] allDataRows = GameEntry.DataTable.GetDataTable<DRLibraryTower>().GetAllDataRows();
			foreach (DRLibraryTower dRLibraryTower in allDataRows)
			{
				if (!activityAchievementStateCache.TryGetValue(dRLibraryTower.LibType, out var value))
				{
					value = new Dictionary<int, ActivityAchievementData>();
					activityAchievementStateCache[dRLibraryTower.LibType] = value;
				}
				ActivityAchievementData activityAchievementData = new ActivityAchievementData(dRLibraryTower.Id, dRLibraryTower.LibType, ActivityAchievementState.UnSeen);
				activityAchievementData.InitCfs(dRLibraryTower);
				value[dRLibraryTower.Id] = activityAchievementData;
			}
			DRLibTask[] allDataRows2 = GameEntry.DataTable.GetDataTable<DRLibTask>().GetAllDataRows();
			foreach (DRLibTask dRLibTask in allDataRows2)
			{
				if (!activityAchievementTaskDataCache.TryGetValue(dRLibTask.LibType, out var value2))
				{
					value2 = new Dictionary<int, ActivityAchievementTaskData>();
					activityAchievementTaskDataCache[dRLibTask.LibType] = value2;
				}
				ActivityAchievementTaskData value3 = new ActivityAchievementTaskData(dRLibTask);
				value2[dRLibTask.Id] = value3;
			}
		}
		catch (Exception ex)
		{
			Log.Error("添加表格活动成就数据，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	public async UniTask<bool> GetAllActivityAchievementDataRst()
	{
		C2SGetBuffLibraryInfoRequest rst = C2SGetBuffLibraryInfoRequest.Create();
		S2CGetBuffLibraryInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2CGetBuffLibraryInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求所有活动成就") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求所有活动成就失败"))
			{
				UpdateActivityAchievementState(response.AllInfo.CollectedBuffIds, response.AllInfo.ChosenBuffIds);
				UpdateActivityAchievementTaskData(response.AllInfo.TaskInfos);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	private void UpdateActivityAchievementState(List<int> collectedBuffIds, List<int> chosenBuffIds)
	{
		foreach (Dictionary<int, ActivityAchievementData> value in activityAchievementStateCache.Values)
		{
			foreach (ActivityAchievementData value2 in value.Values)
			{
				if (value2.buffIds == null || value2.buffIds.Count == 0)
				{
					continue;
				}
				if (collectedBuffIds != null && collectedBuffIds.Count > 0)
				{
					foreach (int buffId in value2.buffIds)
					{
						if (collectedBuffIds.Contains(buffId))
						{
							value2.state = ActivityAchievementState.Seen;
							break;
						}
					}
				}
				if (chosenBuffIds == null || chosenBuffIds.Count <= 0)
				{
					continue;
				}
				foreach (int buffId2 in value2.buffIds)
				{
					if (chosenBuffIds.Contains(buffId2))
					{
						value2.state = ActivityAchievementState.Collected;
						break;
					}
				}
			}
		}
	}

	private void UpdateActivityAchievementTaskData(List<PbBuffLibraryTaskInfo> taskInfos)
	{
		if (taskInfos == null || taskInfos.Count == 0)
		{
			return;
		}
		Dictionary<int, PbBuffLibraryTaskInfo> dictionary = new Dictionary<int, PbBuffLibraryTaskInfo>();
		foreach (PbBuffLibraryTaskInfo taskInfo in taskInfos)
		{
			dictionary[taskInfo.TaskId] = taskInfo;
		}
		foreach (Dictionary<int, ActivityAchievementTaskData> value2 in activityAchievementTaskDataCache.Values)
		{
			foreach (ActivityAchievementTaskData value3 in value2.Values)
			{
				if (dictionary.TryGetValue(value3.id, out var value))
				{
					value3.UpdateByPb(value);
				}
			}
		}
	}

	public List<ActivityAchievementData> ByActivityTypeGetAchievementDataList(int activityTypeId)
	{
		if (!activityAchievementStateCache.ContainsKey(activityTypeId))
		{
			return null;
		}
		return activityAchievementStateCache[activityTypeId].Values.ToList();
	}

	public List<ActivityAchievementTaskData> ByActivityTypeGetTaskDataList(int activityTypeId)
	{
		if (!activityAchievementTaskDataCache.ContainsKey(activityTypeId))
		{
			return null;
		}
		return activityAchievementTaskDataCache[activityTypeId].Values.ToList();
	}

	public ActivityAchievementState GetActivityAchievementStateRst(int activityTypeId, int buffId)
	{
		if (activityAchievementStateCache.TryGetValue(activityTypeId, out var value) && value != null)
		{
			foreach (ActivityAchievementData value2 in value.Values)
			{
				if (value2.buffIds != null && value2.buffIds.Contains(buffId))
				{
					return value2.state;
				}
			}
		}
		return ActivityAchievementState.UnSeen;
	}

	public async UniTask<ActivityReward> GetTaskRewardRst(int taskId)
	{
		ActivityReward activityReward = default(ActivityReward);
		C2SClaimBuffLibraryRewardRequest rst = C2SClaimBuffLibraryRewardRequest.Create();
		rst.TaskId = taskId;
		S2CClaimBuffLibraryRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2CClaimBuffLibraryRewardResponse>(rst);
			activityReward.ErrorCode = response.Error;
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "领取活动成就奖励") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "领取活动成就奖励失败"))
			{
				RewardThings rewards = (await PropHelper.AnalyzeRewardFromServer(response.Rewards)).ConvertToRewardThings();
				activityReward.Rewards = rewards;
				activityReward.Result = true;
				RefreshOpActivityRed();
				return activityReward;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return activityReward;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return activityReward;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return activityReward;
	}

	public async UniTask<bool> SendFightChooseBuffIds(List<int> seeBuffIds, List<int> chooseBuffIds)
	{
		C2SCollectBuffRequest rst = C2SCollectBuffRequest.Create();
		rst.BuffIds = seeBuffIds;
		rst.ChosenBuffId = chooseBuffIds;
		S2CCollectBuffResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2CCollectBuffResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "发送遇到和选择的成就") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "发送遇到的和选择成就失败"))
			{
				UpdateActivityAchievementState(response.NewBuffIds, response.NewChosenBuffId);
				UpdateActivityAchievementTaskData(response.TaskInfos);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public bool ByActivityTypeGetRedPoint(int activityTypeId)
	{
		if (IsActivityAchievementRedPointBlocked(activityTypeId))
		{
			return false;
		}
		if (!activityAchievementTaskDataCache.TryGetValue(activityTypeId, out var value) || value == null)
		{
			return false;
		}
		foreach (ActivityAchievementTaskData value2 in activityAchievementTaskDataCache[activityTypeId].Values)
		{
			if (value2.red)
			{
				return true;
			}
		}
		return false;
	}

	public void SetActivityAchievementRedPointBlocked(int activityTypeId, bool blocked)
	{
		if (activityTypeId > 0)
		{
			blockedActivityAchievementRedPointSet[activityTypeId] = blocked;
		}
	}

	public bool IsActivityAchievementRedPointBlocked(int activityTypeId)
	{
		if (activityTypeId <= 0)
		{
			return false;
		}
		bool value;
		return blockedActivityAchievementRedPointSet.TryGetValue(activityTypeId, out value) & value;
	}

	private void RefreshOpActivityRed()
	{
		Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.UpdateReds();
	}
}
