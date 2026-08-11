namespace Ase;

public class ActivityPackItemData : ItemOptionBase
{
	private DRActivityPacksInclude _drData;

	private PropDataBase _propDataBase;

	private bool _highlight;

	private bool _received;

	public PropDataBase PropDataBase => _propDataBase;

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

	public DRActivityPacksInclude DrData => _drData;

	public ActivityPackItemData()
	{
	}

	public ActivityPackItemData(OptionBase parent, DRActivityPacksInclude drData, ActivityTaskData task)
	{
		base.parent = parent;
		_drData = drData;
		if (_drData != null)
		{
			DRActivityTaskReward dataRow = GameEntry.DataTable.GetDataRow<DRActivityTaskReward>(drData.RewardId);
			if (dataRow != null && dataRow.RewardId.Count > 0 && dataRow.RewardNum.Count > 0 && dataRow.RewardType.Count > 0)
			{
				_propDataBase = PropDataBase.CreateByType(dataRow.RewardType[0], dataRow.RewardId[0], dataRow.RewardNum[0]);
			}
			RefreshTaskData(task);
		}
	}

	public void RefreshTaskData(ActivityTaskData taskData)
	{
		if (_drData != null && taskData != null && taskData.Id == _drData.Id)
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
		if (!Highlight)
		{
			parent?.ItemOnClick(PropDataBase);
		}
		else
		{
			parent?.ItemOnClick(this);
		}
	}
}
