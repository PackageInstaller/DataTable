using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GameActivityItemData : OptionBase
{
	private int taskId;

	private int taskState;

	private string stateText;

	private string iconPath;

	private int rewardCount;

	private string taskName;

	private string completeText;

	private int realCount;

	private int maxCount;

	private int taskType;

	private PropData propData;

	private string jumpWindow;

	private List<int> jumpFlagValueList;

	private bool receive;

	private SimpleCommand onClickCmd;

	public int TaskState
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

	public string StateText
	{
		get
		{
			return stateText;
		}
		set
		{
			Set(ref stateText, value, "StateText");
		}
	}

	public string CompleteText
	{
		get
		{
			return completeText;
		}
		set
		{
			Set(ref completeText, value, "CompleteText");
		}
	}

	public int RealCount => realCount;

	public int TaskId => taskId;

	public int RewardCount => rewardCount;

	public string TaskName => taskName;

	public int TaskType => taskType;

	public string IconPath => iconPath;

	public SimpleCommand OnClickCmd => onClickCmd;

	public string JumpWindow => jumpWindow;

	public List<int> JumpFlagValueList => jumpFlagValueList;

	public GameActivityItemData(OptionBase parent, int taskId, int rewardId, int rewardCount, string taskName, int maxCount, int taskType, string jumpWindow = "", List<int> jumpFlagValueList = null)
	{
		base.parent = parent;
		this.taskId = taskId;
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(rewardId);
		if (dataRow != null)
		{
			propData = new PropData(dataRow);
			iconPath = dataRow.Icon;
		}
		this.rewardCount = rewardCount;
		this.taskName = taskName;
		this.maxCount = maxCount;
		this.taskType = taskType;
		this.jumpWindow = jumpWindow;
		this.jumpFlagValueList = jumpFlagValueList;
		onClickCmd = new SimpleCommand(OnClick);
	}

	public void SetRealData(int realCount, bool receive)
	{
		this.realCount = ((realCount >= maxCount) ? maxCount : realCount);
		CompleteText = $"{this.realCount}/{maxCount}";
		this.receive = receive;
		CheckState();
	}

	private void CheckState()
	{
		int num = ((!jumpWindow.Equals("")) ? 1 : 2);
		if (realCount >= maxCount)
		{
			num = 3;
		}
		if (receive)
		{
			num = 0;
		}
		if (TaskState != num)
		{
			TaskState = num;
		}
		switch (TaskState)
		{
		case 0:
			StateText = "<color=#a18770>已完成</color>";
			break;
		case 1:
			StateText = "<color=#e3a863>前往</color>";
			break;
		case 2:
			StateText = "<color=#a18770>进行中</color>";
			break;
		case 3:
			StateText = "<color=#e3a863>完成</color>";
			break;
		}
	}

	private void OnClick()
	{
		onClickCmd.Enabled = false;
		if (TaskState == 1)
		{
			parent?.ItemOnClick(new OptionArg(this, "Jump"));
		}
		else if (taskState == 3)
		{
			parent?.ItemOnClick(new OptionArg(this, "Receive"));
		}
	}

	public void SetBtnOnclick(bool value)
	{
		onClickCmd.Enabled = value;
	}

	public async void SetFinishState()
	{
		TaskState = 0;
		StateText = "<color=#a18770>已完成</color>";
	}

	public void OpenProp()
	{
		PropWindowViewModel propWindowViewModel = new PropWindowViewModel(this);
		propWindowViewModel.RefreshData(propData);
		OpenViewArg obj = new OpenViewArg(typeof(PropPopupWindow), propWindowViewModel);
		parent.ItemOnClick(obj);
	}
}
