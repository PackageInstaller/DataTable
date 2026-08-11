#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class TaskMainDetailViewModel : OptionBase
{
	private bool lockFlag;

	private string desc;

	private string locationName1;

	private string locationName2;

	private string lockText = "";

	private string timeLockText = "";

	private string occupyText = "";

	private List<TaskMainProgressItemViewModel> targetTextList;

	private TaskMainItemViewModel data;

	private List<KnapsackItemViewModel> rewardList;

	private InteractionRequest updateTaskInfoRequest;

	public TaskMainItemViewModel Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public string LockText
	{
		get
		{
			return lockText;
		}
		private set
		{
			Set(ref lockText, value, "LockText");
		}
	}

	public string TimeLockText
	{
		get
		{
			return timeLockText;
		}
		private set
		{
			Set(ref timeLockText, value, "TimeLockText");
		}
	}

	public string OccupyText
	{
		get
		{
			return occupyText;
		}
		private set
		{
			Set(ref occupyText, value, "OccupyText");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public string LocationName1
	{
		get
		{
			return locationName1;
		}
		private set
		{
			Set(ref locationName1, value, "LocationName1");
		}
	}

	public string LocationName2
	{
		get
		{
			return locationName2;
		}
		private set
		{
			Set(ref locationName2, value, "LocationName2");
		}
	}

	public List<KnapsackItemViewModel> RewardList => rewardList;

	public List<TaskMainProgressItemViewModel> TargetTextList => targetTextList;

	public IInteractionRequest UpdateTaskInfoRequest => updateTaskInfoRequest;

	public override void ItemOnClick(object obj)
	{
		parent.ItemOnClick(obj);
	}

	public TaskMainDetailViewModel()
	{
	}

	public TaskMainDetailViewModel(OptionBase parent)
	{
		base.parent = parent;
		updateTaskInfoRequest = new InteractionRequest();
		rewardList = new List<KnapsackItemViewModel>();
		targetTextList = new List<TaskMainProgressItemViewModel>();
	}

	public void RefreshData(TaskMainItemViewModel data)
	{
		Data = data;
		Desc = data.GetDesc();
		DRMap dataRow = GameEntry.DataTable.GetDataRow<DRMap>(data.GetMapDataLevel());
		if (dataRow == null)
		{
			Toast.ShowError($"找不到任务地图{data.GetMapDataLevel()}配置，请检查配置表！");
			LocationName2 = "未知区域";
			LocationName1 = "";
		}
		else
		{
			LocationName2 = dataRow.Name;
			DRSectionMap dataRow2 = GameEntry.DataTable.GetDataRow<DRSectionMap>(dataRow.MapId);
			if (dataRow2 == null)
			{
				Toast.ShowError($"SectionMap找不到任务地图{dataRow.MapId}配置，请检查配置表！");
				LocationName1 = "未知区域";
			}
			else
			{
				LocationName1 = dataRow2.Name;
			}
		}
		targetTextList.Clear();
		if (data.TimeLockState == 1)
		{
			TimeLockText = data.timeLockDesc;
			lockFlag = true;
		}
		if (data.TaskState == 0)
		{
			for (int i = 0; i < data.ChildTaskList.Count; i++)
			{
				if (data.ChildTaskList[i].TaskState != 0)
				{
					continue;
				}
				if (this.data.GetParallelTaskType() == 1)
				{
					if (data.ChildTaskList[i].IsChildTask())
					{
						continue;
					}
				}
				else if (this.data.GetParallelTaskType() == 2 && !data.ChildTaskList[i].IsChildTask())
				{
					continue;
				}
				TaskMainProgressItemViewModel taskMainProgressItemViewModel = new TaskMainProgressItemViewModel(this);
				taskMainProgressItemViewModel.taskId = data.ChildTaskList[i].TaskId;
				taskMainProgressItemViewModel.isFinish = data.ChildTaskList[i].IsFinish;
				if (data.ChildTaskList[i].GetParallelTaskType() == 0 || this.data.GetParallelTaskType() == 4)
				{
					taskMainProgressItemViewModel.text = data.ChildTaskList[i].GetTargetDesc() ?? "";
				}
				else
				{
					taskMainProgressItemViewModel.text = $"{data.ChildTaskList[i].GetTargetDesc()}({data.ChildTaskList[i].Progress}/{data.ChildTaskList[i].GetTargetValue()})";
				}
				targetTextList.Add(taskMainProgressItemViewModel);
			}
		}
		else if (data.TaskState == 1)
		{
			try
			{
				List<int> previousCondition = data.GetPreviousCondition();
				if (previousCondition != null)
				{
					for (int j = 0; j < previousCondition.Count; j++)
					{
						if (previousCondition[j] == 2)
						{
							LockText = data.GetPreviousDesc() ?? "";
							break;
						}
					}
				}
			}
			catch (Exception)
			{
				Toast.ShowError("任务前置条件，等级参数配置异常，请检查！");
			}
		}
		else if (data.TaskState == 2)
		{
			occupyText = "";
			foreach (string value in data.BeOccupiedLoctions.Values)
			{
				OccupyText = OccupyText + "【" + value + "】\n";
			}
		}
		rewardList.Clear();
		if (data.ChildTaskList.Count > 1)
		{
			SetReward(data.ChildTaskList[0].GetRewardId(), data.ChildTaskList[0].GetRewardType(), data.ChildTaskList[0].GetRewardQuantity());
		}
		else
		{
			SetReward(data.GetRewardId(), data.GetRewardType(), data.GetRewardQuantity());
		}
		updateTaskInfoRequest.Raise();
	}

	public void OnTimerUpdate()
	{
		if (lockFlag && !(LockText == data.timeLockDesc))
		{
			if (data.timeLockDesc != null && data.isTimeLock)
			{
				LockText = data.timeLockDesc;
				return;
			}
			lockFlag = false;
			data.TimeLockState = 0;
			RefreshData(data);
		}
	}

	public void SetReward(List<int> ids, List<int> types, List<int> counts)
	{
		try
		{
			for (int i = 0; i < types.Count; i++)
			{
				PropDataBase propDataBase = PropDataBase.CreateByType(types[i], ids[i], counts[i]);
				if (propDataBase == null)
				{
					Toast.ShowError($"任务表，奖励配置，Id为【{ids[i]}】,类型为{types[i]}的道具不存在，请检查！");
				}
				else
				{
					rewardList.Add(new KnapsackItemViewModel(this, propDataBase));
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error($"任务奖励配置异常，请检查! 任务Id：{Data.TaskId} {ex.Message}/{ex.StackTrace}");
			Toast.ShowError($"任务奖励配置异常，请检查! 任务Id：{Data.TaskId}");
		}
	}

	public void ShowImg()
	{
		parent.ItemOnClick(new OptionArg(this, "ShowImg"));
	}
}
