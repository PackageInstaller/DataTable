namespace Ase;

public class BattleDropItemData : ItemOptionBase
{
	private string _icon = "";

	private string _name;

	private string _nameShow;

	private string _count;

	private string _countShow;

	private int quality;

	private float showTime;

	public string Icon
	{
		get
		{
			return _icon;
		}
		set
		{
			Set(ref _icon, value, "Icon");
		}
	}

	public string Name
	{
		get
		{
			return _name;
		}
		set
		{
			Set(ref _name, value, "Name");
		}
	}

	public string Count
	{
		get
		{
			return _count;
		}
		set
		{
			Set(ref _count, value, "Count");
		}
	}

	public string NameShow
	{
		get
		{
			return _nameShow;
		}
		set
		{
			Set(ref _nameShow, value, "NameShow");
		}
	}

	public string CountShow
	{
		get
		{
			return _countShow;
		}
		set
		{
			Set(ref _countShow, value, "CountShow");
		}
	}

	public int Quality
	{
		get
		{
			if (quality <= 2)
			{
				return 0;
			}
			return quality;
		}
		set
		{
			quality = value;
			switch (quality)
			{
			case 3:
				showTime = 1.8f;
				break;
			case 4:
				showTime = 2f;
				break;
			default:
				showTime = 1.5f;
				break;
			}
		}
	}

	public float ShowTime => showTime;

	public BattleDropItemData()
	{
	}

	public BattleDropItemData(OptionBase parent, DropData dropData)
	{
		base.parent = parent;
		Icon = dropData.icon;
		Name = dropData.name;
		NameShow = Name;
		Count = $" x {dropData.count}";
		CountShow = Count;
		Quality = dropData.quality;
		TextColor(Quality);
	}

	private void TextColor(int quality)
	{
		string arg = "";
		switch (quality)
		{
		case 0:
		case 1:
		case 2:
			arg = "#cdcdcd";
			break;
		case 3:
			arg = "#f479ff";
			break;
		case 4:
			arg = "#ffeb7a";
			break;
		}
		Name = $"<color={arg}>{Name}</color>";
		Count = $"<color={arg}>{Count}</color>";
	}
}
