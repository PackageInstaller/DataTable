using System.Collections.Generic;

namespace Ase;

public class CopyEnterInfoData
{
	private CopyData copyData;

	private long checkCode;

	private bool isSingle;

	private bool isMatch;

	private float matchTime;

	private long roomId;

	private int seedId;

	private List<TeamMember> teamMembers;

	private int materialId;

	private int isBattleSend;

	private bool isCampaignBattle;

	public CopyData CopyData
	{
		get
		{
			return copyData;
		}
		set
		{
			copyData = value;
		}
	}

	public long CheckCode
	{
		get
		{
			return checkCode;
		}
		set
		{
			checkCode = value;
		}
	}

	public bool IsSingle
	{
		get
		{
			return isSingle;
		}
		set
		{
			isSingle = value;
		}
	}

	public bool IsMatch
	{
		get
		{
			return isMatch;
		}
		set
		{
			isMatch = value;
		}
	}

	public float MatchTime
	{
		get
		{
			return matchTime;
		}
		set
		{
			matchTime = value;
		}
	}

	public List<TeamMember> TeamMembers
	{
		get
		{
			return teamMembers;
		}
		set
		{
			teamMembers = value;
		}
	}

	public int MaterialId
	{
		get
		{
			return materialId;
		}
		set
		{
			materialId = value;
		}
	}

	public long RoomId
	{
		get
		{
			return roomId;
		}
		set
		{
			roomId = value;
		}
	}

	public int SeedID
	{
		get
		{
			return seedId;
		}
		set
		{
			seedId = value;
		}
	}

	public int IsBattleSend
	{
		get
		{
			return isBattleSend;
		}
		set
		{
			isBattleSend = value;
		}
	}

	public bool IsCampaignBattle
	{
		get
		{
			return isCampaignBattle;
		}
		set
		{
			isCampaignBattle = value;
		}
	}
}
