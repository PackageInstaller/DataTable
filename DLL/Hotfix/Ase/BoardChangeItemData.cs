namespace Ase;

public class BoardChangeItemData : ItemOptionBase
{
	private DRBoardBackGround _drBg;

	private DRBoardHeroList _drHero;

	private bool isDefaultBg;

	private int id;

	private string icon = "";

	private string imagePath;

	private bool selected;

	private bool unlock;

	private bool showTag;

	public bool IsDefaultBg
	{
		get
		{
			return isDefaultBg;
		}
		set
		{
			Set(ref isDefaultBg, value, "IsDefaultBg");
		}
	}

	public int Id
	{
		get
		{
			return id;
		}
		set
		{
			Set(ref id, value, "Id");
		}
	}

	public string ImagePath
	{
		get
		{
			return imagePath;
		}
		set
		{
			Set(ref imagePath, value, "ImagePath");
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

	public bool Selected
	{
		get
		{
			return selected;
		}
		set
		{
			Set(ref selected, value, "Selected");
		}
	}

	public bool Unlock
	{
		get
		{
			return unlock;
		}
		set
		{
			Set(ref unlock, value, "Unlock");
		}
	}

	public bool ShowTag
	{
		get
		{
			return showTag;
		}
		set
		{
			Set(ref showTag, value, "ShowTag");
		}
	}

	public DRBoardHeroList DrHero => _drHero;

	public DRBoardBackGround DrBg => _drBg;

	public BoardChangeItemData()
	{
	}

	public BoardChangeItemData(OptionBase parent, DRBoardHeroList drHero, bool showTag, bool unlock)
	{
		base.parent = parent;
		_drHero = drHero;
		_drBg = null;
		IsDefaultBg = false;
		Id = drHero.Id;
		ShowTag = showTag;
		Unlock = unlock;
		Icon = GetBoardHeroIcon(drHero);
	}

	public BoardChangeItemData(OptionBase parent, DRBoardBackGround drBg, bool showTag, bool unlock = true)
	{
		base.parent = parent;
		_drBg = drBg;
		_drHero = null;
		IsDefaultBg = false;
		Id = drBg.Id;
		ShowTag = showTag;
		Unlock = unlock;
		ImagePath = drBg.IconPath;
	}

	public BoardChangeItemData(OptionBase parent, bool showTag)
	{
		base.parent = parent;
		_drBg = null;
		_drHero = null;
		IsDefaultBg = true;
		Id = 0;
		ShowTag = showTag;
		Unlock = true;
		ImagePath = "";
	}

	private string GetBoardHeroIcon(DRBoardHeroList config)
	{
		if (!config.MultiClass)
		{
			return config.IconPath;
		}
		if (!StreamerMode.GetStreamerMode())
		{
			return config.SexIconPath;
		}
		return config.IconPath;
	}

	public void OnItemClick()
	{
		parent.ItemOnClick(this);
	}
}
