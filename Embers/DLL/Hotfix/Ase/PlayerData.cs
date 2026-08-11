using System.Collections.Generic;

namespace Ase;

public class PlayerData : PlayerDataBase
{
	public enum RelationState
	{
		Self,
		Stranger,
		FriendApplying2Me,
		Friend,
		BlackList
	}

	private long lastLoginTime;

	private string verifyMessage;

	private RelationState relationShip;

	private List<PbNormalRoleInfo> heroList;

	private float quitGuildCoolingSecond;

	private Timer quitGuildCoolingTimer;

	private int state = 4;

	private int energyReceiveState;

	private int energySendState;

	public float QuitGuildCoolingSecond
	{
		get
		{
			return quitGuildCoolingSecond;
		}
		private set
		{
			Set(ref quitGuildCoolingSecond, value, "QuitGuildCoolingSecond");
		}
	}

	public long LastLoginTime
	{
		get
		{
			return lastLoginTime;
		}
		protected set
		{
			Set(ref lastLoginTime, value, "LastLoginTime");
		}
	}

	public string VerifyMessage
	{
		get
		{
			return verifyMessage;
		}
		private set
		{
			Set(ref verifyMessage, value, "VerifyMessage");
		}
	}

	public RelationState RelationShip
	{
		get
		{
			return relationShip;
		}
		private set
		{
			Set(ref relationShip, value, "RelationShip");
		}
	}

	public List<PbNormalRoleInfo> HeroList => heroList;

	public int State
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

	public int EnergyReceiveState
	{
		get
		{
			return energyReceiveState;
		}
		set
		{
			Set(ref energyReceiveState, value, "EnergyReceiveState");
		}
	}

	public int EnergySendState
	{
		get
		{
			return energySendState;
		}
		set
		{
			Set(ref energySendState, value, "EnergySendState");
		}
	}

	public PlayerData()
	{
	}

	public PlayerData(long uid)
	{
		base.Uid = uid;
	}

	public PlayerData(PbFriendItemInfo friendInfo, RelationState relationShip, string verifyMessage = "")
	{
		base.Uid = friendInfo.UserId;
		iconId = friendInfo.Icon;
		base.Icon = PlayerDataBase.GetIcon(friendInfo.Icon);
		base.Name = friendInfo.Name;
		base.Vip = friendInfo.Vip;
		base.Level = friendInfo.Level;
		base.Exp = friendInfo.UserExp;
		base.Title = friendInfo.TitleId;
		base.IconFrame = friendInfo.IconFrame;
		base.MaxExp = GetMaxExp(friendInfo.Level);
		base.Rank = GetRank(base.Level);
		RelationShip = relationShip;
		LastLoginTime = friendInfo.LastLoginTime;
		VerifyMessage = verifyMessage;
		heroList = friendInfo.ShowHeroes;
		base.WeeklyRank = friendInfo.ShowUserRank;
		base.WeeklyStarCount = friendInfo.ShowChapterStar;
		base.HomelandLevel = friendInfo.HomelandLevel;
		base.MaxCopyOpenIndex = friendInfo.MaxCopyOpenIdx;
		base.CharacterIndex = friendInfo.Gender - 1;
		base.WearMedals = friendInfo.WearMedal;
		base.CopyChallengeInfos = InitCopyChallengeInfo(friendInfo.CopyChallengeInfo);
		base.CreatTime = friendInfo.CreateTime;
		base.CreatTimeTxt = FormatTimestampToDate(friendInfo.CreateTime);
		base.UnionName = GetUnionName(friendInfo.UnionName);
		base.ShowPosterGirl = friendInfo.PosterGirl;
		base.ShowBackground = friendInfo.Background;
		base.ShowCopyInfo = friendInfo.IsShowCopyInfo;
	}

	public PlayerData(UserBaseInfo userBaseInfo)
		: base(userBaseInfo)
	{
	}

	public PlayerData SetState(int newState)
	{
		State = newState;
		return this;
	}

	public void SetShowPosterGirl(int spineId)
	{
		base.ShowPosterGirl = spineId;
	}

	public void SetShowCopyInfo(bool showCopyInfo)
	{
		base.ShowCopyInfo = showCopyInfo;
	}

	public void SetWearMedals(List<PbMedalInfo> medals)
	{
		base.WearMedals = medals;
	}

	public void SetQuitGuildCoolingSecond(float second)
	{
		QuitGuildCoolingSecond = second;
		quitGuildCoolingTimer?.Cancel();
		quitGuildCoolingTimer = Timer.Register(second, delegate
		{
			QuitGuildCoolingSecond = 0f;
		}, delegate(float f)
		{
			QuitGuildCoolingSecond = second - f;
		}, isLooped: false, useRealTime: true);
	}

	public PlayerData SetEnergyReceiveState(int newState)
	{
		EnergyReceiveState = newState;
		return this;
	}

	public PlayerData SetEnergySendState(int newState)
	{
		EnergySendState = newState;
		return this;
	}

	public PlayerData SetRelationShip(RelationState state)
	{
		RelationShip = state;
		return this;
	}

	public void SetWeeklyCopyInfo(int rank, int star)
	{
		base.WeeklyRank = rank;
		base.WeeklyStarCount = star;
	}
}
