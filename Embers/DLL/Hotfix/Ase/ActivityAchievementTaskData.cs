#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public class ActivityAchievementTaskData
{
	public int id;

	public string taskDesc;

	public int libType;

	public int sort;

	public int rewardId;

	public int progress;

	public int requireValue;

	public bool isCompleted;

	public bool isClaimed;

	public bool red;

	public ActivityAchievementTaskData(DRLibTask cfs)
	{
		if (cfs == null)
		{
			Log.Error("初始化失败，DRLibTask为空！");
			return;
		}
		id = cfs.Id;
		taskDesc = cfs.TaskDesc;
		libType = cfs.LibType;
		sort = cfs.Sort;
		rewardId = cfs.RewardId;
		progress = 0;
		requireValue = cfs.RequireValue;
		isCompleted = false;
		isClaimed = false;
		red = false;
	}

	public void UpdateByPb(PbBuffLibraryTaskInfo info)
	{
		if (info != null)
		{
			progress = info.Progress;
			requireValue = ((info.RequireValue > 0) ? info.RequireValue : requireValue);
			isCompleted = info.IsCompleted;
			isClaimed = info.IsClaimed;
			red = (isCompleted ? true : false);
		}
	}
}
