namespace Ase;

public class ActivityTaskData : OptionBase
{
	private int _id;

	private long _completeValue;

	private int _rewardState;

	private int _completeState;

	private int _targetValue;

	private int _groupId;

	public int Id
	{
		get
		{
			return _id;
		}
		set
		{
			Set(ref _id, value, "Id");
		}
	}

	public long CompleteValue
	{
		get
		{
			return _completeValue;
		}
		set
		{
			Set(ref _completeValue, value, "CompleteValue");
		}
	}

	public int RewardState
	{
		get
		{
			return _rewardState;
		}
		set
		{
			Set(ref _rewardState, value, "RewardState");
		}
	}

	public int CompleteState
	{
		get
		{
			return _completeState;
		}
		set
		{
			Set(ref _completeState, value, "CompleteState");
		}
	}

	public int TargetValue
	{
		get
		{
			return _targetValue;
		}
		set
		{
			Set(ref _targetValue, value, "TargetValue");
		}
	}

	public int GroupId
	{
		get
		{
			return _groupId;
		}
		set
		{
			Set(ref _groupId, value, "GroupId");
		}
	}

	public ActivityTaskData()
	{
	}

	public ActivityTaskData(PbActivityTaskData pbActivityTaskData)
	{
		if (pbActivityTaskData != null)
		{
			Id = pbActivityTaskData.Id;
			CompleteState = pbActivityTaskData.CompeteState;
			RewardState = pbActivityTaskData.RewardState;
			CompleteValue = pbActivityTaskData.CompeteValue;
			TargetValue = pbActivityTaskData.TargetValue;
		}
	}
}
