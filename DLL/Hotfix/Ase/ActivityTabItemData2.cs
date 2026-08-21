namespace Ase;

public class ActivityTabItemData2 : OptionBase
{
	private ActivityTabStateEnum stateEnum;

	private bool isSelect;

	private string tagName;

	private int tagId;

	private int activityId;

	private bool timeLock;

	private string lockDes;

	private string activityfinishDes;

	private bool passAllLevel;

	private bool areaRedPoint;

	public long UnLockTime { get; set; }

	public ActivityTabStateEnum StateEnum
	{
		get
		{
			return stateEnum;
		}
		set
		{
			Set(ref stateEnum, value, "StateEnum");
		}
	}

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public bool TimeLock
	{
		get
		{
			return timeLock;
		}
		set
		{
			Set(ref timeLock, value, "TimeLock");
		}
	}

	public string LockDes
	{
		get
		{
			return lockDes;
		}
		set
		{
			Set(ref lockDes, value, "LockDes");
		}
	}

	public string ActivityfinishDes
	{
		get
		{
			return activityfinishDes;
		}
		set
		{
			Set(ref activityfinishDes, value, "ActivityfinishDes");
		}
	}

	public bool PassAllLevel
	{
		get
		{
			return passAllLevel;
		}
		set
		{
			Set(ref passAllLevel, value, "PassAllLevel");
		}
	}

	public bool AreaRedPoint
	{
		get
		{
			return areaRedPoint;
		}
		set
		{
			Set(ref areaRedPoint, value, "AreaRedPoint");
		}
	}

	public int TagId => tagId;

	public string TagName => tagName;

	public ActivityTabItemData2(OptionBase parent, int activityId, int tagId, string tagName)
	{
		base.parent = parent;
		this.activityId = activityId;
		this.tagId = tagId;
		this.tagName = tagName;
	}

	public override void SetParent(OptionBase parent)
	{
		base.SetParent(parent);
		base.parent = parent;
	}

	public void BtnOnClick()
	{
		parent?.ItemOnClick(new OptionArg(this, ""));
	}

	public void SetSelect(bool value)
	{
		IsSelect = value;
	}
}
