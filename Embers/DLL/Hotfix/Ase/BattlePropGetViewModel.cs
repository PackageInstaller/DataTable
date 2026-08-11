namespace Ase;

public class BattlePropGetViewModel : OptionBase
{
	private string icon = "";

	private string name = "";

	private string desc = "";

	private bool isNew;

	private int oldStarCount;

	private int starCountMax;

	private int newStarCount;

	public int OldStarCount
	{
		get
		{
			return oldStarCount;
		}
		set
		{
			Set(ref oldStarCount, value, "OldStarCount");
		}
	}

	public int NewStarCount
	{
		get
		{
			return newStarCount;
		}
		set
		{
			Set(ref newStarCount, value, "NewStarCount");
		}
	}

	public int StarCountMax
	{
		get
		{
			return starCountMax;
		}
		set
		{
			Set(ref starCountMax, value, "StarCountMax");
		}
	}

	public bool IsNew
	{
		get
		{
			return isNew;
		}
		set
		{
			Set(ref isNew, value, "IsNew");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		set
		{
			Set(ref icon, value, "Icon");
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

	public BattlePropGetViewModel(BPData bpData, bool isNew, int oldStarCount)
	{
		desc = bpData.Desc;
		icon = bpData.Icon;
		name = bpData.Name;
		this.isNew = isNew;
		this.oldStarCount = oldStarCount;
		newStarCount = bpData.Level;
		starCountMax = bpData.LevelMax;
	}
}
