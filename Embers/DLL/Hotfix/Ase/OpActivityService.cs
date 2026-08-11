#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Network;
using GameFramework.Runtime;
using Newtonsoft.Json;

namespace Ase;

public class OpActivityService : IOpActivityService
{
	private INetworkChannel channel;

	private OpActViewModel opActViewModel;

	private IMessenger messenger;

	private ISubscription<UserThingCountChangeNotify> subscription_PropCountChange;

	private ISubscription<SOOpenNotifyMessager> subscription_SONotify;

	private ISubscription<RoleExpOrLevelUpNotifyMessager> subscription_UpdateLevel;

	private ISubscription<TaskChangeNotifyMessager> subscription_TaskNotify;

	private ISubscription<UserInfoMessage> subscription_UserInfo;

	private ISubscription<ShopMessage> subscription_shop;

	private ISubscription<OpActivityMessage> subscription_OpActivity;

	private ISubscription<ActivityTaskRateNotify> subscription_TaskProgressChanged;

	private ISubscription<ActivityOpenNotify> subscription_ActivityOpenStateNofity;

	private ISubscription<PropChangeMessage> knapsackChangeNotify;

	public IMessenger GetMessager()
	{
		return messenger;
	}

	public OpActivityService()
	{
		opActViewModel = new OpActViewModel();
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_PropCountChange = Singleton<NetworkSystem>.Instance.Subscribe<UserThingCountChangeNotify>(UserThingCountChangeNotify);
		subscription_SONotify = messenger.Subscribe<SOOpenNotifyMessager>(OnSystemOpen);
		subscription_UpdateLevel = messenger.Subscribe<RoleExpOrLevelUpNotifyMessager>(OnLevelChangeNotify);
		subscription_TaskNotify = messenger.Subscribe<TaskChangeNotifyMessager>(GetTaskNotify);
		subscription_UserInfo = messenger.Subscribe<UserInfoMessage>(OnUserInfoNotify);
		subscription_shop = messenger.Subscribe<ShopMessage>(OnShopMsgNotify);
		subscription_OpActivity = messenger.Subscribe<OpActivityMessage>(OnActivityMsgNotify);
		subscription_TaskProgressChanged = Singleton<NetworkSystem>.Instance.Subscribe<ActivityTaskRateNotify>(OnTaskRateNotify);
		subscription_ActivityOpenStateNofity = Singleton<NetworkSystem>.Instance.Subscribe<ActivityOpenNotify>(OnOpenStateNotify);
		knapsackChangeNotify = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetMessager().Subscribe<PropChangeMessage>(OnKnapsackChanged);
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.AddDailyUpdateAction(OnDailyUpdated);
	}

	public async UniTask<bool> RequestOpActDatas()
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70003))
		{
			return true;
		}
		GetActivityTaskDataRequest rst = GetActivityTaskDataRequest.Create();
		GetActivityTaskDataResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetActivityTaskDataResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求活动任务数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求活动任务数据失败"))
			{
				List<int> actIds = new List<int>();
				List<PbActivityTypeAllData> taskDatas = new List<PbActivityTypeAllData>();
				new List<PbActivityTypeAllData>();
				Dictionary<int, List<PbActivityVersionData>> versionDatas = new Dictionary<int, List<PbActivityVersionData>>();
				Dictionary<int, List<PbCopyInfo>> pbCopyInfos = new Dictionary<int, List<PbCopyInfo>>();
				List<int> openActivityIds = response.OpenActivityIds;
				if (openActivityIds != null)
				{
					foreach (int id in openActivityIds)
					{
						if (GameEntry.BuiltinData.OpenTestFlight && Constant.DisabledActivityType.Contains(id))
						{
							continue;
						}
						ActivitySingleServerData activitySingleServerData = await RequestSingleOpActData(id);
						if (activitySingleServerData != null)
						{
							actIds.Add(id);
							taskDatas.Add(activitySingleServerData.normalData);
							if (activitySingleServerData.versionDatas != null && activitySingleServerData.versionDatas.Count > 0)
							{
								versionDatas.Add(id, activitySingleServerData.versionDatas);
								pbCopyInfos.Add(id, activitySingleServerData.versionCopy);
							}
						}
					}
				}
				opActViewModel.InitAllActivityData(actIds, taskDatas);
				GetVersionData(versionDatas, pbCopyInfos);
				opActViewModel.InitAllActivityVersionData();
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception)
		{
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	private void GetVersionData(Dictionary<int, List<PbActivityVersionData>> pbVersionDataDictionary, Dictionary<int, List<PbCopyInfo>> pbCopyInfosDictionary)
	{
		foreach (KeyValuePair<int, List<PbActivityVersionData>> item in pbVersionDataDictionary)
		{
			int key = item.Key;
			List<ActivityVersionData> versionActivityDataList = opActViewModel.GetVersionActivityDataList(key);
			CopyViewModel copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
			if (pbCopyInfosDictionary.ContainsKey(key))
			{
				List<PbCopyInfo> list = pbCopyInfosDictionary[key];
				if (list != null)
				{
					for (int i = 0; i < list.Count; i++)
					{
						copyVM.GetCopyById(list[i].CopyId)?.SetStarAndScore(list[i].Star, list[i].Score);
					}
				}
			}
			if (versionActivityDataList == null)
			{
				continue;
			}
			List<PbActivityVersionData> value = item.Value;
			for (int j = 0; j < value.Count; j++)
			{
				for (int k = 0; k < versionActivityDataList.Count; k++)
				{
					if (value[j].RankId != versionActivityDataList[k].DrVersionActivity.RankFirst || (value[j].RewardState & (1 << versionActivityDataList[k].DrVersionActivity.RankSecond - 1)) <= 0)
					{
						continue;
					}
					if (versionActivityDataList[k].DrVersionActivity.Type == 2)
					{
						CopyData copyById = copyVM.GetCopyById(versionActivityDataList[k].DrVersionActivity.Content);
						if (copyById != null)
						{
							versionActivityDataList[k].SetComplete(copyById.StarCur);
						}
					}
					else
					{
						versionActivityDataList[k].SetComplete(0);
					}
				}
			}
		}
	}

	public async UniTask<ActivitySingleServerData> RequestSingleOpActData(int activityTypeId)
	{
		GetSingleActivityTaskDataRequest rst = GetSingleActivityTaskDataRequest.Create();
		rst.ActivityType = activityTypeId;
		GetSingleActivityTaskDataResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetSingleActivityTaskDataResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"请求活动:{activityTypeId}的任务数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"请求活动:{activityTypeId}的任务数据"))
			{
				return new ActivitySingleServerData
				{
					normalData = response.TaskDatas,
					versionDatas = response.ActivityVersionData,
					versionCopy = response.CopyInfos
				};
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception)
		{
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<ActivityReward> GetTaskReward(int type, int id, int rankId = 0)
	{
		ActivityReward activityReward = default(ActivityReward);
		ActivityTaskData activityTaskData = opActViewModel.GetActivityTaskData(type, id);
		if (id != 0 && (activityTaskData == null || activityTaskData.RewardState != 0))
		{
			return activityReward;
		}
		GetActivityTaskRewardRequest rst = GetActivityTaskRewardRequest.Create();
		rst.ActivityType = type;
		if (rankId > 0)
		{
			rst.Id = 0;
		}
		else
		{
			rst.Id = id;
		}
		rst.RankId = rankId;
		GetActivityTaskRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetActivityTaskRewardResponse>(rst);
			activityReward.ErrorCode = response.Error;
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求活动奖励"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求活动奖励失败"))
				{
					RewardThings rewards = (await PropHelper.AnalyzeRewardFromServer(response.Rewards)).ConvertToRewardThings();
					activityReward.Rewards = rewards;
					activityReward.Result = true;
					opActViewModel.SetTaskRewardGotten(type, id);
					if (id == 0)
					{
						ActivitySingleServerData activitySingleServerData = await RequestSingleOpActData(type);
						if (activitySingleServerData != null)
						{
							foreach (PbActivityTaskData data in activitySingleServerData.normalData.Datas)
							{
								opActViewModel.UpdateActivityTaskProgress(activitySingleServerData.normalData.ActivityType, data.Id, data.CompeteValue, data.RewardState);
							}
						}
						else
						{
							Log.Error($"请求单活动数据失败，活动类型：{type}");
						}
					}
				}
				else if (response.Error == 200033)
				{
					opActViewModel.SetTaskRewardGotten(type, id);
				}
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

	public async UniTask<bool> GetTaskRankProgress(int activityId)
	{
		GetActivityRankProgressRequest rst = GetActivityRankProgressRequest.Create();
		rst.activityType = activityId;
		GetActivityRankProgressResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetActivityRankProgressResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求活动阶段进度") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求活动阶段进度失败"))
			{
				ActivityViewModelBase activityViewModel = opActViewModel.GetActivityViewModel(activityId);
				if (activityViewModel == null)
				{
					return true;
				}
				foreach (PbActivityRankStateData rankData in response.RankData)
				{
					if (GameEntry.DataTable.GetDataRow((DRActivityRankProgress p) => p.Id == rankData.Id) != null)
					{
						activityViewModel.UpdateActivityProgress(rankData.Id, rankData.CompeteValue, rankData.RewardState, rankData.ProgressId);
					}
					DRActivityRank dataRow = GameEntry.DataTable.GetDataRow((DRActivityRank p) => p.Id == rankData.Id);
					if (dataRow != null)
					{
						opActViewModel.UpdateActivityTaskProgress(dataRow.ActivityTypeId, rankData.Id, rankData.CompeteValue, rankData.RewardState);
					}
				}
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

	public async UniTask<ActivityReward> GetTaskRankProgressReward(int rankId, int progressUid, int activityType)
	{
		GetActivityRankRewardRequest rst = GetActivityRankRewardRequest.Create();
		rst.RankId = rankId;
		rst.RankProgressId = progressUid;
		rst.activityType = activityType;
		ActivityReward activityReward = default(ActivityReward);
		GetActivityRankRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetActivityRankRewardResponse>(rst);
			activityReward.ErrorCode = response.Error;
			activityReward.Result = false;
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求活动阶段奖励") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求活动阶段奖励失败"))
			{
				ActivityViewModelBase vmBase = opActViewModel.GetActivityViewModel(activityType);
				if (vmBase == null)
				{
					return activityReward;
				}
				vmBase.UpdateActivityTaskProgress(progressUid);
				RewardThings rewards = (await PropHelper.AnalyzeRewardFromServer(response.Rewards)).ConvertToRewardThings();
				activityReward.Rewards = rewards;
				activityReward.Result = true;
				foreach (PbActivityRankStateData rankData in response.RankData)
				{
					if (GameEntry.DataTable.GetDataRow((DRActivityRankProgress p) => p.Id == rankData.Id) != null)
					{
						vmBase.UpdateActivityProgress(rankData.Id, rankData.CompeteValue, rankData.RewardState, rankData.ProgressId);
					}
					DRActivityRank dataRow = GameEntry.DataTable.GetDataRow((DRActivityRank p) => p.Id == rankData.Id);
					if (dataRow != null)
					{
						opActViewModel.UpdateActivityTaskProgress(dataRow.ActivityTypeId, rankData.Id, rankData.CompeteValue, rankData.RewardState);
					}
				}
				opActViewModel.RefreshTargetState(vmBase.ActivityTypeId);
			}
			return activityReward;
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
	}

	public async UniTask<ActivityReward> GetActivtiyVersionReward(int activityTypeId, int activityVersionId)
	{
		ActivityReward activityReward = new ActivityReward
		{
			Result = false
		};
		GetActivityVersionRewardRequest rst = GetActivityVersionRewardRequest.Create();
		rst.Id = activityVersionId;
		GetActivityVersionRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetActivityVersionRewardResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求版本活动奖励"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求版本活动奖励失败"))
				{
					opActViewModel.UpdateActivityVersionProgress(activityTypeId, activityVersionId, 0);
					RewardThings rewards = (await PropHelper.AnalyzeRewardFromServer(response.Rewards)).ConvertToRewardThings();
					activityReward.Rewards = rewards;
					activityReward.Result = true;
					return activityReward;
				}
				if (response.Error == 200159)
				{
					opActViewModel.UpdateActivityVersionProgress(activityTypeId, activityVersionId, 0);
				}
			}
			activityReward.ErrorCode = response.Error;
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

	public async UniTask<(DrawCardActivityInfo, BroadcastJsonData)> SendDrawCardInfoRst(int activityTypeId)
	{
		C2H_SkinDrawInfoRequest rst = C2H_SkinDrawInfoRequest.Create();
		rst.Id = activityTypeId;
		H2C_SkinDrawInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_SkinDrawInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"请求抽奖活动:{activityTypeId}的数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"请求抽奖活动:{activityTypeId}的数据"))
			{
				BroadcastJsonData item = new BroadcastJsonData();
				if (!string.IsNullOrEmpty(response.Param1))
				{
					List<BroadcastNotify> broadcastNotifies = JsonConvert.DeserializeObject<List<BroadcastNotify>>(response.Param1);
					item = new BroadcastJsonData
					{
						BroadcastNotifies = broadcastNotifies
					};
				}
				return (new DrawCardActivityInfo
				{
					AllTimes = response.AllTimes,
					DrawState = DrawCardActivityInfo.AnalysisDrawState(activityTypeId, response.DrawState)
				}, item);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception)
		{
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return (null, new BroadcastJsonData());
	}

	public async UniTask<DrawCardActivityResult> SendDrawCardRst(int activityTypeId)
	{
		C2H_SkinDrawRequest rst = C2H_SkinDrawRequest.Create();
		rst.Id = activityTypeId;
		H2C_SkinDrawResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_SkinDrawResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"请求抽奖:{activityTypeId}") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"请求抽奖:{activityTypeId}"))
			{
				DrawCardActivityInfo info = new DrawCardActivityInfo
				{
					AllTimes = response.AllTimes,
					DrawState = DrawCardActivityInfo.AnalysisDrawState(activityTypeId, response.DrawState)
				};
				PropHelper.AnalyzeRewardFromServer(response.ItemChange);
				RewardGetData rewardData = await PropHelper.AnalyzeRewardFromServer(response.dropThings);
				return new DrawCardActivityResult
				{
					Info = info,
					RewardData = rewardData,
					Pos = response.Pos
				};
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception)
		{
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<DrawCardActivityInfo> SendLotteryInfoRst(int activityTypeId)
	{
		C2H_SkinDrawInfoRequest rst = C2H_SkinDrawInfoRequest.Create();
		rst.Id = activityTypeId;
		H2C_SkinDrawInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_SkinDrawInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"请求刮刮乐活动:{activityTypeId}的数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"请求刮刮乐活动:{activityTypeId}的数据"))
			{
				DrawCardActivityInfo obj = new DrawCardActivityInfo
				{
					AllTimes = response.AllTimes,
					DrawState = DrawCardActivityInfo.AnalysisDrawState(activityTypeId, response.DrawState)
				};
				DrawCardActivityInfo.InitPosRewardInfo(obj, response.PositionRewards);
				return obj;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception)
		{
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<DrawCardActivityResult> SendLotteryRst(int activityTypeId, int pos)
	{
		C2H_SkinDrawRequest rst = C2H_SkinDrawRequest.Create();
		rst.Id = activityTypeId;
		rst.Pos = pos;
		H2C_SkinDrawResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_SkinDrawResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"请求刮刮乐:{activityTypeId}") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"请求刮刮乐:{activityTypeId}"))
			{
				DrawCardActivityInfo info = new DrawCardActivityInfo
				{
					AllTimes = response.AllTimes,
					DrawState = DrawCardActivityInfo.AnalysisDrawState(activityTypeId, response.DrawState)
				};
				DrawCardActivityInfo.AddPosRewardInfo(info, response.Pos, response.RewardConfigId);
				PropHelper.AnalyzeRewardFromServer(response.ItemChange);
				RewardGetData rewardData = await PropHelper.AnalyzeRewardFromServer(response.dropThings);
				return new DrawCardActivityResult
				{
					Info = info,
					RewardData = rewardData,
					Pos = response.Pos
				};
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception)
		{
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public bool GetActivityOpenState(out string msg)
	{
		ISOService service = Singleton<ServiceSystem>.Instance.GetService<ISOService>();
		if (service == null || !service.GetState(70003))
		{
			msg = "活动系统未开放";
			return false;
		}
		if (opActViewModel?.ActivityViewModels == null || opActViewModel.ActivityViewModels.Count <= 0 || !opActViewModel.ActivityViewModels.Values.ToList().Exists((ActivityViewModelBase p) => p.IsUnderWay()))
		{
			msg = "当前没有进行中的活动";
			return false;
		}
		msg = "";
		return true;
	}

	public OpActViewModel GetActivityVm()
	{
		return opActViewModel;
	}

	private void UserThingCountChangeNotify(UserThingCountChangeNotify message)
	{
		opActViewModel?.RefreshTypeAndFinishState();
	}

	private async void OnSystemOpen(SOOpenNotifyMessager messager)
	{
		if (messager != null)
		{
			if (messager.state && 70003 == messager.serviceId)
			{
				await RequestOpActDatas();
			}
			opActViewModel?.RefreshAllState();
		}
	}

	private async void OnLevelChangeNotify(RoleExpOrLevelUpNotifyMessager msg)
	{
		if (msg != null && msg.MessageEnum == RoleExpOrLevelUpNotifyMessager.RoleExpLevelMsgEnum.LevelUp)
		{
			await RequestOpActDatas();
			opActViewModel?.RefreshAllState();
		}
	}

	private void GetTaskNotify(TaskChangeNotifyMessager messager)
	{
		if (messager != null && messager.changeNotifyType == TaskSystem.TaskChangeNotifyType.CopyOpenUpdate)
		{
			opActViewModel?.RefreshAllState();
		}
	}

	private void OnUserInfoNotify(UserInfoMessage msg)
	{
		if (msg != null && msg.MessageType == UserInfoMessage.MsgTypeEnum.UserBaseInfoChanged)
		{
			opActViewModel?.RefreshAllState();
		}
	}

	private void OnShopMsgNotify(ShopMessage msg)
	{
		if (msg != null && (msg.Type == ShopMessageEnum.GoodsInitialized || msg.Type == ShopMessageEnum.ReceivedPayRewards || msg.Type == ShopMessageEnum.GoodsBuy))
		{
			opActViewModel?.RefreshAllState();
		}
	}

	private void OnActivityMsgNotify(OpActivityMessage msg)
	{
		if (msg != null && msg.Type == OpActivityMessageEnum.TaskStateChanged)
		{
			if (msg.Arg != null && msg.Arg is int typeId)
			{
				opActViewModel?.RefreshTargetState(typeId);
			}
			else
			{
				opActViewModel?.RefreshAllState();
			}
		}
	}

	private void OnTaskRateNotify(ActivityTaskRateNotify notify)
	{
		if (notify != null)
		{
			opActViewModel?.OnTaskRateNotify(notify);
		}
	}

	private async void OnOpenStateNotify(ActivityOpenNotify notify)
	{
		if (notify == null)
		{
			return;
		}
		if (notify.Open)
		{
			if (GameEntry.BuiltinData.OpenTestFlight && Constant.DisabledActivityType.Contains(notify.ActivityType))
			{
				return;
			}
			Loading loading = await Loading.Show();
			ActivitySingleServerData activitySingleServerData = await RequestSingleOpActData(notify.ActivityType);
			loading?.Dispose();
			if (opActViewModel != null)
			{
				List<ActivityTaskData> activityTaskDatas = new List<ActivityTaskData>();
				activitySingleServerData?.normalData?.Datas?.ForEach(delegate(PbActivityTaskData p)
				{
					activityTaskDatas.Add(new ActivityTaskData(p));
				});
				opActViewModel.AddActivityOpened(notify.ActivityType, activityTaskDatas);
				if (activitySingleServerData != null && activitySingleServerData.versionDatas != null && activitySingleServerData.versionDatas.Count > 0)
				{
					Dictionary<int, List<PbCopyInfo>> dictionary = new Dictionary<int, List<PbCopyInfo>>();
					dictionary.Add(notify.ActivityType, activitySingleServerData.versionCopy);
					Dictionary<int, List<PbActivityVersionData>> dictionary2 = new Dictionary<int, List<PbActivityVersionData>>();
					dictionary2.Add(notify.ActivityType, activitySingleServerData.versionDatas);
					GetVersionData(dictionary2, dictionary);
					opActViewModel.InitAllActivityVersionData();
				}
			}
		}
		else if (opActViewModel != null)
		{
			opActViewModel.RemoveActivityFinished(notify.ActivityType);
		}
	}

	private void OnKnapsackChanged(PropChangeMessage message)
	{
		opActViewModel.OnKnapsackChange(message);
	}

	private void OnDailyUpdated()
	{
		Log.Error("活动Service 转点刷新");
		opActViewModel?.RefreshTypeAndFinishState();
	}
}
