using GameFramework.Runtime;

namespace Ase;

public class GuildData : ViewModelBase
{
	protected long uid;

	protected string name;

	protected GuildDefinition.Flag flag;

	protected string flagIcon;

	protected string description;

	protected int level;

	protected int maxLevel;

	protected int memberCount;

	protected int maxMemberCount;

	protected int activePoint;

	protected int weeklyActivePoint;

	protected int funds;

	protected GuildMemberData master;

	protected GuildDefinition.AuditType auditType;

	protected int applyLevelThreshold;

	public long Uid
	{
		get
		{
			return uid;
		}
		protected set
		{
			Set(ref uid, value, "Uid");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		protected set
		{
			Set(ref name, value, "Name");
		}
	}

	public GuildDefinition.Flag Flag
	{
		get
		{
			return flag;
		}
		protected set
		{
			Set(ref flag, value, "Flag");
		}
	}

	public string FlagIcon
	{
		get
		{
			return flagIcon;
		}
		protected set
		{
			Set(ref flagIcon, value, "FlagIcon");
		}
	}

	public string Description
	{
		get
		{
			return description;
		}
		protected set
		{
			Set(ref description, value, "Description");
		}
	}

	public int Level
	{
		get
		{
			return level;
		}
		protected set
		{
			Set(ref level, value, "Level");
			MaxMemberCount = GuildDefinition.GetMaxMemberCount(value);
		}
	}

	public int MaxLevel
	{
		get
		{
			return maxLevel;
		}
		protected set
		{
			Set(ref maxLevel, value, "MaxLevel");
		}
	}

	public int MemberCount
	{
		get
		{
			return memberCount;
		}
		protected set
		{
			Set(ref memberCount, value, "MemberCount");
		}
	}

	public int MaxMemberCount
	{
		get
		{
			return maxMemberCount;
		}
		protected set
		{
			Set(ref maxMemberCount, value, "MaxMemberCount");
		}
	}

	public int ActivePoint
	{
		get
		{
			return activePoint;
		}
		protected set
		{
			Set(ref activePoint, value, "ActivePoint");
		}
	}

	public int WeeklyActivePoint
	{
		get
		{
			return weeklyActivePoint;
		}
		protected set
		{
			Set(ref weeklyActivePoint, value, "WeeklyActivePoint");
		}
	}

	public int Funds
	{
		get
		{
			return funds;
		}
		protected set
		{
			Set(ref funds, value, "Funds");
		}
	}

	public GuildMemberData Master
	{
		get
		{
			return master;
		}
		protected set
		{
			Set(ref master, value, "Master");
		}
	}

	public GuildDefinition.AuditType AuditType
	{
		get
		{
			return auditType;
		}
		protected set
		{
			Set(ref auditType, value, "AuditType");
		}
	}

	public int ApplyLevelThreshold
	{
		get
		{
			return applyLevelThreshold;
		}
		protected set
		{
			Set(ref applyLevelThreshold, value, "ApplyLevelThreshold");
		}
	}

	public bool IsFull()
	{
		return MemberCount >= MaxMemberCount;
	}

	public static GuildData Create(PbUnionInfo pbUnionInfo)
	{
		GuildData guildData = new GuildData();
		guildData.SetInfo(pbUnionInfo);
		guildData.SetBaseMaster(pbUnionInfo.BaseInfo.LeaderInfo);
		return guildData;
	}

	public static GuildData Create(PbUnionBaseInfo baseInfo)
	{
		GuildData guildData = new GuildData();
		guildData.SetBaseInfo(baseInfo);
		guildData.SetBaseMaster(baseInfo.LeaderInfo);
		return guildData;
	}

	protected void SetBaseInfo(PbUnionBaseInfo pbBaseInfo)
	{
		Uid = pbBaseInfo.UnionId;
		Name = pbBaseInfo.Name;
		Flag = (GuildDefinition.Flag)pbBaseInfo.Flag;
		FlagIcon = GuildDefinition.GetGuildFlagIcon((int)Flag);
		Description = pbBaseInfo.Declaration;
		Level = pbBaseInfo.Level;
		MaxLevel = GuildDefinition.GetGuildMaxLevel();
		MemberCount = pbBaseInfo.MemberCount;
		AuditType = (GuildDefinition.AuditType)pbBaseInfo.Examine;
		ApplyLevelThreshold = pbBaseInfo.LevelLimit;
	}

	public virtual void SetUpdateInfo(PbUnionUpdateInfo updateInfo)
	{
		ActivePoint = updateInfo.ActivePoint;
		WeeklyActivePoint = updateInfo.WeeklyActivePoint;
		Funds = updateInfo.Money;
	}

	public void SetInfo(PbUnionInfo pbUnionInfo)
	{
		if (pbUnionInfo != null)
		{
			SetBaseInfo(pbUnionInfo.BaseInfo);
			SetUpdateInfo(pbUnionInfo.UpdateInfo);
		}
	}

	public virtual void AddNewActivePoint(int newActivePoint)
	{
		WeeklyActivePoint += newActivePoint;
		ActivePoint += newActivePoint;
	}

	public virtual void SetWeeklyActivePoint(int point)
	{
		WeeklyActivePoint = point;
	}

	public virtual void SetLevel(int level)
	{
		Level = level;
	}

	private void SetBaseMaster(PbUnionLeaderInfo leaderInfo)
	{
		Master = GuildMemberData.CreateBaseMaster(leaderInfo);
	}

	public void SetMaster(GuildMemberData guildMemberData)
	{
		Master = guildMemberData;
	}
}
