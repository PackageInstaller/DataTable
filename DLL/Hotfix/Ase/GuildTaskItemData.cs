namespace Ase;

public class GuildTaskItemData : OptionBase
{
	private int taskId;

	private GuildTaskState taskState;

	private string taskDesc;

	private string detailDesc;

	private int taskQuality;

	private int totalProgress;

	private int curProgress;

	private int activePoint;

	private int requireId;

	private GuildTaskConditionType taskConditionType;

	private string btnText;

	private string btnEnglishText;

	private bool showDetailBtn;

	public int TaskId
	{
		get
		{
			return taskId;
		}
		set
		{
			Set(ref taskId, value, "TaskId");
		}
	}

	public GuildTaskState TaskState
	{
		get
		{
			return taskState;
		}
		set
		{
			Set(ref taskState, value, "TaskState");
		}
	}

	public string TaskDesc
	{
		get
		{
			return taskDesc;
		}
		set
		{
			Set(ref taskDesc, value, "TaskDesc");
		}
	}

	public string DetailDesc
	{
		get
		{
			return detailDesc;
		}
		set
		{
			Set(ref detailDesc, value, "DetailDesc");
		}
	}

	public int TaskQuality
	{
		get
		{
			return taskQuality;
		}
		set
		{
			Set(ref taskQuality, value, "TaskQuality");
		}
	}

	public int TotalProgress
	{
		get
		{
			return totalProgress;
		}
		set
		{
			Set(ref totalProgress, value, "TotalProgress");
		}
	}

	public int CurProgress
	{
		get
		{
			return curProgress;
		}
		set
		{
			Set(ref curProgress, value, "CurProgress");
		}
	}

	public int ActivePoint
	{
		get
		{
			return activePoint;
		}
		set
		{
			Set(ref activePoint, value, "ActivePoint");
		}
	}

	public int RequireId
	{
		get
		{
			return requireId;
		}
		set
		{
			Set(ref requireId, value, "RequireId");
		}
	}

	public string BtnText
	{
		get
		{
			return btnText;
		}
		set
		{
			Set(ref btnText, value, "BtnText");
		}
	}

	public string BtnEnglishText
	{
		get
		{
			return btnEnglishText;
		}
		set
		{
			Set(ref btnEnglishText, value, "BtnEnglishText");
		}
	}

	public bool ShowDetailBtn
	{
		get
		{
			return showDetailBtn;
		}
		set
		{
			Set(ref showDetailBtn, value, "ShowDetailBtn");
		}
	}

	public GuildTaskItemData()
	{
	}

	public GuildTaskItemData(OptionBase parent, GuildTaskData taskData)
	{
		base.parent = parent;
		TaskId = taskData.TaskId;
		TaskState = taskData.State;
		TaskDesc = taskData.Desc;
		TaskQuality = taskData.Quality;
		CurProgress = taskData.CurValue;
		TotalProgress = taskData.TargetValue;
		ActivePoint = taskData.ActivePointReward;
		RequireId = taskData.RequireId;
		taskConditionType = taskData.ConditionType;
		if (taskConditionType == GuildTaskConditionType.ItemCollection)
		{
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(taskData.RequireId);
			if (dataRow != null)
			{
				ShowDetailBtn = true;
				DetailDesc = "（" + dataRow.Name;
			}
		}
		RefreshItemState();
	}

	private void RefreshItemState()
	{
		MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
		int myDailyActivePoint = myGuildData.MyDailyActivePoint;
		int dailyMaxActivePoint = myGuildData.GetDailyMaxActivePoint();
		if (TaskState == GuildTaskState.Finished)
		{
			BtnText = "已完成";
			BtnEnglishText = "Completed";
		}
		else if (myDailyActivePoint >= dailyMaxActivePoint)
		{
			TaskState = GuildTaskState.FullActive;
			BtnText = "活跃已满";
			BtnEnglishText = "Full active";
		}
		else if (TaskState == GuildTaskState.UnFinished)
		{
			BtnText = "未完成";
			BtnEnglishText = "UnFinished";
		}
		else if (TaskState == GuildTaskState.CanFinish)
		{
			BtnText = "完成";
			BtnEnglishText = "Claim";
		}
	}

	public void OnFinishBtnClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "FinishTask"));
	}

	public void OnDetailBtnClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "OpenPropInfo"));
	}
}
