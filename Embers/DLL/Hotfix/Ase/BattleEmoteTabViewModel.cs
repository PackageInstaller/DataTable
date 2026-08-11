namespace Ase;

public class BattleEmoteTabViewModel : OptionBase
{
	private int id;

	private string iconPath;

	private string name;

	private int timeLimited;

	private int timeLimitGroupId;

	private int sortValue;

	private bool isTimeLimit;

	private long expireTime;

	private bool isSelected;

	private bool redPoint;

	public int Id => id;

	public int TimeLimited => timeLimited;

	public int TimeLimitGroupId => timeLimitGroupId;

	public long ExpireTime => expireTime;

	public int SortValue => sortValue;

	public bool IsTimeLimit
	{
		get
		{
			return isTimeLimit;
		}
		set
		{
			Set(ref isTimeLimit, value, "IsTimeLimit");
		}
	}

	public string IconPath
	{
		get
		{
			return iconPath;
		}
		set
		{
			Set(ref iconPath, value, "IconPath");
		}
	}

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
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

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public BattleEmoteTabViewModel()
	{
	}

	public BattleEmoteTabViewModel(OptionBase parent, DRBattleEmoteGroup dr, long expireTime)
	{
		base.parent = parent;
		id = dr.Id;
		iconPath = dr.Icon;
		name = dr.Name;
		timeLimited = dr.TimeLimited;
		timeLimitGroupId = dr.TimeLimitGroup;
		this.expireTime = expireTime;
		sortValue = dr.Sort;
		InitIsTimeLimit();
	}

	public void OnClike()
	{
		parent?.ItemOnClick(this);
	}

	public void InitIsTimeLimit()
	{
		IsTimeLimit = timeLimited != 1;
	}
}
