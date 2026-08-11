namespace Ase;

public class CampaignAreaData : OptionBase
{
	private CampaignAreaType _type;

	private int _positionId;

	private string _name;

	private string _icon = "";

	private int _iconSize;

	private int _clickRange;

	private int _playId;

	private int _copyId;

	public CampaignAreaType Type
	{
		get
		{
			return _type;
		}
		set
		{
			Set(ref _type, value, "Type");
		}
	}

	public int PositionId
	{
		get
		{
			return _positionId;
		}
		set
		{
			Set(ref _positionId, value, "PositionId");
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

	public int IconSize
	{
		get
		{
			return _iconSize;
		}
		set
		{
			Set(ref _iconSize, value, "IconSize");
		}
	}

	public int ClickRange
	{
		get
		{
			return _clickRange;
		}
		set
		{
			Set(ref _clickRange, value, "ClickRange");
		}
	}

	public int PlayId
	{
		get
		{
			return _playId;
		}
		set
		{
			Set(ref _playId, value, "PlayId");
		}
	}

	public int CopyId
	{
		get
		{
			return _copyId;
		}
		set
		{
			Set(ref _copyId, value, "CopyId");
		}
	}

	public CampaignAreaData()
	{
	}

	public CampaignAreaData(OptionBase parent)
	{
		base.parent = parent;
	}

	public void OnAreaClick()
	{
		parent?.ItemOnClick(this);
	}
}
