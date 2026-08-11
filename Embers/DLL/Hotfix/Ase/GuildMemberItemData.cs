using System;
using UnityEngine;

namespace Ase;

public class GuildMemberItemData : PlayerItemBaseData
{
	private GuildMemberData memberData;

	private GuildDefinition.GuildPositions position;

	private string positionText;

	private int weeklyActivePoint;

	private int totalActivePoint;

	private string onlineState;

	private bool isSelf;

	public GuildMemberData MemberData => memberData;

	public GuildDefinition.GuildPositions Position
	{
		get
		{
			return position;
		}
		set
		{
			Set(ref position, value, "Position");
			PositionText = value.GetDescription();
		}
	}

	public string PositionText
	{
		get
		{
			return positionText;
		}
		set
		{
			Set(ref positionText, value, "PositionText");
		}
	}

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

	public string OnlineState
	{
		get
		{
			return onlineState;
		}
		set
		{
			Set(ref onlineState, value, "OnlineState");
		}
	}

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public GuildMemberItemData()
	{
	}

	public GuildMemberItemData(OptionBase parent, GuildMemberData memberData, bool isSelf)
		: base(parent, memberData)
	{
		this.memberData = memberData;
		Position = memberData.Position;
		WeeklyActivePoint = memberData.WeeklyActivePoint;
		TotalActivePoint = memberData.TotalActivePoint;
		IsSelf = isSelf;
		OnlineState = GetOnlineState(memberData.LastLoginTime);
	}

	private string GetOnlineState(long timeStamp)
	{
		if (base.StateNum != 4)
		{
			return "在线";
		}
		TimeSpan ts = new TimeSpan(TimeZoneInfo.ConvertTime(new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc), TimeZoneInfo.Local).AddSeconds(timeStamp).Ticks);
		TimeSpan timeSpan = new TimeSpan(DateTime.Now.Ticks);
		TimeSpan timeSpan2 = timeSpan.Subtract(ts).Duration();
		if (timeSpan2.TotalDays > 7.0)
		{
			return "大于7天前";
		}
		if (timeSpan2.TotalDays >= 1.0)
		{
			return $"大于{Mathf.FloorToInt((float)timeSpan2.TotalDays)}天前";
		}
		if (timeSpan2.TotalHours >= 1.0)
		{
			return $"{Mathf.FloorToInt((float)timeSpan2.TotalHours)}小时前";
		}
		if (timeSpan2.TotalMinutes >= 1.0)
		{
			return $"{Mathf.FloorToInt((float)timeSpan2.TotalMinutes)}分钟前";
		}
		return "1分钟内";
	}

	public void OnOptionBtnClick(GuildMemberItem item)
	{
		parent?.ItemOnClick(item);
	}
}
