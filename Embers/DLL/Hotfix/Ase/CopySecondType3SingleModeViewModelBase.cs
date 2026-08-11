#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Unity.Mathematics;

namespace Ase;

public abstract class CopySecondType3SingleModeViewModelBase : CopyEnterViewModel
{
	private const int FirePowerRankType = 10;

	private const int ExtremeRankType = 6;

	private const int DefaultRankTarget = 0;

	private const int FirePowerHeroChallengeRequestType = 1;

	private const int ExtremeHeroChallengeRequestType = 2;

	private readonly CopyType3Mode mode;

	private readonly SimpleCommand<string> optCommand;

	private readonly InteractionRequest<string> optRequest = new InteractionRequest<string>();

	private readonly List<CopyRankItemViewModel> rankItemVms = new List<CopyRankItemViewModel>();

	private readonly List<int> adItemList = new List<int>();

	private CopyData copyData;

	private CopyType3RankRequestData rankRequestData;

	private string copyName;

	private string currentHeroName;

	private string bossIconPath;

	private string bossDesc;

	private string scoreText;

	private int selfRankScore;

	private int selfRankPosition;

	private DateTime lastRankRefreshTime = DateTime.MinValue;

	private bool isRankLoading;

	private int cachedCopyId;

	private int cachedRankTypeId;

	private int cachedRankTarget;

	private int cachedHeroId;

	private int rankRequestVersion;

	protected abstract string ModeNameText { get; }

	protected abstract string RuleDescText { get; }

	protected virtual int RankDisplayCount => 3;

	protected virtual bool UseType5StyleRankDisplay => false;

	protected virtual int RankCacheDurationSeconds => 30;

	protected virtual TimeSpan RankCacheDuration => TimeSpan.FromSeconds(RankCacheDurationSeconds);

	protected int HeroChallengeRequestType => mode switch
	{
		CopyType3Mode.FirePower => 1, 
		CopyType3Mode.ExtremeChallenge => 2, 
		_ => 0, 
	};

	protected CopyType3RankRequestData RankRequestData => rankRequestData;

	protected CopyData CopyData => copyData;

	protected CopyType3Mode Mode => mode;

	protected int ModeScore => Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetType3ModeScore(mode);

	protected int SelfRankScore => selfRankScore;

	protected int SelfRankPosition => selfRankPosition;

	public virtual bool UseType5RankDisplay => UseType5StyleRankDisplay;

	public bool IsRankLoading => isRankLoading;

	public ICommand OptCommand => optCommand;

	public IInteractionRequest OptRequest => optRequest;

	public List<CopyRankItemViewModel> RankItemVms => rankItemVms;

	public string ModeName => ModeNameText;

	public string RuleDesc => RuleDescText;

	public string CurrentHeroName
	{
		get
		{
			return currentHeroName;
		}
		protected set
		{
			Set(ref currentHeroName, value, "CurrentHeroName");
		}
	}

	public virtual string PrimaryResultText => string.Empty;

	public virtual string SecondaryResultText => string.Empty;

	public string ScoreText
	{
		get
		{
			return scoreText;
		}
		protected set
		{
			Set(ref scoreText, value, "ScoreText");
		}
	}

	public bool ShowSecondaryResultText => !string.IsNullOrEmpty(SecondaryResultText);

	public List<int> AdItemList => adItemList;

	public string CopyName
	{
		get
		{
			return copyName;
		}
		protected set
		{
			Set(ref copyName, value, "CopyName");
		}
	}

	public string BossIconPath
	{
		get
		{
			return bossIconPath;
		}
		protected set
		{
			Set(ref bossIconPath, value, "BossIconPath");
		}
	}

	public string BossDesc
	{
		get
		{
			return bossDesc;
		}
		protected set
		{
			Set(ref bossDesc, value, "BossDesc");
		}
	}

	protected CopySecondType3SingleModeViewModelBase(OptionBase parent, CopyType3Mode mode)
	{
		base.parent = parent;
		this.mode = mode;
		optCommand = new SimpleCommand<string>(OnOpt);
		RefreshModeData(clearCacheWhenContextChanged: true);
		RefreshResultDisplayData();
	}

	public override void ItemOnClick(object obj)
	{
		if ("OpenSingle".Equals(obj))
		{
			OpenBattleReady();
		}
		else if ("ReturnSingle".Equals(obj))
		{
			OnBattleReadyClosed(forceRefresh: true);
		}
		else
		{
			base.ItemOnClick(obj);
		}
	}

	public override void RefreshWhenBack(ViewBackArg arg)
	{
		base.RefreshWhenBack(arg);
		BattleReadyViewModel battleReadyViewModel = arg?.Obj as BattleReadyViewModel;
		bool flag = battleReadyViewModel != null;
		bool flag2 = arg?.Obj is LoadingBackToMainViewModel;
		if ((flag || flag2) && (!flag || battleReadyViewModel.ReadyType != BattleReadyType.Ready))
		{
			OnBattleReadyClosed(flag2);
		}
	}

	public virtual void OnPageActivated()
	{
		RefreshRankDisplay(CopyType3SingleRankRefreshReason.PageActivated);
	}

	protected virtual void OnBattleReadyClosed(bool forceRefresh)
	{
		RefreshRankDisplay(forceRefresh ? CopyType3SingleRankRefreshReason.BattleReturn : CopyType3SingleRankRefreshReason.TeamReturn);
	}

	protected void RefreshModeData(bool clearCacheWhenContextChanged)
	{
		copyData = GetCurrentModeCopyData();
		rankRequestData = BuildRankRequestData();
		CopyName = GetBossNameAndLevel(copyData);
		BossDesc = copyData?.Desc ?? "暂无副本说明";
		BossIconPath = (string.IsNullOrEmpty(copyData?.BossIcon) ? string.Empty : (copyData.BossIconPath + "/" + copyData.BossIcon));
		adItemList.Clear();
		if (copyData?.Buffs != null && copyData.Buffs.Count > 0)
		{
			adItemList.AddRange(copyData.Buffs);
		}
		if (clearCacheWhenContextChanged && !HasCurrentRankCache())
		{
			ClearRankDisplayCache();
		}
	}

	private void OnOpt(string optName)
	{
		if (optName.Equals("Back"))
		{
			if (parent is CopySecondType3ViewModel copySecondType3ViewModel)
			{
				copySecondType3ViewModel.SwitchPage(CopyType3Page.Entry);
			}
		}
		else if (optName.Equals("Rank"))
		{
			OpenRank();
		}
		else if (optName.Equals("Challenge"))
		{
			OpenBattleReady();
		}
	}

	private CopyType3RankRequestData BuildRankRequestData()
	{
		IRankService service = Singleton<ServiceSystem>.Instance.GetService<IRankService>();
		if (!TryGetSingleModeRankConfig(mode, out var rankTypeId, out var rankTarget))
		{
			return null;
		}
		int singleModeRankHeroId = GetSingleModeRankHeroId(mode, service);
		return new CopyType3RankRequestData(rankTypeId, rankTarget, singleModeRankHeroId);
	}

	private static bool TryGetSingleModeRankConfig(CopyType3Mode mode, out int rankTypeId, out int rankTarget)
	{
		switch (mode)
		{
		case CopyType3Mode.FirePower:
			return TryGetLatestSingleModeRankConfig(10, out rankTypeId, out rankTarget);
		case CopyType3Mode.ExtremeChallenge:
			return TryGetLatestSingleModeRankConfig(6, out rankTypeId, out rankTarget);
		default:
			rankTypeId = 0;
			rankTarget = 0;
			return false;
		}
	}

	private static bool TryGetLatestSingleModeRankConfig(int rankType, out int rankTypeId, out int rankTarget)
	{
		rankTypeId = 0;
		rankTarget = 0;
		DRRankType[] dataRows = GameEntry.DataTable.GetDataRows((DRRankType p) => p.Type == rankType);
		if (dataRows == null || dataRows.Length == 0)
		{
			return false;
		}
		DRRankType latestRankType = null;
		for (int num = 0; num < dataRows.Length; num++)
		{
			RankDefinition.RankState rankState = RankDefinition.GetRankState(dataRows[num].StartTime, dataRows[num].EndTime, dataRows[num].OffTime);
			if ((rankState == RankDefinition.RankState.InProgress || rankState == RankDefinition.RankState.AlreadySettled) && (latestRankType == null || dataRows[num].Id > latestRankType.Id))
			{
				latestRankType = dataRows[num];
			}
		}
		if (latestRankType == null)
		{
			return false;
		}
		DRRank[] dataRows2 = GameEntry.DataTable.GetDataRows((DRRank p) => p.RankType == latestRankType.Id);
		if (dataRows2 == null || dataRows2.Length == 0)
		{
			return false;
		}
		rankTypeId = latestRankType.Id;
		rankTarget = dataRows2[0].RankTarget;
		for (int num2 = 0; num2 < dataRows2.Length; num2++)
		{
			if (dataRows2[num2].RankTarget == 0)
			{
				rankTarget = dataRows2[num2].RankTarget;
				break;
			}
		}
		return true;
	}

	private static int GetSingleModeRankHeroId(CopyType3Mode mode, IRankService rankService)
	{
		int num = mode switch
		{
			CopyType3Mode.FirePower => Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetHeroIdForCopyType3FirePower(), 
			CopyType3Mode.ExtremeChallenge => Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetHeroIdForHeroChallenge(), 
			_ => 0, 
		};
		if (num != 0)
		{
			return num;
		}
		return 1104;
	}

	protected virtual int GetCurrentHeroIdForDisplay()
	{
		return GetSingleModeRankHeroId(mode, Singleton<ServiceSystem>.Instance.GetService<IRankService>());
	}

	protected string GetModeScoreText()
	{
		if (ModeScore <= 0)
		{
			return "0";
		}
		return ModeScore.ToString();
	}

	public virtual async void OpenRank()
	{
		try
		{
			if (rankRequestData == null || rankRequestData.RankTypeId == 0)
			{
				Toast.ShowInfo((mode == CopyType3Mode.FirePower) ? "火力试炼排行榜待服务端配置开放" : "极限挑战排行榜未开放");
				return;
			}
			GameEntry.DataTable.GetDataRow<DRRankType>(rankRequestData.RankTypeId);
			GameEntry.DataTable.GetDataRows((DRRank p) => p.RankType == rankRequestData.RankTypeId && p.RankTarget == rankRequestData.RankTarget);
			Singleton<ServiceSystem>.Instance.GetService<IRankService>().SetHeroChallengeIdForRank(rankRequestData.HeroId);
			RankViewModel rankVm = new RankViewModel(this, rankRequestData.RankTypeId, rankRequestData.RankTarget);
			await rankVm.RequestHeroChallengeData();
			parent?.ItemOnClick(new OpenViewArg(typeof(RankWindow), rankVm));
		}
		catch (Exception ex)
		{
			Log.Error("打开排行榜失败！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	public void OpenBattleReady()
	{
		if (copyData == null)
		{
			Toast.ShowInfo("当前模式副本未配置");
			return;
		}
		try
		{
			BattleReadyTarget target = ((mode == CopyType3Mode.FirePower) ? BattleReadyTarget.CopyType3FirePower : BattleReadyTarget.HeroChallenge);
			BattleReadyViewModel userData = new BattleReadyViewModel(this, new BattleReadyData(target, copyData.Id));
			parent?.ItemOnClick(new OpenViewArg(typeof(BattleReadyWindow), userData));
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("打开备战界面失败，请重试");
			Log.Error("打开备战界面失败！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	protected static string GetHeroName(int heroId)
	{
		return GameEntry.DataTable.GetDataRow<DRHeroInfo>(heroId)?.Name ?? $"角色{heroId}";
	}

	protected static string GetHeroIcon(int heroId)
	{
		return HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.CardHorizontal, heroId);
	}

	protected virtual void ResetSelfRankData()
	{
		selfRankScore = 0;
		selfRankPosition = 0;
	}

	protected virtual void ApplySelfRankData(HeroChallengeRankResultData result)
	{
		if (result == null)
		{
			ResetSelfRankData();
			return;
		}
		selfRankScore = result.SelfScore;
		selfRankPosition = result.SelfRank;
	}

	protected virtual async UniTask<HeroChallengeRankResultData> RequestRankResultAsync()
	{
		IRankService service = Singleton<ServiceSystem>.Instance.GetService<IRankService>();
		if (HeroChallengeRequestType == 0 || RankRequestData == null)
		{
			return null;
		}
		return await service.RequestSuitboxHeroRankInfo(HeroChallengeRequestType, RankRequestData.HeroId);
	}

	protected virtual List<CopyRankItemViewModel> BuildRankItemViewModels(HeroChallengeRankResultData result)
	{
		List<CopyRankItemViewModel> list = new List<CopyRankItemViewModel>();
		List<PbHeroRankInfo> list2 = result?.HeroRankInfos;
		if (list2 == null || list2.Count == 0)
		{
			return list;
		}
		list2.Sort((PbHeroRankInfo x, PbHeroRankInfo y) => x.Rank.CompareTo(y.Rank));
		for (int num = 0; num < list2.Count; num++)
		{
			if (list.Count >= RankDisplayCount)
			{
				break;
			}
			if (list2[num].Rank > 0)
			{
				list.Add(new CopyRankItemViewModel(this, list2[num].Score, list2[num].Icon, list2[num].IconFrame, list2[num].Title, list2[num].Rank, list2[num].UserName));
			}
		}
		return list;
	}

	protected virtual void OnRankRequestUnavailable()
	{
		CreateEmptyRank(0, GetDesiredRankCount(0));
	}

	private void RefreshRankDisplay(CopyType3SingleRankRefreshReason reason)
	{
		RefreshModeData(clearCacheWhenContextChanged: true);
		RefreshResultDisplayData();
		bool flag = HasCurrentRankCache();
		if (flag)
		{
			RaiseRefreshCopyRanks();
		}
		if (!ShouldRequestRankData(reason, flag))
		{
			if (!flag)
			{
				OnRankRequestUnavailable();
				RaiseRefreshCopyRanks();
			}
		}
		else
		{
			StartRankRefresh(!flag);
		}
	}

	private bool ShouldRequestRankData(CopyType3SingleRankRefreshReason reason, bool hasCurrentCache)
	{
		switch (reason)
		{
		case CopyType3SingleRankRefreshReason.PageActivated:
			if (!hasCurrentCache)
			{
				return true;
			}
			if (IsRankCacheExpired())
			{
				return true;
			}
			return false;
		case CopyType3SingleRankRefreshReason.BattleReturn:
			return true;
		case CopyType3SingleRankRefreshReason.TeamReturn:
			return !hasCurrentCache;
		default:
			return false;
		}
	}

	private void StartRankRefresh(bool showLoading)
	{
		int requestVersion = ++rankRequestVersion;
		int requestCopyId = CopyData?.Id ?? 0;
		int requestRankTypeId = RankRequestData?.RankTypeId ?? 0;
		int requestRankTarget = RankRequestData?.RankTarget ?? 0;
		int requestHeroId = RankRequestData?.HeroId ?? 0;
		RefreshRankListAsync(requestVersion, requestCopyId, requestRankTypeId, requestRankTarget, requestHeroId, showLoading);
	}

	private async UniTaskVoid RefreshRankListAsync(int requestVersion, int requestCopyId, int requestRankTypeId, int requestRankTarget, int requestHeroId, bool showLoading)
	{
		if (showLoading)
		{
			isRankLoading = true;
			rankItemVms.Clear();
			ResetSelfRankData();
			RefreshResultDisplayData();
			optRequest.Raise("SetRankLoading");
		}
		try
		{
			if (requestCopyId == 0 || requestRankTypeId == 0)
			{
				if (IsLatestRankRequest(requestVersion))
				{
					ClearRankDisplayCache();
					OnRankRequestUnavailable();
				}
				return;
			}
			HeroChallengeRankResultData result = await RequestRankResultAsync();
			if (IsLatestRankRequest(requestVersion) && IsRequestContextCurrent(requestCopyId, requestRankTypeId, requestRankTarget, requestHeroId))
			{
				rankItemVms.Clear();
				ApplySelfRankData(result);
				RefreshResultDisplayData();
				List<CopyRankItemViewModel> list = BuildRankItemViewModels(result);
				if (list != null && list.Count > 0)
				{
					rankItemVms.AddRange(list);
				}
				int desiredRankCount = GetDesiredRankCount(rankItemVms.Count);
				if (rankItemVms.Count < desiredRankCount)
				{
					CreateEmptyRank(rankItemVms.Count, desiredRankCount - rankItemVms.Count);
				}
				UpdateRankCacheContext(requestCopyId, requestRankTypeId, requestRankTarget, requestHeroId);
			}
		}
		catch (Exception)
		{
			if (IsLatestRankRequest(requestVersion) && showLoading)
			{
				rankItemVms.Clear();
				ResetSelfRankData();
				RefreshResultDisplayData();
				CreateEmptyRank(0, GetDesiredRankCount(0));
			}
		}
		finally
		{
			if (IsLatestRankRequest(requestVersion))
			{
				isRankLoading = false;
				optRequest.Raise("RefreshCopyRanks");
			}
		}
	}

	protected virtual int GetDesiredRankCount(int currentRankCount)
	{
		if (currentRankCount <= 0)
		{
			return 1;
		}
		if (currentRankCount == 1)
		{
			return 2;
		}
		return math.min(currentRankCount, RankDisplayCount);
	}

	private CopyData GetCurrentModeCopyData()
	{
		CopyViewModel copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		List<CopyData> type3ModeCopyDatas = copyVM.GetType3ModeCopyDatas(mode);
		if (type3ModeCopyDatas == null || type3ModeCopyDatas.Count == 0)
		{
			return null;
		}
		int targetCopyRank = GetCurrentPeriodCopyRank(copyVM);
		return type3ModeCopyDatas.Find((CopyData p) => p.CopyRank == targetCopyRank) ?? type3ModeCopyDatas[0];
	}

	private static int GetCurrentPeriodCopyRank(CopyViewModel copyViewModel)
	{
		List<CopyData> list = CopySecondType3ViewModel.FilterCurrentMultiCopyDatas(copyViewModel.GetType3CopyDatas());
		if (list == null || list.Count == 0)
		{
			return 1;
		}
		return math.max(list[0].Id / 100 - 400, 0) + 1;
	}

	private static string GetBossNameAndLevel(CopyData currentCopyData)
	{
		if (currentCopyData == null)
		{
			return "暂无配置";
		}
		int bossId = currentCopyData.GetBossId(0);
		if (bossId > 0)
		{
			DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow((DRMonsterAttr p) => p.Id == bossId);
			if (dataRow != null)
			{
				return $"Lv.{dataRow.MonsterLevel}{dataRow.Name}";
			}
		}
		if (!string.IsNullOrEmpty(currentCopyData.CopyRankName))
		{
			return currentCopyData.CopyRankName;
		}
		if (!string.IsNullOrEmpty(currentCopyData.Name))
		{
			return currentCopyData.Name;
		}
		return "暂无配置";
	}

	protected void CreateEmptyRank(int curCount, int emptyCount)
	{
		for (int i = 0; i < emptyCount; i++)
		{
			rankItemVms.Add(new CopyRankItemViewModel(this, curCount + i + 1));
		}
	}

	protected void RaiseRefreshCopyRanks()
	{
		isRankLoading = false;
		optRequest.Raise("RefreshCopyRanks");
	}

	protected bool HasCurrentRankCache()
	{
		if (RankItemVms == null || RankItemVms.Count <= 0)
		{
			return false;
		}
		return IsRequestContextCurrent(cachedCopyId, cachedRankTypeId, cachedRankTarget, cachedHeroId);
	}

	protected bool IsRankCacheExpired()
	{
		return DateTime.UtcNow - lastRankRefreshTime >= RankCacheDuration;
	}

	private bool IsLatestRankRequest(int requestVersion)
	{
		return requestVersion == rankRequestVersion;
	}

	private bool IsRequestContextCurrent(int copyId, int rankTypeId, int rankTarget, int heroId)
	{
		int num = CopyData?.Id ?? 0;
		int num2 = RankRequestData?.RankTypeId ?? 0;
		int num3 = RankRequestData?.RankTarget ?? 0;
		int num4 = RankRequestData?.HeroId ?? 0;
		if (copyId == num && rankTypeId == num2 && rankTarget == num3)
		{
			return heroId == num4;
		}
		return false;
	}

	private void UpdateRankCacheContext(int copyId, int rankTypeId, int rankTarget, int heroId)
	{
		cachedCopyId = copyId;
		cachedRankTypeId = rankTypeId;
		cachedRankTarget = rankTarget;
		cachedHeroId = heroId;
		lastRankRefreshTime = DateTime.UtcNow;
	}

	private void ClearRankDisplayCache()
	{
		rankItemVms.Clear();
		ResetSelfRankData();
		cachedCopyId = 0;
		cachedRankTypeId = 0;
		cachedRankTarget = 0;
		cachedHeroId = 0;
		lastRankRefreshTime = DateTime.MinValue;
	}

	protected virtual void RefreshBasicDisplayData()
	{
		int currentHeroIdForDisplay = GetCurrentHeroIdForDisplay();
		currentHeroIdForDisplay = ((currentHeroIdForDisplay == 0) ? 1104 : currentHeroIdForDisplay);
		CurrentHeroName = GetHeroName(currentHeroIdForDisplay);
	}

	protected void RefreshResultDisplayData()
	{
		RefreshBasicDisplayData();
		RefreshScoreText();
	}

	protected void RefreshScoreText()
	{
		ScoreText = (string.IsNullOrEmpty(SecondaryResultText) ? PrimaryResultText : (PrimaryResultText + "\n" + SecondaryResultText));
	}
}
