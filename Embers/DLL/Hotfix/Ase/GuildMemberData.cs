using System;

namespace Ase;

public class GuildMemberData : PlayerData
{
	private int weeklyActivePoint;

	private int totalActivePoint;

	private GuildDefinition.GuildPositions position;

	private long enterTime;

	public int WeeklyActivePoint
	{
		get
		{
			return weeklyActivePoint;
		}
		set
		{
			Set(ref weeklyActivePoint, value, "WeeklyActivePoint");
		}
	}

	public int TotalActivePoint
	{
		get
		{
			return totalActivePoint;
		}
		set
		{
			Set(ref totalActivePoint, value, "TotalActivePoint");
		}
	}

	public GuildDefinition.GuildPositions Position
	{
		get
		{
			return position;
		}
		private set
		{
			Set(ref position, value, "Position");
		}
	}

	public long EnterTime
	{
		get
		{
			return enterTime;
		}
		set
		{
			Set(ref enterTime, value, "EnterTime");
		}
	}

	public static GuildMemberData Create(PbUnionMemberInfo pbInfo)
	{
		return new GuildMemberData
		{
			Uid = pbInfo.UserId,
			iconId = pbInfo.Icon,
			Icon = PlayerDataBase.GetIcon(pbInfo.Icon),
			Name = pbInfo.Name,
			Vip = pbInfo.Vip,
			Level = pbInfo.Level,
			Title = pbInfo.TitleId,
			IconFrame = pbInfo.IconFrame,
			LastLoginTime = pbInfo.LastLoginTime,
			State = pbInfo.State,
			WeeklyActivePoint = pbInfo.WeeklyActivePoint,
			TotalActivePoint = pbInfo.TotalActivePoint,
			Position = (GuildDefinition.GuildPositions)pbInfo.Position,
			EnterTime = pbInfo.EnterTime
		};
	}

	public static GuildMemberData CreateBaseMaster(PbUnionLeaderInfo pbInfo)
	{
		return new GuildMemberData
		{
			Uid = pbInfo.LeaderUserId,
			iconId = pbInfo.LeaderIcon,
			Icon = PlayerDataBase.GetIcon(pbInfo.LeaderIcon),
			Name = pbInfo.LeaderName,
			Level = pbInfo.LeaderLevel,
			IconFrame = pbInfo.LeaderIconFrame,
			Position = GuildDefinition.GuildPositions.Master
		};
	}

	public bool ModifyPosition(int newPosition)
	{
		if (Enum.IsDefined(typeof(GuildDefinition.GuildPositions), newPosition))
		{
			Position = (GuildDefinition.GuildPositions)newPosition;
			return true;
		}
		return false;
	}

	public bool ModifyPosition(GuildDefinition.GuildPositions newPosition)
	{
		Position = newPosition;
		return true;
	}
}
