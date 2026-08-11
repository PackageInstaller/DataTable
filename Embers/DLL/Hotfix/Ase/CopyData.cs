using System.Collections.Generic;
using System.Numerics;
using GameFramework.Runtime;

namespace Ase;

public class CopyData : ViewModelBase
{
	private int id;

	private int activityTypeId;

	private int activityId;

	private string name;

	private string desc;

	private bool isMulti;

	private bool isMultiRepeat;

	private bool isBoss;

	private bool isHighDifficulty;

	private int copyType;

	private int copyMainId;

	private string sceneName;

	private string mapData;

	private int navMeshId;

	private List<int> bossIds;

	private List<int> bossTypes;

	private List<int> waves;

	private string bossIcon;

	private string bossIconPath;

	private List<int> buffs;

	private int copyRank;

	private string copyRankName;

	private int advLevel;

	private int taskOpen;

	private int taskIdComplete;

	private int matchTeamLevel;

	private int useEnergy;

	private int drops;

	private int dropRate = -1;

	private bool isLock;

	private bool isLevelLock;

	private bool isTaskLock;

	private bool isPermitLock;

	private bool isType4Lock = true;

	private bool isPreviousOpenLock;

	private bool isAccessed;

	private bool isNeedFirst;

	private int permitLvNeed;

	private int rewardCountMax;

	private string depthsIcon;

	private int depthsEnvironId;

	private int starCur;

	private Dictionary<int, bool> starCondition;

	private int starMax;

	private int starConfigMax;

	private long totalScore;

	private long curScore;

	private int teamSeatId;

	private int propId;

	private string propIcon;

	private int propCount;

	private List<int> enviroEnvironIds;

	private bool hasNew;

	private int copyEnvironId;

	private bool hasPlayUnlock;

	public int Id
	{
		get
		{
			return id;
		}
		private set
		{
			Set(ref id, value, "Id");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public bool IsMulti
	{
		get
		{
			return isMulti;
		}
		private set
		{
			Set(ref isMulti, value, "IsMulti");
		}
	}

	public bool IsMultiRepeat
	{
		get
		{
			return isMultiRepeat;
		}
		private set
		{
			Set(ref isMultiRepeat, value, "IsMultiRepeat");
		}
	}

	public bool IsBoss
	{
		get
		{
			return isBoss;
		}
		private set
		{
			Set(ref isBoss, value, "IsBoss");
		}
	}

	public int CopyType
	{
		get
		{
			return copyType;
		}
		private set
		{
			Set(ref copyType, value, "CopyType");
		}
	}

	public string SceneName
	{
		get
		{
			return sceneName;
		}
		private set
		{
			Set(ref sceneName, value, "SceneName");
		}
	}

	public string MapData
	{
		get
		{
			return mapData;
		}
		private set
		{
			Set(ref mapData, value, "MapData");
		}
	}

	public int NavMeshId
	{
		get
		{
			return navMeshId;
		}
		private set
		{
			Set(ref navMeshId, value, "NavMeshId");
		}
	}

	public bool HasNew
	{
		get
		{
			return hasNew;
		}
		private set
		{
			Set(ref hasNew, value, "HasNew");
		}
	}

	public List<int> BossIds => bossIds;

	public List<int> BossTypes => bossTypes;

	public List<int> Waves => waves;

	public string BossIcon => bossIcon;

	public string BossIconPath
	{
		get
		{
			if (!string.IsNullOrEmpty(bossIconPath))
			{
				return bossIconPath;
			}
			return GetBossIconPath(copyMainId);
		}
	}

	public List<int> Buffs => buffs;

	public int CopyRank
	{
		get
		{
			return copyRank;
		}
		private set
		{
			Set(ref copyRank, value, "CopyRank");
		}
	}

	public string CopyRankName
	{
		get
		{
			return copyRankName;
		}
		private set
		{
			Set(ref copyRankName, value, "CopyRankName");
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

	public int TaskOpen
	{
		get
		{
			return taskOpen;
		}
		private set
		{
			Set(ref taskOpen, value, "TaskOpen");
		}
	}

	public int TaskIdComplete
	{
		get
		{
			return taskIdComplete;
		}
		private set
		{
			Set(ref taskIdComplete, value, "TaskIdComplete");
		}
	}

	public int MatchTeamLevel
	{
		get
		{
			return matchTeamLevel;
		}
		private set
		{
			Set(ref matchTeamLevel, value, "MatchTeamLevel");
		}
	}

	public int UseEnergy
	{
		get
		{
			return useEnergy;
		}
		private set
		{
			Set(ref useEnergy, value, "UseEnergy");
		}
	}

	public int DropRate
	{
		get
		{
			return dropRate;
		}
		private set
		{
			Set(ref dropRate, value, "DropRate");
		}
	}

	public int Drops
	{
		get
		{
			return drops;
		}
		private set
		{
			Set(ref drops, value, "Drops");
		}
	}

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		private set
		{
			Set(ref isLock, value, "IsLock");
		}
	}

	public bool HasPlayUnlock
	{
		get
		{
			return hasPlayUnlock;
		}
		private set
		{
			Set(ref hasPlayUnlock, value, "HasPlayUnlock");
		}
	}

	public bool IsAccessed
	{
		get
		{
			return isAccessed;
		}
		private set
		{
			Set(ref isAccessed, value, "IsAccessed");
		}
	}

	public bool IsNeedFirst
	{
		get
		{
			return isNeedFirst;
		}
		private set
		{
			Set(ref isNeedFirst, value, "IsNeedFirst");
		}
	}

	public bool IsHighDifficulty
	{
		get
		{
			return isHighDifficulty;
		}
		private set
		{
			Set(ref isHighDifficulty, value, "IsHighDifficulty");
		}
	}

	public int PermitLvNeed
	{
		get
		{
			return permitLvNeed;
		}
		private set
		{
			Set(ref permitLvNeed, value, "PermitLvNeed");
		}
	}

	public int RewardCountMax
	{
		get
		{
			return rewardCountMax;
		}
		private set
		{
			Set(ref rewardCountMax, value, "RewardCountMax");
		}
	}

	public string DepthsIcon
	{
		get
		{
			return depthsIcon;
		}
		private set
		{
			Set(ref depthsIcon, value, "DepthsIcon");
		}
	}

	public int DepthsEnvironId
	{
		get
		{
			return depthsEnvironId;
		}
		private set
		{
			Set(ref depthsEnvironId, value, "DepthsEnvironId");
		}
	}

	public int StarConfigMax
	{
		get
		{
			return starConfigMax;
		}
		private set
		{
			Set(ref starConfigMax, value, "StarConfigMax");
		}
	}

	public int StarMax
	{
		get
		{
			return starMax;
		}
		private set
		{
			Set(ref starMax, value, "StarMax");
		}
	}

	public int StarCur
	{
		get
		{
			return starCur;
		}
		private set
		{
			Set(ref starCur, value, "StarCur");
		}
	}

	public int PropCount
	{
		get
		{
			return propCount;
		}
		private set
		{
			Set(ref propCount, value, "PropCount");
		}
	}

	public string PropIcon
	{
		get
		{
			return propIcon;
		}
		private set
		{
			Set(ref propIcon, value, "PropIcon");
		}
	}

	public Dictionary<int, bool> StarCondition => starCondition;

	public long TotalScore
	{
		get
		{
			return totalScore;
		}
		private set
		{
			Set(ref totalScore, value, "TotalScore");
		}
	}

	public long CurScore
	{
		get
		{
			return curScore;
		}
		private set
		{
			Set(ref curScore, value, "CurScore");
		}
	}

	public bool IsTaskLock => isTaskLock;

	public bool IsLevelLock => isLevelLock;

	public bool IsPermitLock => isPermitLock;

	public bool IsPreviousOpenLock => isPreviousOpenLock;

	public int CopyMainId => copyMainId;

	public int CopyEnvironId => copyEnvironId;

	public int CopyBuff => CopyEnvironId;

	public int ActivityTypeId => activityTypeId;

	public int ActivityId => activityId;

	public int TeamSeatId => teamSeatId;

	public List<int> EnviroEnvironIds => enviroEnvironIds;

	public static CopyData Create(DRCopy drCopy, int mainId, int permitLevel, int playerLevel, long copyOpenIndex, int maxRewardCount, bool isAccess)
	{
		CopyData copyData = new CopyData();
		copyData.id = drCopy.Id;
		copyData.name = drCopy.Name;
		copyData.desc = drCopy.Desc?.Replace("\\n", "\n");
		copyData.copyMainId = mainId;
		copyData.bossIconPath = GetBossIconPath(mainId);
		copyData.isBoss = drCopy.IsBoss;
		copyData.isMulti = drCopy.IsMulti;
		copyData.isMultiRepeat = drCopy.IsRepeat;
		copyData.isHighDifficulty = drCopy.IsHighDifficulty;
		copyData.copyType = drCopy.CopyType;
		copyData.sceneName = drCopy.SceneName;
		copyData.mapData = drCopy.MapData;
		copyData.navMeshId = drCopy.NavMeshId;
		copyData.bossIds = drCopy.BossId;
		copyData.bossTypes = drCopy.BossType;
		copyData.waves = drCopy.Wave;
		copyData.bossIcon = drCopy.BossIcon;
		copyData.buffs = drCopy.Buff;
		copyData.buffs.Sort((int a, int b) => b.CompareTo(a));
		copyData.copyRank = drCopy.CopyRank;
		copyData.copyRankName = drCopy.CopyRankName;
		copyData.advLevel = drCopy.AdvLevel;
		copyData.taskOpen = drCopy.Open;
		copyData.taskIdComplete = drCopy.TaskCompleted;
		copyData.matchTeamLevel = drCopy.MatchTeamLevel;
		if (drCopy.CostId == 6)
		{
			copyData.useEnergy = drCopy.CostNum;
		}
		else
		{
			copyData.useEnergy = drCopy.CostNum;
		}
		copyData.drops = drCopy.Drops;
		copyData.permitLvNeed = drCopy.PermitLvNeed;
		copyData.rewardCountMax = maxRewardCount;
		copyData.teamSeatId = drCopy.TeamSet;
		copyData.isLevelLock = copyData.AdvLevel > playerLevel;
		copyData.isTaskLock = copyOpenIndex < copyData.taskOpen;
		copyData.isPermitLock = permitLevel < copyData.PermitLvNeed;
		copyData.isLock = copyData.isLevelLock || copyData.isTaskLock || copyData.isPermitLock || copyData.isPreviousOpenLock || (copyData.copyMainId == 4 && copyData.isType4Lock);
		copyData.isAccessed = isAccess;
		copyData.isNeedFirst = drCopy.IsNeedFirst;
		copyData.depthsEnvironId = drCopy.DepthsBuff;
		copyData.depthsIcon = drCopy.DepthsIcon;
		copyData.copyEnvironId = drCopy.CopyBuff;
		DRStarCondition[] dataRows = GameEntry.DataTable.GetDataRows((DRStarCondition p) => p.CopyId == drCopy.Id);
		if (dataRows != null)
		{
			copyData.starConfigMax = dataRows.Length;
		}
		return copyData;
	}

	public static CopyData CreateActivityCopy(DRCopy drCopy, int activityTypeId)
	{
		CopyData copyData = new CopyData();
		copyData.id = drCopy.Id;
		copyData.name = drCopy.Name;
		copyData.desc = drCopy.Desc;
		DRCopyType dataRow = GameEntry.DataTable.GetDataRow((DRCopyType p) => p.Id == drCopy.CopyType);
		if (dataRow != null)
		{
			copyData.copyMainId = dataRow.MainCopyId;
			copyData.bossIconPath = GetBossIconPath(copyData.copyMainId);
		}
		copyData.isBoss = drCopy.IsBoss;
		copyData.isMulti = drCopy.IsMulti;
		copyData.isMultiRepeat = drCopy.IsRepeat;
		copyData.isHighDifficulty = false;
		copyData.copyType = drCopy.CopyType;
		copyData.sceneName = "";
		copyData.mapData = "";
		copyData.navMeshId = 0;
		copyData.bossIds = null;
		copyData.bossTypes = null;
		copyData.waves = null;
		copyData.bossIcon = ((drCopy.BossIcon == null) ? "" : drCopy.BossIcon);
		copyData.buffs = drCopy.Buff;
		copyData.buffs.Sort((int a, int b) => b.CompareTo(a));
		copyData.copyRank = drCopy.CopyRank;
		copyData.copyRankName = "";
		copyData.advLevel = 0;
		copyData.taskOpen = 0;
		copyData.taskIdComplete = 0;
		copyData.matchTeamLevel = drCopy.MatchTeamLevel;
		copyData.useEnergy = 0;
		copyData.drops = drCopy.Drops;
		copyData.permitLvNeed = 0;
		copyData.isNeedFirst = false;
		copyData.teamSeatId = drCopy.TeamSet;
		copyData.depthsEnvironId = 0;
		copyData.depthsIcon = "";
		copyData.activityTypeId = activityTypeId;
		DRStarCondition[] dataRows = GameEntry.DataTable.GetDataRows((DRStarCondition p) => p.CopyId == drCopy.Id);
		if (dataRows != null)
		{
			copyData.starConfigMax = dataRows.Length;
		}
		return copyData;
	}

	public static CopyData CreateTemp(DRCopy drCopy)
	{
		CopyData copyData = new CopyData();
		copyData.id = drCopy.Id;
		copyData.name = drCopy.Name;
		copyData.desc = drCopy.Desc;
		copyData.isBoss = drCopy.IsBoss;
		copyData.isMulti = drCopy.IsMulti;
		copyData.isMultiRepeat = drCopy.IsRepeat;
		copyData.isHighDifficulty = drCopy.IsHighDifficulty;
		copyData.copyType = drCopy.CopyType;
		copyData.sceneName = drCopy.SceneName;
		copyData.mapData = drCopy.MapData;
		copyData.navMeshId = drCopy.NavMeshId;
		copyData.bossIds = drCopy.BossId;
		copyData.bossTypes = drCopy.BossType;
		copyData.waves = drCopy.Wave;
		copyData.bossIcon = ((drCopy.BossIcon == null) ? "" : drCopy.BossIcon);
		copyData.buffs = drCopy.Buff;
		copyData.buffs.Sort((int a, int b) => b.CompareTo(a));
		copyData.copyRank = drCopy.CopyRank;
		copyData.copyRankName = drCopy.CopyRankName;
		copyData.advLevel = drCopy.AdvLevel;
		copyData.taskOpen = drCopy.Open;
		copyData.taskIdComplete = drCopy.TaskCompleted;
		copyData.matchTeamLevel = drCopy.MatchTeamLevel;
		if (drCopy.CostId == 6)
		{
			copyData.useEnergy = drCopy.CostNum;
		}
		else
		{
			copyData.useEnergy = drCopy.CostNum;
		}
		copyData.drops = drCopy.Drops;
		copyData.permitLvNeed = drCopy.PermitLvNeed;
		copyData.isNeedFirst = drCopy.IsNeedFirst;
		copyData.teamSeatId = drCopy.TeamSet;
		copyData.depthsEnvironId = drCopy.DepthsBuff;
		copyData.depthsIcon = drCopy.DepthsIcon;
		DRCopyType dataRow = GameEntry.DataTable.GetDataRow((DRCopyType p) => p.Id == drCopy.CopyType);
		if (dataRow != null)
		{
			copyData.copyMainId = dataRow.MainCopyId;
			copyData.bossIconPath = GetBossIconPath(copyData.copyMainId);
		}
		copyData.copyEnvironId = drCopy.CopyBuff;
		DRStarCondition[] dataRows = GameEntry.DataTable.GetDataRows((DRStarCondition p) => p.CopyId == drCopy.Id);
		if (dataRows != null)
		{
			copyData.starConfigMax = dataRows.Length;
		}
		return copyData;
	}

	public static CopyData CreateActivityCopy(DRVersionActivity versionActivity, DRCopy drCopy)
	{
		CopyData copyData = CreateTemp(drCopy);
		DRCopyType dataRow = GameEntry.DataTable.GetDataRow<DRCopyType>(drCopy.CopyType);
		if (dataRow != null)
		{
			copyData.copyMainId = dataRow.MainCopyId;
			copyData.bossIconPath = GetBossIconPath(copyData.copyMainId);
		}
		copyData.activityTypeId = versionActivity.ActivityId;
		copyData.activityId = versionActivity.Id;
		copyData.propId = versionActivity.ConsumeId;
		copyData.propCount = versionActivity.ConsumeNum;
		DRProp dataRow2 = GameEntry.DataTable.GetDataRow((DRProp p) => p.Id == versionActivity.ConsumeId);
		if (dataRow2 != null)
		{
			copyData.propIcon = dataRow2.Icon;
		}
		return copyData;
	}

	public static CopyData CreateActivityCopy(DRActivityTry activityTry, DRCopy drCopy)
	{
		CopyData copyData = CreateTemp(drCopy);
		DRCopyType dataRow = GameEntry.DataTable.GetDataRow<DRCopyType>(drCopy.CopyType);
		if (dataRow != null)
		{
			copyData.copyMainId = dataRow.MainCopyId;
			copyData.bossIconPath = GetBossIconPath(copyData.copyMainId);
		}
		copyData.activityTypeId = activityTry.ActivityTypeId;
		copyData.activityId = activityTry.Id;
		return copyData;
	}

	public static CopyData CreateActivityChallengeCopy(DRCopy drCopy, DRChallengeCopy challengeCopy, int activityTypeId, int playerLevel, long copyOpenIndex)
	{
		CopyData copyData = CreateTemp(drCopy);
		DRCopyType dataRow = GameEntry.DataTable.GetDataRow<DRCopyType>(drCopy.CopyType);
		if (dataRow != null)
		{
			copyData.copyMainId = dataRow.MainCopyId;
			copyData.bossIconPath = GetBossIconPath(copyData.copyMainId);
		}
		copyData.activityTypeId = activityTypeId;
		copyData.activityId = challengeCopy.ActivityId;
		copyData.enviroEnvironIds = challengeCopy.Buff;
		copyData.advLevel = drCopy.AdvLevel;
		copyData.taskOpen = drCopy.Open;
		copyData.isLevelLock = copyData.AdvLevel > playerLevel;
		copyData.isTaskLock = copyOpenIndex < copyData.taskOpen;
		copyData.IsLock = copyData.isLevelLock || copyData.isTaskLock;
		return copyData;
	}

	public void RefreshActivityChallenge(DRChallengeCopy challengeCopy, int activtityTypeId)
	{
		activityTypeId = activtityTypeId;
		activityId = challengeCopy.ActivityId;
		enviroEnvironIds = challengeCopy.Buff;
	}

	public static CopyData CreateActivityEquipCopy(DRCopy drCopy, DRCopyKit copyKit, int activityTypeId, int playerLevel)
	{
		CopyData copyData = CreateTemp(drCopy);
		DRCopyType dataRow = GameEntry.DataTable.GetDataRow<DRCopyType>(drCopy.CopyType);
		if (dataRow != null)
		{
			copyData.copyMainId = dataRow.MainCopyId;
			copyData.bossIconPath = GetBossIconPath(copyData.copyMainId);
		}
		copyData.activityTypeId = activityTypeId;
		copyData.enviroEnvironIds = copyKit.LvBuff;
		copyData.advLevel = drCopy.AdvLevel;
		copyData.isLevelLock = copyData.AdvLevel > playerLevel;
		copyData.IsLock = copyData.isLevelLock || copyData.isTaskLock;
		return copyData;
	}

	public void RefreshActivityEquip(DRCopyKit copyKit, int activtityTypeId)
	{
		activityTypeId = activtityTypeId;
		enviroEnvironIds = copyKit.LvBuff;
	}

	public int SetStarCondition(int star)
	{
		if (starCondition == null)
		{
			starCondition = new Dictionary<int, bool>();
		}
		starCondition.Clear();
		int num = 0;
		for (int i = 0; i < starConfigMax; i++)
		{
			starCondition.Add(i, Bitwise(star, i));
			if (starCondition[i])
			{
				num++;
			}
		}
		return num;
	}

	public int SetStarConditionType4(int star)
	{
		if (starCondition == null)
		{
			starCondition = new Dictionary<int, bool>();
		}
		starCondition.Clear();
		for (int i = 0; i < starConfigMax; i++)
		{
			starCondition.Add(i, star > i);
		}
		return star;
	}

	public int GetStarCount(int star)
	{
		return BitOperations.PopCount((uint)star);
	}

	public void SetStarAndScore(int star, int score)
	{
		StarCur = star;
		CurScore = score;
		IsAccessed = starCur > 0 || curScore > 0;
	}

	public void CopyAccess(int star)
	{
		isAccessed = true;
		int starCount = GetStarCount(star);
		if (starCount > starCur)
		{
			StarCur = starCount;
			SetStarCondition(star);
		}
		if (starMax < starCur)
		{
			StarMax = StarCur;
		}
	}

	public void SetCopyStar(int cur, int max)
	{
		starCur = SetStarConditionType4(cur);
		starMax = max;
		if (starCur == 0)
		{
			isAccessed = false;
		}
	}

	public void UpdatePlayerLevel(int playerLevel)
	{
		bool islockTemp = isLock;
		isLevelLock = advLevel > playerLevel;
		IsLock = isLevelLock || isTaskLock || isPermitLock || isPreviousOpenLock || (copyMainId == 4 && isType4Lock);
		CheckCopyRed(islockTemp);
	}

	public void UpdateTaskProgress(long copyOpenIndex)
	{
		bool islockTemp = isLock;
		isTaskLock = copyOpenIndex < taskOpen;
		IsLock = isLevelLock || isTaskLock || isPermitLock || isPreviousOpenLock || (copyMainId == 4 && isType4Lock);
		CheckCopyRed(islockTemp);
	}

	public void UpdatePermitLevel(int permitLevel)
	{
		isPermitLock = false;
	}

	public void UpdatePreviousOpen(int maxOpenRankPass, bool forceCheck = false)
	{
		bool islockTemp = isLock;
		if (forceCheck)
		{
			isPreviousOpenLock = copyRank > maxOpenRankPass;
		}
		else if (copyMainId != 2 || (copyRank == 1 && copyMainId == 2))
		{
			isPreviousOpenLock = false;
		}
		else
		{
			isPreviousOpenLock = copyRank > maxOpenRankPass;
		}
		IsLock = isLevelLock || isTaskLock || isPermitLock || isPreviousOpenLock || (copyMainId == 4 && isType4Lock);
		CheckCopyRed(islockTemp);
	}

	public void UpdatePreviousOpen(bool isPreviousLock)
	{
		bool islockTemp = isLock;
		isPreviousOpenLock = isPreviousLock;
		IsLock = isLevelLock || isTaskLock || isPermitLock || isPreviousOpenLock || (copyMainId == 4 && isType4Lock);
		CheckCopyRed(islockTemp);
	}

	public void UpdateType4UnLock()
	{
		if (copyMainId == 4)
		{
			isType4Lock = false;
			IsLock = isLevelLock || isTaskLock || isPermitLock || (copyMainId == 4 && isType4Lock);
		}
	}

	private void CheckCopyRed(bool islockTemp)
	{
		if (!(!isLock & islockTemp))
		{
			return;
		}
		if (copyMainId == 3)
		{
			if (Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().CopyType3CurId == copyType)
			{
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().UpdateSingleCopyRed(this, isRed: true);
			}
		}
		else if (copyMainId == 1 || copyMainId == 2)
		{
			int copyType1_2CopyMaxOpenRank = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyType1_2CopyMaxOpenRank(this);
			if (copyRank <= copyType1_2CopyMaxOpenRank)
			{
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().UpdateSingleCopyRed(this, isRed: true);
			}
		}
	}

	public void SetDropRate(int rate)
	{
		DropRate = rate;
	}

	public static int GetServiceCopyType(int dropRate, bool isFirstPass)
	{
		if (dropRate != 0 || isFirstPass)
		{
			return 1;
		}
		return 3;
	}

	public void SetRed(bool hasNew)
	{
		HasNew = hasNew;
	}

	public int GetBossId(int index)
	{
		if (bossIds == null)
		{
			return 0;
		}
		if (bossIds.Count > index)
		{
			return bossIds[index];
		}
		return 0;
	}

	public void PlayUnlockEffect()
	{
		HasPlayUnlock = true;
	}

	public void ResetPlayUnlockEffect()
	{
		HasPlayUnlock = false;
	}

	public void SetPlayUnlockEffect(bool playEffect)
	{
		HasPlayUnlock = playEffect;
	}

	public void AddType5Buff(int environId)
	{
		if (enviroEnvironIds == null)
		{
			enviroEnvironIds = new List<int>();
		}
		else
		{
			enviroEnvironIds.Clear();
		}
		enviroEnvironIds.Add(environId);
	}

	public bool HasFirstBuff()
	{
		if (!isNeedFirst || !isAccessed)
		{
			return !isNeedFirst;
		}
		return true;
	}

	public List<int> GetAllHeroBuff()
	{
		return GetBuffType(EnvironmentModifierTargetType.Hero);
	}

	public List<int> GetAllHeroBT()
	{
		return GetBTType(EnvironmentModifierTargetType.Hero);
	}

	public List<int> GetAllMonsterBuff()
	{
		return GetBuffType(EnvironmentModifierTargetType.Monster);
	}

	public List<int> GetAllMonsterBT()
	{
		return GetBTType(EnvironmentModifierTargetType.Monster);
	}

	public List<int> GetBossBuff()
	{
		return GetBuffType(EnvironmentModifierTargetType.Boss);
	}

	public List<int> GetBossBT()
	{
		return GetBTType(EnvironmentModifierTargetType.Boss);
	}

	private List<int> GetBuffType(EnvironmentModifierTargetType targetType)
	{
		return GetEnvironmentEffectType(targetType, EnvironmentModifierType.Buff);
	}

	private List<int> GetBTType(EnvironmentModifierTargetType targetType)
	{
		return GetEnvironmentEffectType(targetType, EnvironmentModifierType.Paradox);
	}

	private List<int> GetEnvironmentEffectType(EnvironmentModifierTargetType targetType, EnvironmentModifierType environmentType)
	{
		List<int> list = new List<int>();
		AddEnvironmentEffectIfTarget(list, depthsEnvironId, targetType, environmentType);
		if (enviroEnvironIds != null && enviroEnvironIds.Count > 0)
		{
			for (int i = 0; i < enviroEnvironIds.Count; i++)
			{
				AddEnvironmentEffectIfTarget(list, enviroEnvironIds[i], targetType, environmentType);
			}
		}
		return list;
	}

	private void AddEnvironmentEffectIfTarget(List<int> effectList, int environId, EnvironmentModifierTargetType targetType, EnvironmentModifierType environmentType)
	{
		if (environId == 0)
		{
			return;
		}
		DREnvironmentModifier config = EnvironmentModifierHelper.GetConfig(environId);
		if (config != null && IsEnvironmentTargetMatched(config.TargetType, targetType) && EnvironmentModifierHelper.GetEnvironmentType(config) == environmentType)
		{
			int num = ((environmentType == EnvironmentModifierType.Buff) ? config.BuffId : config.ParadoxId);
			if (num != 0)
			{
				effectList.Add(num);
			}
		}
	}

	private bool IsEnvironmentTargetMatched(int modifierTargetType, EnvironmentModifierTargetType targetType)
	{
		if (modifierTargetType == (int)targetType)
		{
			return true;
		}
		if (targetType == EnvironmentModifierTargetType.Boss)
		{
			return modifierTargetType == 1;
		}
		return false;
	}

	private static string GetBossIconPath(int mainId)
	{
		if (mainId == 1)
		{
			return "CopySceneImgType1";
		}
		_ = 3;
		return "CopySceneImgOther";
	}

	public List<int> GetBuffsReverseOrder()
	{
		if (buffs == null || buffs.Count == 0)
		{
			return new List<int>();
		}
		List<int> list = new List<int>(buffs.Count);
		for (int num = buffs.Count - 1; num >= 0; num--)
		{
			list.Add(buffs[num]);
		}
		return list;
	}

	public void ResetAccess()
	{
		IsAccessed = false;
		StarCur = 0;
	}

	public void ResetMax()
	{
		StarMax = 0;
	}

	private bool Bitwise(int num, int index)
	{
		return (num & (1 << index)) > 0;
	}

	public void SetCurScore(long val)
	{
		if (val > curScore)
		{
			CurScore = val;
		}
		SetTotalScore(val);
	}

	public void ResetCurScore(long val)
	{
		CurScore = val;
		SetTotalScore(val);
	}

	public void SetTotalScore(long val)
	{
		if (val > totalScore)
		{
			TotalScore = val;
		}
	}

	public void ResetCurScore()
	{
		CurScore = 0L;
	}
}
