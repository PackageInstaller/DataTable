namespace Ase;

public class GameStoryGuideItemData : OptionBase
{
	private int indexId;

	private int id;

	private string iconPath;

	private bool isNew;

	private bool upDown;

	private int type;

	private string title;

	private string desc;

	private int storyType;

	private int chapter;

	private string prefix;

	public int ID => id;

	public string IconPath => iconPath;

	public string Title => title;

	public string Desc => desc;

	public int StoryType => storyType;

	public int Chapter => chapter;

	public int IndexId => indexId;

	public string Prefix => prefix;

	public bool UpDown
	{
		get
		{
			return upDown;
		}
		set
		{
			Set(ref upDown, value, "UpDown");
		}
	}

	public bool IsNew
	{
		get
		{
			return isNew;
		}
		private set
		{
			Set(ref isNew, value, "IsNew");
		}
	}

	public GameStoryGuideItemData(OptionBase parent, string iconPath, int id = 0, int type = 1, string prefix = "")
	{
		base.parent = parent;
		this.iconPath = iconPath;
		this.prefix = prefix;
		this.id = id;
		this.type = type;
	}

	public void SetExData(int chapter, int storyType, string title = "", string desc = "")
	{
		this.chapter = chapter;
		this.storyType = storyType;
		this.title = title;
		this.desc = desc;
	}

	public void SetIndexId(int indexId)
	{
		this.indexId = indexId;
	}

	public void SetIsNew(bool value)
	{
		IsNew = value;
	}

	public void OnClick()
	{
		SetRedPoint();
		parent?.ItemOnClick(new OptionArg(this, "Open"));
	}

	public void SetRedPoint()
	{
		if (IsNew)
		{
			IsNew = false;
			Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().SaveRedPoint(type, indexId);
		}
	}
}
