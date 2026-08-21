namespace Ase;

public class PlayerItemBaseData : OptionBase
{
	protected long uid;

	protected string name;

	protected string icon = "";

	protected int level;

	protected string headFrame = "";

	protected string title = "";

	protected string state;

	protected int stateNum;

	protected int titleId;

	public int StateNum
	{
		get
		{
			return stateNum;
		}
		set
		{
			Set(ref stateNum, value, "StateNum");
		}
	}

	public string State
	{
		get
		{
			return state;
		}
		set
		{
			Set(ref state, value, "State");
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

	public int Level
	{
		get
		{
			return level;
		}
		set
		{
			Set(ref level, value, "Level");
		}
	}

	public string HeadFrame
	{
		get
		{
			return headFrame;
		}
		set
		{
			Set(ref headFrame, value, "HeadFrame");
		}
	}

	public string Title
	{
		get
		{
			return title;
		}
		set
		{
			Set(ref title, value, "Title");
		}
	}

	public int TitleId
	{
		get
		{
			return titleId;
		}
		set
		{
			Set(ref titleId, value, "TitleId");
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

	public long Uid
	{
		get
		{
			return uid;
		}
		set
		{
			Set(ref uid, value, "Uid");
		}
	}

	public PlayerItemBaseData()
	{
	}

	public PlayerItemBaseData(OptionBase parent, PlayerDataBase playerDataBase)
	{
		base.parent = parent;
		Init(playerDataBase.Uid, playerDataBase.Name, playerDataBase.Level, playerDataBase.IconId, playerDataBase.IconFrame, playerDataBase.Title);
	}

	public PlayerItemBaseData(OptionBase parent, PlayerData playerData)
	{
		base.parent = parent;
		Init(playerData.Uid, playerData.Name, playerData.Level, playerData.IconId, playerData.IconFrame, playerData.Title, playerData.State);
	}

	public PlayerItemBaseData(OptionBase parent, long uid, string name, int level, int icon, int iconFrame, int title, int state = 0)
	{
		base.parent = parent;
		Init(uid, name, level, icon, iconFrame, title, state);
	}

	protected void Init(long uid, string name, int level, int icon, int iconFrame, int title, int state = 0)
	{
		Uid = uid;
		Name = name;
		Level = level;
		Icon = PlayerDataBase.GetIcon(icon);
		HeadFrame = $"HeadAdorn{iconFrame}";
		Title = $"UserTitle{title}";
		TitleId = title;
		StateNum = state;
		State = PlayerDefinition.GetStateText(state);
	}
}
