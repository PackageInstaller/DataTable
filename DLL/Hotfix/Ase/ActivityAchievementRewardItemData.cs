using System.Collections.Generic;

namespace Ase;

public class ActivityAchievementRewardItemData : OptionBase
{
	private string countTxt;

	private string descTxt;

	private bool redPoint;

	private ActivityAchievementTaskData config;

	private List<ReceiveItemViewModel> dropProps = new List<ReceiveItemViewModel>();

	public string CountTxt
	{
		get
		{
			return countTxt;
		}
		set
		{
			Set(ref countTxt, value, "CountTxt");
		}
	}

	public string DescTxt
	{
		get
		{
			return descTxt;
		}
		set
		{
			Set(ref descTxt, value, "DescTxt");
		}
	}

	public bool RedPoint
	{
		get
		{
			return redPoint;
		}
		set
		{
			Set(ref redPoint, value, "RedPoint");
		}
	}

	public ActivityAchievementTaskData Config
	{
		get
		{
			return config;
		}
		set
		{
			Set(ref config, value, "Config");
		}
	}

	public List<ReceiveItemViewModel> DropProps => dropProps;

	public ActivityAchievementRewardItemData()
	{
	}

	public ActivityAchievementRewardItemData(OptionBase parent, ActivityAchievementTaskData config)
	{
		base.parent = parent;
		this.config = config;
		InitData();
		RefreshState();
	}

	private void InitData()
	{
		CountTxt = config.progress + "/" + config.requireValue;
		DescTxt = config.taskDesc;
		DRLibraryReward dataRow = GameEntry.DataTable.GetDataTable<DRLibraryReward>().GetDataRow(config.rewardId);
		for (int i = 0; i < dataRow.RewardType.Count; i++)
		{
			ReceiveItemViewModel item = new ReceiveItemViewModel(PropDataBase.CreateByType(dataRow.RewardType[i], dataRow.RewardId[i], dataRow.RewardNum[i]), this);
			dropProps.Add(item);
		}
	}

	public void RefreshState()
	{
		bool isClaimed = config.isClaimed;
		bool isCompleted = config.isCompleted;
		foreach (ReceiveItemViewModel dropProp in dropProps)
		{
			if (isClaimed)
			{
				dropProp.SetGot(isGot: true);
				dropProp.SetLock(isLock: false);
			}
			else if (isCompleted)
			{
				dropProp.SetGot(isGot: false);
				dropProp.SetLock(isLock: false);
			}
			else
			{
				dropProp.SetGot(isGot: false);
				dropProp.SetLock(isLock: true);
			}
		}
		RedPoint = isCompleted && !isClaimed;
	}

	public void OnClick()
	{
		parent?.ItemOnClick(this);
	}

	public override void ItemOnClick(object obj)
	{
		parent?.ItemOnClick(obj);
	}
}
