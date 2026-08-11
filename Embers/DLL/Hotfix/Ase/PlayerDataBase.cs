#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class PlayerDataBase : ViewModelBase
{
	protected long uid;

	protected string icon;

	protected int iconId;

	protected int iconFrame;

	protected int title;

	protected string name;

	protected int characterIndex;

	protected int vip;

	protected int level;

	protected int homelandLevel;

	protected int maxSoryLevel;

	protected long exp;

	protected long maxExp;

	protected int weeklyRank;

	protected int rank;

	protected int weeklyStarCount;

	protected int maxCopyOpenIndex;

	protected List<PbMedalInfo> wearMedals;

	protected List<PbCopyChallengeInfo> copyChallengeInfos;

	protected long creatTime;

	protected string creatTimeTxt;

	protected string unionName;

	protected int showPosterGirl;

	protected int showBackground;

	protected bool showCopyInfo;

	private ISubscription<StreamerModeMsg> _streamerModeChanged;

	[Obsolete("instead of using PlayerDataBase.Uid, use RoleViewModel.UserId")]
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

	public string Icon
	{
		get
		{
			return icon;
		}
		protected set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public int IconId => iconId;

	public int IconFrame
	{
		get
		{
			return iconFrame;
		}
		protected set
		{
			Set(ref iconFrame, value, "IconFrame");
		}
	}

	public int Title
	{
		get
		{
			return title;
		}
		protected set
		{
			Set(ref title, value, "Title");
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

	public int CharacterIndex
	{
		get
		{
			return characterIndex;
		}
		protected set
		{
			Set(ref characterIndex, value, "CharacterIndex");
		}
	}

	public int Vip
	{
		get
		{
			return vip;
		}
		protected set
		{
			Set(ref vip, value, "Vip");
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
		}
	}

	public int HomelandLevel
	{
		get
		{
			return homelandLevel;
		}
		protected set
		{
			Set(ref homelandLevel, value, "HomelandLevel");
		}
	}

	public int MaxCopyOpenIndex
	{
		get
		{
			return maxCopyOpenIndex;
		}
		protected set
		{
			Set(ref maxCopyOpenIndex, value, "MaxCopyOpenIndex");
		}
	}

	public long Exp
	{
		get
		{
			return exp;
		}
		protected set
		{
			Set(ref exp, value, "Exp");
		}
	}

	public long MaxExp
	{
		get
		{
			return maxExp;
		}
		protected set
		{
			Set(ref maxExp, value, "MaxExp");
		}
	}

	public int MaxStoryLevel
	{
		get
		{
			return maxSoryLevel;
		}
		protected set
		{
			Set(ref maxSoryLevel, value, "MaxStoryLevel");
		}
	}

	public int WeeklyRank
	{
		get
		{
			return weeklyRank;
		}
		protected set
		{
			Set(ref weeklyRank, value, "WeeklyRank");
		}
	}

	public int Rank
	{
		get
		{
			return rank;
		}
		protected set
		{
			Set(ref rank, value, "Rank");
		}
	}

	public int WeeklyStarCount
	{
		get
		{
			return weeklyStarCount;
		}
		protected set
		{
			Set(ref weeklyStarCount, value, "WeeklyStarCount");
		}
	}

	public List<PbMedalInfo> WearMedals
	{
		get
		{
			return wearMedals;
		}
		set
		{
			Set(ref wearMedals, value, "WearMedals");
		}
	}

	public List<PbCopyChallengeInfo> CopyChallengeInfos
	{
		get
		{
			return copyChallengeInfos;
		}
		set
		{
			Set(ref copyChallengeInfos, value, "CopyChallengeInfos");
		}
	}

	public long CreatTime
	{
		get
		{
			return creatTime;
		}
		set
		{
			Set(ref creatTime, value, "CreatTime");
		}
	}

	public string CreatTimeTxt
	{
		get
		{
			return creatTimeTxt;
		}
		set
		{
			Set(ref creatTimeTxt, value, "CreatTimeTxt");
		}
	}

	public string UnionName
	{
		get
		{
			return unionName;
		}
		set
		{
			Set(ref unionName, value, "UnionName");
		}
	}

	public int ShowPosterGirl
	{
		get
		{
			return showPosterGirl;
		}
		set
		{
			Set(ref showPosterGirl, value, "ShowPosterGirl");
		}
	}

	public int ShowBackground
	{
		get
		{
			return showBackground;
		}
		set
		{
			Set(ref showBackground, value, "ShowBackground");
		}
	}

	public bool ShowCopyInfo
	{
		get
		{
			return showCopyInfo;
		}
		set
		{
			Set(ref showCopyInfo, value, "ShowCopyInfo");
		}
	}

	public PlayerDataBase()
	{
		uid = 0L;
		_streamerModeChanged = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<StreamerModeMsg>(OnStreamerModeChanged);
	}

	public PlayerDataBase(UserBaseInfo userBaseInfo)
	{
		AddUserInfo(userBaseInfo);
		_streamerModeChanged = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<StreamerModeMsg>(OnStreamerModeChanged);
	}

	public static PlayerDataBase Create(long userId, string name, int level, int iconId, int iconFrame)
	{
		return new PlayerDataBase
		{
			Uid = userId,
			Name = name,
			Level = level,
			iconId = iconId,
			Icon = GetIcon(iconId),
			IconFrame = iconFrame
		};
	}

	public void AddUserInfo(UserBaseInfo userBaseInfo)
	{
		Title = userBaseInfo.TitleId;
		iconId = userBaseInfo.Icon;
		Icon = GetIcon(userBaseInfo.Icon);
		IconFrame = userBaseInfo.IconFrame;
		Uid = userBaseInfo.UserId;
		Name = userBaseInfo.Name;
		Vip = userBaseInfo.Vip;
		Level = userBaseInfo.Level;
		Exp = userBaseInfo.Exp;
		MaxStoryLevel = userBaseInfo.MaxStoryLevel;
		WeeklyRank = userBaseInfo.WeeklyCopyRank;
		CharacterIndex = userBaseInfo.Gender - 1;
		MaxExp = GetMaxExp(Level);
		Rank = GetRank(Level);
		HomelandLevel = 1;
		wearMedals = userBaseInfo.WearMedal;
		copyChallengeInfos = InitCopyChallengeInfo(userBaseInfo.CopyChallengeInfo);
		creatTime = userBaseInfo.CreateTime;
		CreatTimeTxt = FormatTimestampToDate(creatTime);
		UnionName = GetUnionName(userBaseInfo.UnionName);
		showPosterGirl = userBaseInfo.ShowPosterGirl;
		showBackground = userBaseInfo.ShowBackground;
		showCopyInfo = userBaseInfo.IsShowCopyInfo;
	}

	private void OnStreamerModeChanged(StreamerModeMsg msg)
	{
		Icon = GetIcon(IconId);
	}

	public List<PbCopyChallengeInfo> InitCopyChallengeInfo(List<PbCopyChallengeInfo> CopyChallengeInfo)
	{
		if (CopyChallengeInfo != null && CopyChallengeInfo.Count >= 2)
		{
			List<PbCopyChallengeInfo> list = CopyChallengeInfo;
			List<PbCopyChallengeInfo> list2 = CopyChallengeInfo;
			PbCopyChallengeInfo pbCopyChallengeInfo = CopyChallengeInfo[1];
			PbCopyChallengeInfo pbCopyChallengeInfo2 = CopyChallengeInfo[0];
			PbCopyChallengeInfo pbCopyChallengeInfo3 = (list[0] = pbCopyChallengeInfo);
			pbCopyChallengeInfo3 = (list2[1] = pbCopyChallengeInfo2);
		}
		return CopyChallengeInfo;
	}

	public static string GetIcon(int iconId)
	{
		DRHeadAvatar dataRow = GameEntry.DataTable.GetDataRow<DRHeadAvatar>(iconId);
		if (dataRow != null)
		{
			bool streamerMode = StreamerMode.GetStreamerMode();
			if (string.IsNullOrEmpty(dataRow.SexIcon))
			{
				return dataRow.Icon;
			}
			if (!streamerMode)
			{
				return dataRow.SexIcon;
			}
			return dataRow.Icon;
		}
		return "";
	}

	protected string GetUnionName(string unionName)
	{
		if (unionName == null || unionName == "")
		{
			return "未加入公会";
		}
		return unionName;
	}

	protected int GetRank(int level)
	{
		return GameEntry.DataTable.GetDataRow<DRAccountGrade>(level)?.Rank ?? 0;
	}

	public string FormatTimestampToDate(long? timestamp)
	{
		if (!timestamp.HasValue || timestamp.Value <= 0)
		{
			return "2025/10/15";
		}
		try
		{
			return DateTimeOffset.FromUnixTimeSeconds(timestamp.Value).LocalDateTime.ToString("yyyy/MM/dd");
		}
		catch (Exception ex)
		{
			Log.Error($"时间戳转换失败: {timestamp}, 错误: {ex.Message}");
			return "未知日期";
		}
	}

	public long GetMaxExp(int level)
	{
		DRAccountGrade dataRow = GameEntry.DataTable.GetDataRow<DRAccountGrade>(level + 1);
		if (dataRow != null)
		{
			return dataRow.NeedExp;
		}
		DRAccountGrade dataRow2 = GameEntry.DataTable.GetDataRow<DRAccountGrade>(level);
		if (dataRow2 == null)
		{
			Log.Error($"AccountGrade等级配置异常{level}！");
			Toast.ShowError($"AccountGrade等级配置异常{level}！");
			return 0L;
		}
		Exp = dataRow2.NeedExp;
		return dataRow2.NeedExp;
	}

	public void ChangeName(string newName)
	{
		Name = newName;
	}

	public void ChangeIcon(int id)
	{
		iconId = id;
		Icon = GetIcon(id);
	}

	public void ChangeIconFrame(int id)
	{
		IconFrame = id;
	}

	public void ChangeTitle(int id)
	{
		Title = id;
	}

	public void SetLevelAndExp(int level, long exp)
	{
		Level = level;
		Exp = exp;
		MaxExp = GetMaxExp(level);
		Rank = GetRank(Level);
	}

	public void ChangeMaxStoryLevel(int level)
	{
		if (MaxStoryLevel < level)
		{
			MaxStoryLevel = level;
		}
	}

	public void SetHomelandLevel(int level)
	{
		HomelandLevel = level;
	}

	protected override void Dispose(bool disposing)
	{
		_streamerModeChanged?.Dispose();
		_streamerModeChanged = null;
		base.Dispose(disposing);
	}
}
