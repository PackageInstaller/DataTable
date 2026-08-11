#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class CampaignTaskData : CampaignAreaData
{
	private CampaignTaskType _taskType;

	private string _finishedIcon = "";

	private bool _finished;

	private List<string> _labels;

	private string _info;

	private List<int> _envBuff;

	private PropDataBase _consume;

	private List<PropDataBase> _rewards;

	public CampaignTaskType TaskType
	{
		get
		{
			return _taskType;
		}
		set
		{
			Set(ref _taskType, value, "TaskType");
		}
	}

	public string FinishedIcon
	{
		get
		{
			return _finishedIcon;
		}
		set
		{
			Set(ref _finishedIcon, value, "FinishedIcon");
		}
	}

	public bool Finished
	{
		get
		{
			return _finished;
		}
		set
		{
			Set(ref _finished, value, "Finished");
		}
	}

	public List<string> Labels
	{
		get
		{
			return _labels;
		}
		set
		{
			Set(ref _labels, value, "Labels");
		}
	}

	public string Info
	{
		get
		{
			return _info;
		}
		set
		{
			Set(ref _info, value, "Info");
		}
	}

	public List<int> EnvBuff
	{
		get
		{
			return _envBuff;
		}
		set
		{
			Set(ref _envBuff, value, "EnvBuff");
		}
	}

	public PropDataBase Consume
	{
		get
		{
			return _consume;
		}
		set
		{
			Set(ref _consume, value, "Consume");
		}
	}

	public List<PropDataBase> Rewards
	{
		get
		{
			return _rewards;
		}
		set
		{
			Set(ref _rewards, value, "Rewards");
		}
	}

	public static CampaignTaskData CreateByServerData(OptionBase parent, CampaignServiceData.DailyTaskInfo dailyTaskInfo)
	{
		if (dailyTaskInfo == null)
		{
			return null;
		}
		DRCampaignLevel dataRow = GameEntry.DataTable.GetDataRow<DRCampaignLevel>(dailyTaskInfo.PlayId);
		if (dataRow == null)
		{
			Log.Error($"创建战役任务数据失败：CampaignLevel表 Id:{dailyTaskInfo.PlayId}不存在");
			return null;
		}
		DRCampaignClass dataRow2 = GameEntry.DataTable.GetDataRow<DRCampaignClass>(dailyTaskInfo.PointId);
		if (dataRow2 == null)
		{
			Log.Error($"创建战役任务数据失败：CampaignClass表 Id:{dailyTaskInfo.PointId}不存在");
			return null;
		}
		DRCopy dataRow3 = GameEntry.DataTable.GetDataRow<DRCopy>(dataRow.CopyId);
		if (dataRow3 == null)
		{
			Log.Error($"创建战役任务数据失败：Copy表 Id:{dataRow.CopyId}不存在");
			return null;
		}
		return new CampaignTaskData(parent)
		{
			Type = CampaignAreaType.Task,
			PositionId = dailyTaskInfo.PointId,
			Name = dataRow.Name,
			Icon = dataRow.Icon,
			IconSize = dataRow.IconSize,
			ClickRange = dataRow2.ActRange,
			TaskType = GetTaskType(dataRow.Type),
			Finished = dailyTaskInfo.IsCompleted,
			Labels = dataRow.Label,
			Info = dataRow.InfoText,
			CopyId = dataRow.CopyId,
			EnvBuff = dataRow.EnviBuff,
			PlayId = dataRow.Id,
			Consume = PropDataBase.CreateByType(dataRow3.CostType, dataRow3.CostId, dataRow3.CostNum),
			Rewards = PropHelper.AnalyzePropListByConfig(dataRow.DropDescType, dataRow.DropDescId, dataRow.DropDescNum)
		};
	}

	public static CampaignTaskType GetTaskType(int type)
	{
		return type switch
		{
			10 => CampaignTaskType.Eliminate, 
			11 => CampaignTaskType.Survival, 
			12 => CampaignTaskType.LimitTimeEliminate, 
			13 => CampaignTaskType.Roguelike, 
			_ => CampaignTaskType.None, 
		};
	}

	public CampaignTaskData()
	{
	}

	public CampaignTaskData(OptionBase parent)
		: base(parent)
	{
	}
}
