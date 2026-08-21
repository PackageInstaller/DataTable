using GameFramework.Runtime;

namespace Ase;

public class GuildTaskData : ViewModelBase
{
	private int taskId;

	private int quality;

	private GuildTaskConditionType conditionType;

	private int requireId;

	private int curValue;

	private int targetValue;

	private string desc;

	private int activePointReward;

	private GuildTaskState state = GuildTaskState.UnFinished;

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

	public int Quality
	{
		get
		{
			return quality;
		}
		set
		{
			Set(ref quality, value, "Quality");
		}
	}

	public GuildTaskConditionType ConditionType
	{
		get
		{
			return conditionType;
		}
		set
		{
			Set(ref conditionType, value, "ConditionType");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public int ActivePointReward
	{
		get
		{
			return activePointReward;
		}
		set
		{
			Set(ref activePointReward, value, "ActivePointReward");
		}
	}

	public GuildTaskState State
	{
		get
		{
			return state;
		}
		set
		{
			Set(ref state, value, "State");
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

	public int CurValue
	{
		get
		{
			return curValue;
		}
		set
		{
			Set(ref curValue, value, "CurValue");
		}
	}

	public int TargetValue
	{
		get
		{
			return targetValue;
		}
		set
		{
			Set(ref targetValue, value, "TargetValue");
		}
	}

	public GuildTaskData()
	{
	}

	public GuildTaskData(DRGuildActiveTask drData, PbState pbState)
	{
		TaskId = drData.Id;
		Quality = drData.TaskQuality;
		ConditionType = (GuildTaskConditionType)drData.Condition;
		RequireId = drData.RequireId;
		TargetValue = drData.TargetValue;
		Desc = drData.TaskDesc;
		ActivePointReward = drData.ActiveReward;
		UpdateProgress(pbState);
	}

	public bool UpdateProgress(PbState pbState = null)
	{
		GuildTaskState guildTaskState = State;
		int num = CurValue;
		IKnapsackService service = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>();
		if (service != null && ConditionType == GuildTaskConditionType.ItemCollection)
		{
			num = service.GetKnapsackViewModel().GetProp(RequireId)?.Amount ?? 0;
		}
		else if (pbState != null)
		{
			num = pbState.Value;
		}
		if (pbState != null && pbState.State > 0)
		{
			guildTaskState = GuildTaskState.Finished;
		}
		else if (guildTaskState != GuildTaskState.Finished)
		{
			guildTaskState = ((num < TargetValue) ? GuildTaskState.UnFinished : GuildTaskState.CanFinish);
		}
		bool result = State != guildTaskState || CurValue != num;
		State = guildTaskState;
		CurValue = num;
		return result;
	}

	public bool UpdateProgress(int value)
	{
		if (State == GuildTaskState.Finished)
		{
			return false;
		}
		bool num = CurValue != value;
		CurValue = value;
		if (num)
		{
			State = ((CurValue < TargetValue) ? GuildTaskState.UnFinished : GuildTaskState.CanFinish);
		}
		return num;
	}
}
