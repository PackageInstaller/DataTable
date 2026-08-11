namespace Ase;

public class TeamPlayerItemData : OptionBase
{
	private string playerName;

	private int icon;

	private string iconPath;

	private int advLevel;

	private bool hasPlayer;

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

	public int Icon
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

	public int AdvLevel
	{
		get
		{
			return advLevel;
		}
		private set
		{
			Set(ref advLevel, value, "AdvLevel");
		}
	}

	public bool HasPlayer
	{
		get
		{
			return hasPlayer;
		}
		private set
		{
			Set(ref hasPlayer, value, "HasPlayer");
		}
	}

	public TeamPlayerItemData()
	{
	}

	public TeamPlayerItemData(OptionBase parent, PbSingleGamerInfo info)
	{
		base.parent = parent;
		SetData(info);
	}

	public TeamPlayerItemData(OptionBase parent)
	{
		base.parent = parent;
		SetEmpty();
	}

	public void SetData(PbSingleGamerInfo info)
	{
		if (info == null)
		{
			SetEmpty();
			return;
		}
		PlayerName = info.Name;
		Icon = info.Icon;
		HasPlayer = true;
		AdvLevel = info.Level;
	}

	public void SetEmpty()
	{
		HasPlayer = false;
		Icon = 0;
		PlayerName = "";
		AdvLevel = 0;
	}
}
