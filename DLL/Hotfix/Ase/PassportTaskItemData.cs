using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class PassportTaskItemData : OptionBase
{
	private int finishCount;

	private int totalCount;

	private string taskName;

	private int taskId;

	private int rewardItemCount;

	private int type;

	private string jumpWindow;

	private List<int> jumpFlagValueList;

	private PassportTaskState passportTaskState;

	private InteractionRequest playCompleteEffectRequest;

	public bool canOnClick = true;

	public int FinishCount
	{
		get
		{
			return finishCount;
		}
		set
		{
			Set(ref finishCount, value, "FinishCount");
		}
	}

	public int TotalCount
	{
		get
		{
			return totalCount;
		}
		set
		{
			Set(ref totalCount, value, "TotalCount");
		}
	}

	public string TaskName
	{
		get
		{
			return taskName;
		}
		set
		{
			Set(ref taskName, value, "TaskName");
		}
	}

	public int RewardItemCount
	{
		get
		{
			return rewardItemCount;
		}
		set
		{
			Set(ref rewardItemCount, value, "RewardItemCount");
		}
	}

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

	public int Type
	{
		get
		{
			return type;
		}
		set
		{
			Set(ref type, value, "Type");
		}
	}

	public string JumpWindow => jumpWindow;

	public List<int> JumpFlagValueList => jumpFlagValueList;

	public PassportTaskState PassportTaskState
	{
		get
		{
			return passportTaskState;
		}
		set
		{
			Set(ref passportTaskState, value, "PassportTaskState");
		}
	}

	public InteractionRequest PlayCompleteEffectRequest => playCompleteEffectRequest;

	public PassportTaskItemData(OptionBase parent, DRPassportTask drPassportTask, int finishCount, bool isComplete)
	{
		base.parent = parent;
		this.finishCount = finishCount;
		totalCount = drPassportTask.TargetValue;
		taskId = drPassportTask.Id;
		type = drPassportTask.TaskType;
		taskName = drPassportTask.TargetDesc;
		rewardItemCount = drPassportTask.EXP;
		jumpWindow = drPassportTask.TargetWindow;
		jumpFlagValueList = new List<int> { drPassportTask.WindowParams };
		playCompleteEffectRequest = new InteractionRequest();
		passportTaskState = ((!jumpWindow.Equals("")) ? PassportTaskState.Jump : PassportTaskState.Normal);
		if (finishCount >= totalCount)
		{
			passportTaskState = PassportTaskState.Reward;
		}
		if (isComplete)
		{
			passportTaskState = PassportTaskState.Finish;
		}
	}

	public void SetFinishCount(int finishCount, bool finish)
	{
		PassportTaskState = ((!jumpWindow.Equals("")) ? PassportTaskState.Jump : PassportTaskState.Normal);
		FinishCount = finishCount;
		if (finishCount >= totalCount)
		{
			PassportTaskState = PassportTaskState.Reward;
		}
		if (finish)
		{
			PassportTaskState = PassportTaskState.Finish;
		}
	}

	public async void PlayCompleteEffect()
	{
		playCompleteEffectRequest.Raise();
		await Task.Delay(600);
		PassportTaskState = PassportTaskState.Finish;
	}

	public void Jump()
	{
		if (canOnClick)
		{
			canOnClick = false;
			parent?.ItemOnClick(this);
		}
	}

	public void GetReward()
	{
		parent?.ItemOnClick(new OptionArg(this, "Received"));
	}
}
