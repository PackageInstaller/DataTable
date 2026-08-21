using System.Collections.Generic;
using Cysharp.Text;
using GameFramework.Runtime;

namespace Ase;

public class CopyPermitData : ViewModelBase
{
	private bool isComplete;

	private string desc;

	private int id;

	private int taskType;

	private List<int> taskTarget;

	private int targetVal;

	private int curProgress;

	public bool IsComplete
	{
		get
		{
			return isComplete;
		}
		private set
		{
			Set(ref isComplete, value, "IsComplete");
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

	public int TaskType
	{
		get
		{
			return taskType;
		}
		private set
		{
			Set(ref taskType, value, "TaskType");
		}
	}

	public List<int> TaskTarget => taskTarget;

	public int TargetVal
	{
		get
		{
			return targetVal;
		}
		private set
		{
			Set(ref targetVal, value, "TargetVal");
		}
	}

	public int CurProgress
	{
		get
		{
			return curProgress;
		}
		private set
		{
			Set(ref curProgress, value, "CurProgress");
		}
	}

	public int Id => id;

	public static CopyPermitData Create(DRPermitTask task, int curVal)
	{
		CopyPermitData copyPermitData = new CopyPermitData();
		copyPermitData.id = task.Id;
		if (!string.IsNullOrEmpty(task.TaskDesc) && task.TaskDesc.Contains("\\n"))
		{
			using Utf16ValueStringBuilder utf16ValueStringBuilder = ZString.CreateStringBuilder();
			utf16ValueStringBuilder.Append(task.TaskDesc);
			utf16ValueStringBuilder.Replace("\\n", "\n");
			copyPermitData.desc = utf16ValueStringBuilder.ToString();
		}
		else
		{
			copyPermitData.desc = task.TaskDesc;
		}
		copyPermitData.taskType = task.TaskType;
		copyPermitData.taskTarget = task.TaskTarget;
		copyPermitData.targetVal = task.TargetValue;
		copyPermitData.curProgress = curVal;
		copyPermitData.isComplete = copyPermitData.curProgress >= task.TargetValue;
		return copyPermitData;
	}

	public void UpdateProgress(int curLevel)
	{
		CurProgress = curLevel;
		IsComplete = curProgress >= targetVal;
	}
}
