namespace Ase;

public class GuildRankItemData : GuildItemData
{
	private int rank;

	private string rankIcon = "";

	private bool noRank;

	public int Rank
	{
		get
		{
			return rank;
		}
		set
		{
			Set(ref rank, value, "Rank");
		}
	}

	public string RankIcon
	{
		get
		{
			return rankIcon;
		}
		set
		{
			Set(ref rankIcon, value, "RankIcon");
		}
	}

	public bool NoRank
	{
		get
		{
			return noRank;
		}
		set
		{
			Set(ref noRank, value, "NoRank");
		}
	}

	public GuildRankItemData()
	{
	}

	public GuildRankItemData(OptionBase parent)
		: base(parent)
	{
		NoRank = true;
	}

	public GuildRankItemData(OptionBase parent, GuildData guildData, int rank, bool clickEnable = true)
		: base(parent, guildData, clickEnable)
	{
		Rank = rank;
		RankIcon = ((rank > 3) ? "GuildRank_4" : $"GuildRank_{rank}");
		NoRank = false;
	}

	public void RefreshData(GuildData data, int rank, bool clickEnable = true)
	{
		RefreshData(data, clickEnable);
		Rank = rank;
		RankIcon = ((rank > 3) ? "GuildRank_4" : $"GuildRank_{rank}");
		NoRank = false;
	}
}
