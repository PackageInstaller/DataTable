#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public static class OpActivityDefinition
{
	public static int GetActivityMainShopId()
	{
		return GameEntry.DataTable.GetDataRow((DRMainShopList p) => p.ShopPosition == 5)?.Id ?? 0;
	}

	public static bool IsUnderWay(this ActivityViewModelBase activity)
	{
		if (activity != null)
		{
			return activity.State == OpActivityState.On;
		}
		return false;
	}

	public static bool DisplayInActWindow(this ActivityViewModelBase activity)
	{
		if (activity != null)
		{
			return !string.IsNullOrEmpty(activity.UiViewName);
		}
		return false;
	}

	private static bool CheckCondition(int conditionType, int conditionValue)
	{
		switch (conditionType)
		{
		case 1:
			return (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.PlayerInfo?.Level).GetValueOrDefault() >= conditionValue;
		case 2:
			return (Singleton<ServiceSystem>.Instance.GetService<ITaskServices>()?.GetCurrentCopyOpen() ?? 0) > conditionValue;
		case 3:
			return Singleton<ServiceSystem>.Instance.GetService<ISOService>()?.GetState(conditionValue) ?? false;
		case 4:
			return (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetAccountCreateDay()).GetValueOrDefault() > conditionValue;
		case 5:
			return (Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.GetActivityViewModel(conditionValue))?.CheckAllTaskFinished() ?? false;
		case 6:
		{
			ShopExcData obj2 = Singleton<ServiceSystem>.Instance.GetService<IShopService>()?.GetData()?.GetGoods(conditionValue);
			return obj2?.LeftExc < obj2?.QuotaNum;
		}
		case 7:
			return (Singleton<ServiceSystem>.Instance.GetService<IShopService>()?.GetMonthlyCardLeftDay() ?? (-1)) >= 0;
		case 8:
		{
			PassportInfo obj = Singleton<ServiceSystem>.Instance.GetService<IPassportService>()?.GetPassportInfo();
			if (obj == null)
			{
				return false;
			}
			return obj.Grade >= 2;
		}
		case 9:
			return true;
		default:
			return false;
		}
	}

	public static OpActivityLockState GetActivityLockState(int conditionType, int conditionValue)
	{
		if (conditionType != 0 && !CheckCondition(conditionType, conditionValue))
		{
			return OpActivityLockState.Locked;
		}
		return OpActivityLockState.Unlock;
	}

	public static OpActivityState GetState(List<int> startCon, List<int> startConValue, int endCon, int endConValue)
	{
		bool flag = true;
		if (startCon != null && startConValue != null)
		{
			for (int i = 0; i < startCon.Count; i++)
			{
				int conditionValue = ((startConValue.Count > i) ? startConValue[i] : 0);
				flag = flag && (startCon[i] == 0 || CheckCondition(startCon[i], conditionValue));
			}
		}
		bool flag2 = endCon != 0 && CheckCondition(endCon, endConValue);
		if (!flag || flag2)
		{
			return OpActivityState.Off;
		}
		return OpActivityState.On;
	}

	public static bool CheckCondition2(int conditionType, string conditionValue)
	{
		switch (conditionType)
		{
		case 1:
		{
			string format = "yyyy/MM/dd HH:mm:ss";
			if (TimeHelper.StringToDateTime(conditionValue + " " + TimeService.GetDailyUpdateTimeStr(), format, out var time))
			{
				DateTime curServerDateTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerDateTime();
				return DateTime.Compare(time, curServerDateTime) <= 0;
			}
			return false;
		}
		case 2:
		{
			if (int.TryParse(conditionValue, out var result2))
			{
				return PropHelper.CheckPropEnough(result2, 1);
			}
			return false;
		}
		case 3:
		{
			if (int.TryParse(conditionValue, out var result))
			{
				return Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetActivityViewModel(result)?.CheckAllTaskFinished() ?? false;
			}
			return false;
		}
		default:
			return false;
		}
	}

	public static long GetActivityTime(DRActivityType drActivityType)
	{
		if (drActivityType == null)
		{
			return -1L;
		}
		if (drActivityType.EndCondition == 4)
		{
			ITimeService service = Singleton<ServiceSystem>.Instance.GetService<ITimeService>();
			if (service == null)
			{
				return -1L;
			}
			long valueOrDefault = (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.AccountCreateTime).GetValueOrDefault();
			long curServerTime = service.GetCurServerTime();
			if (valueOrDefault <= 0)
			{
				return -1L;
			}
			DateTime localDateTime = TimeHelper.GetLocalDateTime(valueOrDefault);
			int dailyUpdateHour = service.GetDailyUpdateHour();
			int num = ((localDateTime.Hour >= dailyUpdateHour) ? drActivityType.EndConditionValue : (drActivityType.EndConditionValue - 1));
			DateTime dateTime = localDateTime.AddDays(num);
			DateTime dateTime2 = new DateTime(dateTime.Year, dateTime.Month, dateTime.Day, dailyUpdateHour, 0, 0);
			DateTime localDateTime2 = TimeHelper.GetLocalDateTime(curServerTime);
			return (long)(dateTime2 - localDateTime2).TotalSeconds;
		}
		if (drActivityType.TimeLimit <= 0)
		{
			return -1L;
		}
		DRTimeLimit dataRow = GameEntry.DataTable.GetDataRow<DRTimeLimit>(drActivityType.TimeLimit);
		if (dataRow == null)
		{
			return -1L;
		}
		return GetActivityTimeByTimeLimit(dataRow.StartTime, dataRow.EndTime, dataRow.OffTime);
	}

	private static long GetActivityTimeByTimeLimit(string startTime, string endTime, string offTime)
	{
		string format = "yyyy.MM.dd HH:mm:ss";
		if (!string.IsNullOrEmpty(startTime) && !string.IsNullOrEmpty(endTime) && !string.IsNullOrEmpty(offTime) && TimeHelper.StringToDateTime(startTime + " 04:00:00", format, out var time) && TimeHelper.StringToDateTime(endTime + " 04:00:00", format, out var time2) && TimeHelper.StringToDateTime(offTime + " 04:00:00", format, out var time3))
		{
			if (DateTime.Compare(time, time2) >= 0 || DateTime.Compare(time2, time3) > 0)
			{
				return -1L;
			}
			long num = Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.GetCurServerTime() ?? 0;
			if (num <= 0)
			{
				return -1L;
			}
			DateTime localDateTime = TimeHelper.GetLocalDateTime(num);
			long num2 = (long)(time2 - localDateTime).TotalSeconds;
			if (num2 <= 0)
			{
				return 0L;
			}
			return num2;
		}
		return -1L;
	}

	public static string GetActivityTimeText(long leftTimeSecond, int maxDay = 0)
	{
		if (leftTimeSecond == 0L)
		{
			return "已结束";
		}
		if (leftTimeSecond < 0)
		{
			return "";
		}
		return Utility.DateTime.GetActivityLeftTime(leftTimeSecond, maxDay);
	}

	public static ActivityViewModelBase CreateActivityViewModel(int activityTypeId, OpActViewModel dataParent, List<ActivityTaskData> taskDataList, bool refreshState)
	{
		try
		{
			DRActivityType dataRow = GameEntry.DataTable.GetDataRow<DRActivityType>(activityTypeId);
			if (dataRow == null)
			{
				Log.Error($"ActivityType表：找不到id为：{activityTypeId}的配置");
				return null;
			}
			if (string.IsNullOrEmpty(dataRow.ViewModelName))
			{
				Log.Error($"ActivityType表：Id:{dataRow.Id}的ViewModelName为空");
				return null;
			}
			Type type = Type.GetType("Ase." + dataRow.ViewModelName);
			if (type == null)
			{
				Log.Error("Type.GetType返回空：Ase." + dataRow.ViewModelName);
				return null;
			}
			ActivityViewModelBase activityViewModelBase = (ActivityViewModelBase)Activator.CreateInstance(type);
			activityViewModelBase.Init(dataParent, dataRow);
			activityViewModelBase.SetServiceTaskData(taskDataList);
			if (refreshState)
			{
				activityViewModelBase.RefreshState();
				activityViewModelBase.RefreshTabType();
				activityViewModelBase.RefreshFinishState();
			}
			return activityViewModelBase;
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		return null;
	}
}
