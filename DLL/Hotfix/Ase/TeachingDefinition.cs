using System.Collections.Generic;

namespace Ase;

public class TeachingDefinition
{
	public enum TeachingType
	{
		All,
		Combat,
		Level,
		System
	}

	public static bool GetTeachingPointOpenState(DRManual drManual)
	{
		if (drManual == null)
		{
			return false;
		}
		if (drManual.Release == 0)
		{
			return true;
		}
		if (drManual.Release == 1)
		{
			IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
			if (service?.GetRoleData() == null || service.GetRoleData().PlayerInfo == null)
			{
				return false;
			}
			return service.GetRoleData().PlayerInfo.Level >= drManual.ReleaseConfig;
		}
		if (drManual.Release == 2)
		{
			return (Singleton<ServiceSystem>.Instance.GetService<ITaskServices>()?.GetAllUnFinishedTask() ?? new List<TaskDataViewModel>()).Exists((TaskDataViewModel p) => p.TaskId == drManual.ReleaseConfig);
		}
		if (drManual.Release == 3)
		{
			return Singleton<ServiceSystem>.Instance.GetService<ISOService>()?.GetState(drManual.ReleaseConfig) ?? false;
		}
		if (drManual.Release == 4)
		{
			return Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetManualOpenState(drManual.Index) ?? false;
		}
		if (drManual.Release == 5)
		{
			return Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetManualOpenState(drManual.Index) ?? false;
		}
		return false;
	}

	public static bool GetManualRewardState(int index)
	{
		return Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetManualRewardState(index) ?? false;
	}

	public static bool GetManualTypeRedState(TeachingType type)
	{
		DRManual[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRManual>();
		if (allDataRow != null)
		{
			DRManual[] array = allDataRow;
			foreach (DRManual dRManual in array)
			{
				if (GetTeachingPointOpenState(dRManual) && (type == TeachingType.All || dRManual.Type == (int)type) && !GetManualRewardState(dRManual.Index))
				{
					return true;
				}
			}
		}
		return false;
	}
}
