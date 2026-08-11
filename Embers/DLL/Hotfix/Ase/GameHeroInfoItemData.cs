namespace Ase;

public class GameHeroInfoItemData : OptionBase
{
	private string icon;

	private string title;

	private string desc;

	private bool isLock;

	private string lockText;

	private int id;

	private bool redPoint;

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public string Title
	{
		get
		{
			return title;
		}
		private set
		{
			Set(ref title, value, "Title");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		private set
		{
			Set(ref isLock, value, "IsLock");
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

	public string LockText
	{
		get
		{
			return lockText;
		}
		private set
		{
			Set(ref lockText, value, "LockText");
		}
	}

	public int ID => id;

	public GameHeroInfoItemData(OptionBase parent, int id = 0)
	{
		base.parent = parent;
		this.id = id;
	}

	public void SetIconPath(string iconPath)
	{
		Icon = iconPath;
	}

	public void SetText(string titleText, string descText = "")
	{
		Title = titleText;
		Desc = descText.Replace("\\n", "\n");
	}

	public void SetLock(bool isLock, string newLockText)
	{
		IsLock = isLock;
		if (IsLock)
		{
			Desc = "\n\n";
			LockText = newLockText;
		}
	}

	public void OnClick()
	{
		if (RedPoint)
		{
			RedPoint = false;
		}
		parent?.ItemOnClick(this);
	}
}
