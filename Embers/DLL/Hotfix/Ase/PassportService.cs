#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class PassportService : IPassportService
{
	private Dictionary<int, int> taskIdValueDic;

	private List<int> completeTask;

	private List<PropDataBase> rewardList;

	private ISubscription<PassportTaskCompleteNotify> subscription_TaskComplete;

	private IMessenger messenger;

	private ISubscription<SOOpenNotifyMessager> subscription_SONotify;

	private PassportInfo passportInfo;

	private Vector2 packIndexValue;

	private List<PropDataBase> packRewardList;

	private Timer timer;

	private PassportViewModel passportViewModel;

	private long openTimeStamp;

	private long serviceTime;

	private long durationTime;

	public PassportService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		taskIdValueDic = new Dictionary<int, int>();
		completeTask = new List<int>();
		rewardList = new List<PropDataBase>();
		packIndexValue = Vector2.zero;
		subscription_TaskComplete = Singleton<NetworkSystem>.Instance.Subscribe<PassportTaskCompleteNotify>(TaskComplete);
		subscription_SONotify = messenger.Subscribe<SOOpenNotifyMessager>(OnSystemOpen);
		packRewardList = new List<PropDataBase>();
		passportInfo = new PassportInfo();
	}

	public async UniTask<bool> SendGetPassportInfoRequest()
	{
		GetUserPassportInfoRequest getUserPassportInfoRequest = GetUserPassportInfoRequest.Create();
		GetUserPassportInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUserPassportInfoResponse>(getUserPassportInfoRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "执照", "请求执照数据失败", showToast: false))
			{
				passportInfo.Grade = response.Grade;
				passportInfo.Point = response.Point;
				passportInfo.WeeklyPoint = response.WeeklyGetPoint;
				passportInfo.Level = response.Level;
				passportInfo.Reward = new List<int>();
				passportInfo.EndTime = response.EndTime;
				passportInfo.WeeklyPointMax = GameEntry.DataTable.GetAllDataRow<DRPassportShow>()[0].ExpLimit;
				passportInfo.LevelMax = GameEntry.DataTable.GetDataRows((DRPassportReward p) => p.Grade == 1).Length;
				int num = GameEntry.DataTable.GetAllDataRow<DRPassportReward>().Length;
				num = num / 32 + 1;
				for (int num2 = 0; num2 < num; num2++)
				{
					passportInfo.Reward.Add(0);
				}
				if (response.LevelMaxRewardState != null)
				{
					foreach (PbRewardStateList item in response.LevelMaxRewardState)
					{
						passportInfo.Reward[item.Type] = item.RewardState;
					}
				}
				taskIdValueDic.Clear();
				completeTask.Clear();
				foreach (PbState item2 in response.TaskDoneValue)
				{
					taskIdValueDic.Add(item2.Id, item2.Value);
					if (item2.State == 1)
					{
						completeTask.Add(item2.Id);
					}
				}
				if (passportViewModel == null)
				{
					passportViewModel = new PassportViewModel(null);
				}
				passportViewModel?.Refresh();
				OpenTimer();
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
			Log.Error("请求执照数据失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			getUserPassportInfoRequest.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> SendGetPassportTaskRequest()
	{
		GetUserPassportInfoRequest getUserPassportInfoRequest = GetUserPassportInfoRequest.Create();
		GetUserPassportInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUserPassportInfoResponse>(getUserPassportInfoRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "执照", "请求执照任务", showToast: false))
			{
				taskIdValueDic.Clear();
				completeTask.Clear();
				foreach (PbState item in response.TaskDoneValue)
				{
					taskIdValueDic.Add(item.Id, item.Value);
					if (item.State == 1)
					{
						completeTask.Add(item.Id);
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
			Log.Error("请求执照任务数据失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			getUserPassportInfoRequest.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> SendTaskCompleteRequest(int taskId, int taskType)
	{
		PassportTaskCompleteRequest passportTaskCompleteRequest = PassportTaskCompleteRequest.Create();
		passportTaskCompleteRequest.TaskId = taskId;
		PassportTaskCompleteResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<PassportTaskCompleteResponse>(passportTaskCompleteRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "执照", "完成执照任务失败", showToast: false))
			{
				if (passportInfo.WeeklyPoint >= passportInfo.WeeklyPointMax && taskType != 3)
				{
					Toast.ShowInfo("本周绩点达到上限");
				}
				completeTask.Add(response.TaskId);
				passportInfo.Level = response.PassportLevel;
				passportInfo.Point = response.TotalPoint;
				passportInfo.WeeklyPoint = response.WeeklyGetPoint;
				return true;
			}
			if (response.Error == 200200)
			{
				Toast.ShowInfo("本周绩点达到上限");
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error("完成执照任务失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			passportTaskCompleteRequest.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> SendGetRewardRequest(int indexId, bool clearReward = true)
	{
		if (clearReward)
		{
			rewardList.Clear();
		}
		packIndexValue = Vector2.zero;
		GetPassportRewardRequest getPassportRewardRequest = GetPassportRewardRequest.Create();
		getPassportRewardRequest.Id = indexId;
		GetPassportRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetPassportRewardResponse>(getPassportRewardRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "执照", "请求执照奖励失败", showToast: false))
			{
				if (response.LevelMaxRewardState != null)
				{
					foreach (PbRewardStateList item in response.LevelMaxRewardState)
					{
						passportInfo.Reward[item.Type] = item.RewardState;
					}
				}
				if (response.Rewards != null)
				{
					RewardGetData rewardGetData = await PropHelper.AnalyzeRewardFromServer(response.Rewards);
					if (rewardGetData != null)
					{
						rewardList.AddRange(rewardGetData.PropList);
					}
				}
				if (response.CheckPacksIds != null)
				{
					packIndexValue = new Vector2(response.CheckPacksIds.Id, response.CheckPacksIds.Value);
				}
				if (response.LimitItems != null)
				{
					foreach (PbIdValue limitItem in response.LimitItems)
					{
						DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(limitItem.Id);
						if (dataRow != null)
						{
							Toast.ShowInfo("道具:" + dataRow.Name + " 已达到拥有上限");
						}
					}
				}
				return true;
			}
			if (response.LimitItems != null)
			{
				foreach (PbIdValue limitItem2 in response.LimitItems)
				{
					DRProp dataRow2 = GameEntry.DataTable.GetDataRow<DRProp>(limitItem2.Id);
					if (dataRow2 != null)
					{
						Toast.ShowInfo("道具:" + dataRow2.Name + " 已达到拥有上限");
					}
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error("获取活跃度数据失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			getPassportRewardRequest.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> BuyPassportLevel(int addLevel)
	{
		UpgradePassportLevelRequest request = UpgradePassportLevelRequest.Create();
		request.AddLevel = addLevel;
		UpgradePassportLevelResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<UpgradePassportLevelResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "执照", "执照升级失败", showToast: false))
			{
				passportInfo.Level = response.Level;
				MoneyDefinition.AddMoney(RoleMoneyEnum.Diamond, -addLevel * 150);
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
			Log.Error("获取活跃度数据失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> BuyPassport(int type)
	{
		BuyPassportRequest buyPassportRequest = BuyPassportRequest.Create();
		buyPassportRequest.Type = type;
		BuyPassportResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<BuyPassportResponse>(buyPassportRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "执照", "购买执照失败", showToast: false))
			{
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
			Log.Error("购买执照失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			buyPassportRequest.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public void ClearReward()
	{
		rewardList.Clear();
	}

	public void ClearPackReward()
	{
		packRewardList.Clear();
	}

	public List<PropDataBase> GetPackReward()
	{
		return packRewardList;
	}

	public async UniTask<bool> SendGetPackRequest(int packId, int selectIndex)
	{
		GetPassportPackRewardRequest getPassportPackRewardRequest = GetPassportPackRewardRequest.Create();
		PbIdValue pbIdValue = new PbIdValue();
		pbIdValue.Id = packId;
		pbIdValue.Value = selectIndex;
		getPassportPackRewardRequest.Ids = pbIdValue;
		GetPassportPackRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetPassportPackRewardResponse>(getPassportPackRewardRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "执照", "执照礼盒自选", showToast: false))
			{
				if (response.Rewards != null)
				{
					RewardGetData rewardGetData = await PropHelper.AnalyzeRewardFromServer(response.Rewards);
					if (rewardGetData != null)
					{
						packRewardList.AddRange(rewardGetData.PropList);
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
			Log.Error("获取活跃度数据失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			getPassportPackRewardRequest.Dispose();
			response?.Dispose();
		}
		Toast.ShowInfo("选择失败");
		return false;
	}

	private void TaskComplete(PassportTaskCompleteNotify notify)
	{
		if (taskIdValueDic.ContainsKey(notify.TaskId))
		{
			taskIdValueDic[notify.TaskId] = notify.TaskValue;
		}
		passportViewModel?.Refresh();
	}

	public Dictionary<int, int> GetTaskIdValueDic()
	{
		return taskIdValueDic;
	}

	public List<int> GetCompleteTask()
	{
		return completeTask;
	}

	public List<PropDataBase> GetRewardList()
	{
		return rewardList;
	}

	public PassportInfo GetPassportInfo()
	{
		return passportInfo;
	}

	public Vector2 GetPackIdValue()
	{
		return packIndexValue;
	}

	private async void OpenTimer()
	{
		try
		{
			if (timer != null)
			{
				Timer.Cancel(timer);
				timer = null;
			}
			if (passportInfo != null)
			{
				serviceTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
				if (serviceTime < Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().AccountCreateTime)
				{
					serviceTime = await Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetServiceTime();
				}
				string obj = GameEntry.DataTable.GetDataRow<DRTimeLimit>(1)?.StartTime;
				string format = "yyyy.MM.dd HH:mm:ss";
				TimeHelper.StringToDateTime(obj + " 04:00:00", format, out var time);
				openTimeStamp = ((DateTimeOffset)time).ToUnixTimeSeconds();
				if (openTimeStamp > serviceTime)
				{
					durationTime = openTimeStamp - serviceTime;
				}
				else
				{
					durationTime = passportInfo.EndTime - serviceTime;
				}
				CheckPassportOpen();
				if (durationTime > 0)
				{
					Timer.Register(durationTime + 1, ReQuest, null, isLooped: false, useRealTime: true);
				}
			}
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
	}

	private async void ReQuest()
	{
		await SendGetPassportInfoRequest();
	}

	public bool CheckPassportOpen()
	{
		serviceTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		bool state = Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70012);
		bool flag = passportInfo.Grade > 0 && serviceTime >= openTimeStamp && serviceTime < passportInfo.EndTime;
		return state & flag;
	}

	private void OnSystemOpen(SOOpenNotifyMessager messager)
	{
		if (messager.state && 70012 == messager.serviceId)
		{
			CheckPassportOpen();
		}
	}

	public PassportViewModel GetPassportViewModel()
	{
		return passportViewModel;
	}
}
