#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class SOService : ISOService
{
	private IMessenger messenger;

	private ISubscription<RoleExpOrLevelUpNotifyMessager> subscription_UpdateLevel;

	private ISubscription<TaskChangeNotifyMessager> subscription_TaskNotify;

	private ISubscription<TempSystemCloseNotify> subscription_SystemCloseNotify;

	private Dictionary<int, bool> serviceState;

	private Dictionary<int, ServerBanTime> serverBanEndTimes;

	private Dictionary<int, SORelateCondition> interestConditions;

	private Timer banTimer;

	public SOService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_UpdateLevel = messenger.Subscribe<RoleExpOrLevelUpNotifyMessager>(GetLevelNotify);
		subscription_TaskNotify = messenger.Subscribe<TaskChangeNotifyMessager>(GetTaskNotify);
		subscription_SystemCloseNotify = messenger.Subscribe<TempSystemCloseNotify>(GetSystemCloseNotify);
	}

	public async UniTask<bool> RequestData()
	{
		serviceState = new Dictionary<int, bool>();
		interestConditions = new Dictionary<int, SORelateCondition>();
		DRSystemOpen[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRSystemOpen>();
		int level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
		for (int i = 0; i < allDataRow.Length; i++)
		{
			if (serviceState.ContainsKey(allDataRow[i].Id))
			{
				Log.Error($"系统开放服务初始化异常，重复的ServiceId{allDataRow[i].Id}");
				continue;
			}
			bool flag = true;
			if (allDataRow[i].OpenList != 0)
			{
				flag = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().MaxCopyOpenIndex >= allDataRow[i].OpenList;
			}
			serviceState.Add(allDataRow[i].Id, (allDataRow[i].OpenLevel <= level) & flag);
			interestConditions.Add(allDataRow[i].Id, new SORelateCondition
			{
				serviceId = allDataRow[i].Id,
				level = allDataRow[i].OpenLevel,
				openIndex = allDataRow[i].OpenList,
				guideId = allDataRow[i].Guidance
			});
		}
		serverBanEndTimes = new Dictionary<int, ServerBanTime>();
		long curTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		C2H_TempSystemCloseRequest rst = C2H_TempSystemCloseRequest.Create();
		H2C_TempSystemCloseResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_TempSystemCloseResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取系统开放数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取系统开放数据"))
			{
				if (response.Closeinfos != null)
				{
					for (int j = 0; j < response.Closeinfos.Count; j++)
					{
						if (response.Closeinfos[j].EndTime > curTime)
						{
							int serviceId = (int)response.Closeinfos[j].SystemId;
							long startTime = response.Closeinfos[j].StartTime;
							long endTime = response.Closeinfos[j].EndTime;
							AddServiceBanState(serviceId, startTime, endTime);
							if (endTime > curTime && startTime <= curTime)
							{
								AddServiceState(serviceId, state: false);
							}
						}
					}
				}
				GetServiceBanTimer();
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

	private void GetSystemCloseNotify(TempSystemCloseNotify notify)
	{
		try
		{
			long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
			if (notify.Closeinfos != null)
			{
				for (int i = 0; i < notify.Closeinfos.Count; i++)
				{
					if (notify.Closeinfos[i].EndTime > curServerTime)
					{
						int serviceId = (int)notify.Closeinfos[i].SystemId;
						long startTime = notify.Closeinfos[i].StartTime;
						long endTime = notify.Closeinfos[i].EndTime;
						AddServiceBanState(serviceId, startTime, endTime);
						if (endTime > curServerTime && startTime <= curServerTime)
						{
							AddServiceState(serviceId, state: false);
						}
					}
				}
			}
			GetServiceBanTimer();
		}
		catch (Exception ex)
		{
			Log.Error("系统开放状态更新发生异常" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private void GetLevelNotify(RoleExpOrLevelUpNotifyMessager messager)
	{
		if (messager.MessageEnum.Equals(RoleExpOrLevelUpNotifyMessager.RoleExpLevelMsgEnum.LevelUp))
		{
			ValidServiceState();
		}
	}

	private void GetTaskNotify(TaskChangeNotifyMessager messager)
	{
		ValidServiceState();
	}

	private void ValidServiceState()
	{
		if (!Singleton<NetworkSystem>.Instance.Connected())
		{
			return;
		}
		int level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
		List<int> list = new List<int>();
		foreach (SORelateCondition value in interestConditions.Values)
		{
			if ((value.level != 0 && value.level <= level) || value.level == 0)
			{
				bool flag = true;
				if (value.openIndex != 0)
				{
					flag = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().MaxCopyOpenIndex >= value.openIndex;
				}
				if (flag && serviceState.ContainsKey(value.serviceId))
				{
					UpdateServiceState(value.serviceId, state: true, value.guideId);
					list.Add(value.serviceId);
				}
			}
		}
		for (int i = 0; i < list.Count; i++)
		{
			interestConditions.Remove(list[i]);
		}
	}

	private void UpdateServiceState(int serviceId, bool state, int guideId)
	{
		if (state && !serviceState.ContainsKey(serviceId))
		{
			return;
		}
		if (state && serviceState.ContainsKey(serviceId))
		{
			if (!serviceState[serviceId])
			{
				serviceState[serviceId] = true;
				messenger.Publish(new SOOpenNotifyMessager(this)
				{
					serviceId = serviceId,
					state = state
				});
				if (guideId != 0)
				{
					Singleton<GuidanceManager>.Instance.RegisterGuidance(guideId);
				}
			}
		}
		else if (!state && !serviceState.ContainsKey(serviceId))
		{
			serviceState.Add(serviceId, state);
		}
		else if (!state && serviceState.ContainsKey(serviceId) && serviceState[serviceId])
		{
			serviceState[serviceId] = false;
			messenger.Publish(new SOOpenNotifyMessager(this)
			{
				serviceId = serviceId,
				state = state
			});
		}
	}

	public async UniTask InitServices()
	{
	}

	public bool GetState(int serviceId)
	{
		if (serviceState != null && serviceState.ContainsKey(serviceId))
		{
			return serviceState[serviceId];
		}
		return true;
	}

	public bool CheckGuideComplete()
	{
		return GetState(70006);
	}

	public bool GetServiceInBanState(int serviceId)
	{
		if (serverBanEndTimes != null && serverBanEndTimes.ContainsKey(serviceId))
		{
			return true;
		}
		return false;
	}

	private void GetServiceBanTimer()
	{
		if (serverBanEndTimes == null || serverBanEndTimes.Count == 0)
		{
			return;
		}
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		long num = -1L;
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		foreach (KeyValuePair<int, ServerBanTime> serverBanEndTime in serverBanEndTimes)
		{
			long num2 = 0L;
			if (curServerTime >= serverBanEndTime.Value.endTime)
			{
				list2.Add(serverBanEndTime.Key);
				continue;
			}
			if (curServerTime > serverBanEndTime.Value.startTime)
			{
				num2 = serverBanEndTime.Value.endTime - curServerTime;
				if (!serviceState.ContainsKey(serverBanEndTime.Key))
				{
					list.Add(serverBanEndTime.Key);
				}
			}
			else
			{
				num2 = serverBanEndTime.Value.startTime - curServerTime;
			}
			if (num2 >= 0)
			{
				num = ((num != -1) ? Math.Min(num, num2) : num2);
			}
		}
		for (int i = 0; i < list2.Count; i++)
		{
			int num3 = list2[i];
			serverBanEndTimes.Remove(num3);
			if (serviceState.ContainsKey(num3))
			{
				serviceState.Remove(num3);
			}
			messenger.Publish(new SOOpenNotifyMessager(this)
			{
				serviceId = num3,
				state = true
			});
		}
		for (int j = 0; j < list.Count; j++)
		{
			int serviceId = list[j];
			AddServiceState(serviceId, state: false);
			messenger.Publish(new SOOpenNotifyMessager(this)
			{
				serviceId = serviceId,
				state = false
			});
		}
		if (num != -1)
		{
			if (banTimer != null)
			{
				Timer.Cancel(banTimer);
				banTimer = null;
			}
			banTimer = Timer.Register(num, delegate
			{
				GetServiceBanTimer();
				Timer.Cancel(banTimer);
				banTimer = null;
			});
		}
	}

	private void AddServiceState(int serviceId, bool state)
	{
		if (serviceState == null)
		{
			serviceState = new Dictionary<int, bool>();
		}
		if (serviceState.ContainsKey(serviceId))
		{
			serviceState[serviceId] = state;
		}
		else
		{
			serviceState.Add(serviceId, state);
		}
	}

	private void AddServiceBanState(int serviceId, ServerBanTime serverBanTime)
	{
		if (serverBanEndTimes == null)
		{
			serverBanEndTimes = new Dictionary<int, ServerBanTime>();
		}
		if (serverBanEndTimes.ContainsKey(serviceId))
		{
			serverBanEndTimes[serviceId] = serverBanTime;
		}
		else
		{
			serverBanEndTimes.Add(serviceId, serverBanTime);
		}
	}

	private void AddServiceBanState(int serviceId, long startTime, long endTime)
	{
		if (serverBanEndTimes == null)
		{
			serverBanEndTimes = new Dictionary<int, ServerBanTime>();
		}
		ServerBanTime serverBanTime = new ServerBanTime
		{
			startTime = startTime,
			endTime = endTime
		};
		AddServiceBanState(serviceId, serverBanTime);
	}

	public void Dispose()
	{
		if (banTimer != null)
		{
			banTimer.Pause();
			banTimer.Cancel();
			banTimer = null;
		}
	}
}
