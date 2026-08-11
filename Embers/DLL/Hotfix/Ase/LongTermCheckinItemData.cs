namespace Ase;

public class LongTermCheckinItemData : ItemOptionBase
{
	private int _id;

	private int _day;

	private int _count;

	private int _quality;

	private string _icon = "";

	private bool _highlight;

	private bool _received;

	private PropDataBase _propDataBase;

	public int Id
	{
		get
		{
			return _id;
		}
		private set
		{
			Set(ref _id, value, "Id");
		}
	}

	public int Day
	{
		get
		{
			return _day;
		}
		private set
		{
			Set(ref _day, value, "Day");
		}
	}

	public int Count
	{
		get
		{
			return _count;
		}
		private set
		{
			Set(ref _count, value, "Count");
		}
	}

	public string Icon
	{
		get
		{
			return _icon;
		}
		private set
		{
			Set(ref _icon, value, "Icon");
		}
	}

	public bool Highlight
	{
		get
		{
			return _highlight;
		}
		private set
		{
			Set(ref _highlight, value, "Highlight");
		}
	}

	public bool Received
	{
		get
		{
			return _received;
		}
		private set
		{
			Set(ref _received, value, "Received");
		}
	}

	public int Quality
	{
		get
		{
			return _quality;
		}
		set
		{
			Set(ref _quality, value, "Quality");
		}
	}

	public PropDataBase PropDataBase => _propDataBase;

	public LongTermCheckinItemData()
	{
	}

	public LongTermCheckinItemData(OptionBase parent, DRActivitySign config, ActivityTaskData task)
	{
		base.parent = parent;
		Id = config.Id;
		Day = task.TargetValue;
		Highlight = task.CompleteState == 1 && task.RewardState == 0;
		Received = task.RewardState == 1;
		DRActivityTaskReward dataRow = GameEntry.DataTable.GetDataRow<DRActivityTaskReward>(config.RewardId);
		if (dataRow == null)
		{
			return;
		}
		int num = ((dataRow.RewardType.Count > 0) ? dataRow.RewardType[0] : 0);
		int num2 = ((dataRow.RewardId.Count > 0) ? dataRow.RewardId[0] : 0);
		int count = ((dataRow.RewardNum.Count > 0) ? dataRow.RewardNum[0] : 0);
		if (num > 0 && num2 > 0)
		{
			_propDataBase = PropDataBase.CreateByType(num, num2, count);
			if (_propDataBase != null)
			{
				Icon = _propDataBase.Icon;
				Count = count;
				Quality = _propDataBase.GetRarity();
			}
		}
	}

	public void RefreshTaskData(ActivityTaskData taskData)
	{
		if (taskData != null && taskData.Id == Id)
		{
			Highlight = taskData.CompleteState == 1 && taskData.RewardState == 0;
			Received = taskData.RewardState == 1;
		}
	}

	public void OnRewardGot()
	{
		Highlight = false;
		Received = true;
	}

	public void OnItemClick()
	{
		parent?.ItemOnClick(this);
	}
}
