namespace Ase;

public class CopyRankItemViewModel : OptionBase
{
	private int score;

	private string playerName;

	private string icon;

	private int iconFrame;

	private int iconTitle;

	private string titlePrefabPath;

	private int index;

	private bool isEmpty;

	public bool IsEmpty => isEmpty;

	public int Index
	{
		get
		{
			return index;
		}
		private set
		{
			Set(ref index, value, "Index");
		}
	}

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

	public int IconFrame
	{
		get
		{
			return iconFrame;
		}
		private set
		{
			Set(ref iconFrame, value, "IconFrame");
		}
	}

	public int IconTitle
	{
		get
		{
			return iconTitle;
		}
		private set
		{
			Set(ref iconTitle, value, "IconTitle");
		}
	}

	public string TitlePrefabPath
	{
		get
		{
			return titlePrefabPath;
		}
		private set
		{
			Set(ref titlePrefabPath, value, "TitlePrefabPath");
		}
	}

	public int Score
	{
		get
		{
			return score;
		}
		private set
		{
			Set(ref score, value, "Score");
		}
	}

	public string PlayerName
	{
		get
		{
			return playerName;
		}
		private set
		{
			Set(ref playerName, value, "PlayerName");
		}
	}

	public CopyRankItemViewModel()
	{
	}

	public CopyRankItemViewModel(OptionBase parent, int score, int icon, int iconFrame, int iconTitle, int index, string playerName)
	{
		base.parent = parent;
		this.score = score;
		this.index = index;
		DRHeadAvatar dataRow = GameEntry.DataTable.GetDataRow((DRHeadAvatar p) => p.Id == icon);
		if (dataRow != null)
		{
			this.icon = dataRow.Icon;
		}
		else
		{
			this.icon = "UserHead1104_0";
		}
		this.iconFrame = iconFrame;
		this.iconTitle = iconTitle;
		TitlePrefabPath = $"Title/UserTitle{iconTitle}";
		this.playerName = playerName;
	}

	public CopyRankItemViewModel(OptionBase parent, int index)
	{
		base.parent = parent;
		this.index = index;
		isEmpty = true;
	}
}
