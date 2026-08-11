#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class RankViewModel : OptionBase
{
	public const int totalSubType = 999;

	public const int defaultMainType = 1;

	private int autoSelectMainType;

	private int autoSelectSubType;

	private string rankTitle;

	private string rankDesc;

	private string rankState;

	private bool showRewardBtn = true;

	private Dictionary<int, RankTypeData> rankTypeDatas = new Dictionary<int, RankTypeData>();

	private MultiTabItemData curMultiTabData;

	private int curSubType;

	private int curSeasonTabIndex = -2;

	private bool showSeasonTab;

	private TabItemData pastSeasonTabData;

	private TabItemData curSeasonTabData;

	private List<PbRaceCopyRankInfo> singleDatas = new List<PbRaceCopyRankInfo>();

	private List<PbSuitboxCopyRankInfo> multiDatas = new List<PbSuitboxCopyRankInfo>();

	private List<PbHeroRankInfo> heroChallengeDatas = new List<PbHeroRankInfo>();

	private List<PbUnionRankInfo> guildActiveRankDatas = new List<PbUnionRankInfo>();

	private List<PbUnionCopyRankInfo> guildCopyRankDatas = new List<PbUnionCopyRankInfo>();

	private List<PbChallengeCopyRankInfo> challengeCopyRankDatas = new List<PbChallengeCopyRankInfo>();

	private List<PbChallengeCopyRankInfo> towerCopyRankDatas = new List<PbChallengeCopyRankInfo>();

	private RankItemData myRankItemData;

	private bool myRankEmpty = true;

	private bool showSingleHeroes = true;

	private bool showHeroChallengeInfo;

	private string challengeHeroImg = "";

	private string challengeHeroName;

	private Timer timer;

	private InteractionRequest<int> _rankInfosChanged = new InteractionRequest<int>();

	private SimpleCommand _openHeroSelectWindowCmd;

	private SimpleCommand _openRankRewardWindowCmd;

	private SimpleCommand<int> _openPlayerInfoWindowCmd;

	private int _maxRankDisplay;

	private ISubscription<S2C_RankListNotify> _rankListNotify;

	private long timestamp;

	public TabItemData PastSeasonTabData => pastSeasonTabData;

	public TabItemData CurSeasonTabItemData => curSeasonTabData;

	public List<PbChallengeCopyRankInfo> ChallengeCopyRankDatas => challengeCopyRankDatas;

	public List<PbChallengeCopyRankInfo> TowerCopyRankDatas => towerCopyRankDatas;

	public string RankTitle
	{
		get
		{
			return rankTitle;
		}
		set
		{
			Set(ref rankTitle, value, "RankTitle");
		}
	}

	public string RankDesc
	{
		get
		{
			return rankDesc;
		}
		set
		{
			Set(ref rankDesc, value, "RankDesc");
		}
	}

	public string RankState
	{
		get
		{
			return rankState;
		}
		set
		{
			Set(ref rankState, value, "RankState");
		}
	}

	public int AutoSelectMainType => autoSelectMainType;

	public Dictionary<int, RankTypeData> RankTypeDatas => rankTypeDatas;

	public List<PbSuitboxCopyRankInfo> MultiDatas => multiDatas;

	public List<PbRaceCopyRankInfo> SingleDatas => singleDatas;

	public List<PbHeroRankInfo> HeroChallengeDatas => heroChallengeDatas;

	public List<PbUnionRankInfo> GuildActiveRankDatas => guildActiveRankDatas;

	public List<PbUnionCopyRankInfo> GuildCopyRankDatas => guildCopyRankDatas;

	public RankItemData MyRankItemData => myRankItemData;

	public int CurSubType
	{
		get
		{
			return curSubType;
		}
		private set
		{
			Set(ref curSubType, value, "CurSubType");
		}
	}

	public int CurSeasonTabIndex
	{
		get
		{
			return curSeasonTabIndex;
		}
		set
		{
			Set(ref curSeasonTabIndex, value, "CurSeasonTabIndex");
		}
	}

	public bool ShowSeasonTab
	{
		get
		{
			return showSeasonTab;
		}
		set
		{
			Set(ref showSeasonTab, value, "ShowSeasonTab");
		}
	}

	public bool ShowRewardBtn
	{
		get
		{
			return showRewardBtn;
		}
		set
		{
			Set(ref showRewardBtn, value, "ShowRewardBtn");
		}
	}

	public bool MyRankEmpty
	{
		get
		{
			return myRankEmpty;
		}
		set
		{
			Set(ref myRankEmpty, value, "MyRankEmpty");
		}
	}

	public bool ShowSingleHeroes
	{
		get
		{
			return showSingleHeroes;
		}
		set
		{
			Set(ref showSingleHeroes, value, "ShowSingleHeroes");
		}
	}

	public bool ShowHeroChallengeInfo
	{
		get
		{
			return showHeroChallengeInfo;
		}
		set
		{
			Set(ref showHeroChallengeInfo, value, "ShowHeroChallengeInfo");
		}
	}

	public string ChallengeHeroImg
	{
		get
		{
			return challengeHeroImg;
		}
		set
		{
			Set(ref challengeHeroImg, value, "ChallengeHeroImg");
		}
	}

	public string ChallengeHeroName
	{
		get
		{
			return challengeHeroName;
		}
		set
		{
			Set(ref challengeHeroName, value, "ChallengeHeroName");
		}
	}

	public InteractionRequest<int> RankInfosChanged => _rankInfosChanged;

	public SimpleCommand OpenHeroSelectWindowCmd => _openHeroSelectWindowCmd;

	public SimpleCommand OpenRankRewardWindowCmd => _openRankRewardWindowCmd;

	public RankViewModel()
	{
	}

	public RankViewModel(OptionBase parent, int mainType = 1, int target = 0)
	{
		base.parent = parent;
		_openHeroSelectWindowCmd = new SimpleCommand(OpenRankHeroSelectWindow);
		_openRankRewardWindowCmd = new SimpleCommand(OpenRankRewardWindow);
		_openPlayerInfoWindowCmd = new SimpleCommand<int>(OpenPlayerInfoWindow);
		autoSelectMainType = mainType;
		autoSelectSubType = GetAutoSelectRankId(mainType, target);
		pastSeasonTabData = new TabItemData(this, -1);
		curSeasonTabData = new TabItemData(this, -2);
		SetSeasonTabSelected(curSeasonTabIndex, refreshData: false);
		RefreshRankDatas();
	}

	public void SetMaxRankDisplay(int max)
	{
		_maxRankDisplay = max;
	}

	private void RefreshRankDatas()
	{
		DRRankType[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRRankType>();
		if (allDataRow == null)
		{
			return;
		}
		rankTypeDatas.Clear();
		DRRankType[] array = allDataRow;
		foreach (DRRankType dRRankType in array)
		{
			if (rankTypeDatas.ContainsKey(dRRankType.Id))
			{
				Log.Error($"RankType表 存在重复Id:{dRRankType.Id}");
			}
			else
			{
				rankTypeDatas.Add(dRRankType.Id, new RankTypeData(dRRankType));
			}
		}
	}

	public async Task RequestHeroChallengeData()
	{
		Loading loading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<IRankService>().RequestHeroChallengeData();
		loading?.Dispose();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is MultiTabItemData multiTabItemData)
		{
			autoSelectMainType = 1;
			if (curMultiTabData != null)
			{
				curMultiTabData.IsSelected = false;
				curMultiTabData.HideSubTabs();
			}
			curMultiTabData = multiTabItemData;
			curMultiTabData.IsSelected = true;
			if (multiTabItemData.HaveSubTab)
			{
				multiTabItemData.ShowSubTabs(autoSelectSubType);
			}
			else if (multiTabItemData.TabArg != null && multiTabItemData.TabArg is int rankId)
			{
				SetTabSelected(multiTabItemData, rankId);
			}
			else
			{
				SetTabSelected(multiTabItemData, multiTabItemData.TabIndex);
			}
		}
		else if (obj is TabItemData tabItemData)
		{
			if (tabItemData.TabIndex >= 0)
			{
				SetTabSelected(tabItemData, tabItemData.TabIndex);
			}
			else
			{
				SetSeasonTabSelected(tabItemData.TabIndex, refreshData: true);
			}
		}
		else if (obj is RankSeatItemData rankSeatItemData)
		{
			_openPlayerInfoWindowCmd.Execute(rankSeatItemData.Uid);
		}
		else if (obj is RankDefinition.HeroChallengeData heroChallengeData)
		{
			int heroChallengeIdForRank = Singleton<ServiceSystem>.Instance.GetService<IRankService>().GetHeroChallengeIdForRank();
			if (heroChallengeData.HeroId != heroChallengeIdForRank)
			{
				Singleton<ServiceSystem>.Instance.GetService<IRankService>().SetHeroChallengeIdForRank(heroChallengeData.HeroId);
				RequestData(CurSubType);
			}
		}
	}

	private void SetTabSelected(TabItemData tabItemData, int rankId)
	{
		autoSelectSubType = 0;
		CurSubType = rankId;
		DRRank dataRow = GameEntry.DataTable.GetDataRow<DRRank>(rankId);
		ShowSingleHeroes = dataRow == null || dataRow.RankTarget != 999;
		RequestData(CurSubType);
	}

	private void SetSeasonTabSelected(int tabIndex, bool refreshData)
	{
		int num = curSeasonTabIndex;
		curSeasonTabIndex = tabIndex;
		pastSeasonTabData.SetSelected(tabIndex == -1);
		curSeasonTabData.SetSelected(tabIndex == -2);
		if (refreshData && num != tabIndex)
		{
			RequestDataBySeasonChanged();
		}
	}

	private int GetCurSeasonId()
	{
		if (CurSeasonTabIndex == -1)
		{
			return -1;
		}
		return 0;
	}

	private async void RequestData(int rankId)
	{
		if (curMultiTabData == null)
		{
			return;
		}
		DRRank dataRow = GameEntry.DataTable.GetDataRow<DRRank>(rankId);
		if (dataRow != null)
		{
			DRRankType dataRow2 = GameEntry.DataTable.GetDataRow<DRRankType>(dataRow.RankType);
			if (dataRow2 != null)
			{
				CancelTimer();
				ResetUiLayout(dataRow2, dataRow);
				ResetSeasonTabs(dataRow2, dataRow);
				await SendServiceRequest(dataRow2.Type, dataRow.RankTarget);
			}
		}
	}

	private async void RequestDataBySeasonChanged()
	{
		if (curMultiTabData == null)
		{
			return;
		}
		DRRank dataRow = GameEntry.DataTable.GetDataRow<DRRank>(CurSubType);
		if (dataRow != null)
		{
			DRRankType dataRow2 = GameEntry.DataTable.GetDataRow<DRRankType>(dataRow.RankType);
			if (dataRow2 != null)
			{
				await SendServiceRequest(dataRow2.Type, dataRow.RankTarget);
			}
		}
	}

	private async Task SendServiceRequest(int rankType, int rankTarget)
	{
		IRankService rankService = Singleton<ServiceSystem>.Instance.GetService<IRankService>();
		Loading loading = await Loading.Show();
		if (RankDefinition.CheckSuitBoxCopyRank(rankType))
		{
			multiDatas.Clear();
			AddSuitBoxCopyRankInfo(await rankService.RequestSuitBoxCopyRankData(rankType, rankTarget, GetCurSeasonId()));
		}
		else if (RankDefinition.CheckRaceCopyRank(rankType))
		{
			singleDatas.Clear();
			int seasonId = ((rankTarget == 999) ? GetCurSeasonId() : 0);
			AddRaceCopyRankInfo(await rankService.RequestRaceCopyRankData(rankType, rankTarget, seasonId));
		}
		else if (RankDefinition.CheckHeroChallengeRank(rankType))
		{
			heroChallengeDatas.Clear();
			int heroChallengeIdForRank = rankService.GetHeroChallengeIdForRank();
			AddHeroChallengeRankInfo(await rankService.RequestHeroChallengeRankData(rankType, heroChallengeIdForRank, GetCurSeasonId()));
		}
		else if (RankDefinition.CheckGuildSevenDayActiveRank(rankType))
		{
			guildActiveRankDatas.Clear();
			AddGuildSevenDayActiveRankInfo(await rankService.RequestGuildActiveRankData());
		}
		else if (RankDefinition.CheckGuildCopyRank(rankType))
		{
			guildCopyRankDatas.Clear();
			AddGuildCopyRankInfo(await rankService.RequestGuildCopyRankData());
		}
		else if (RankDefinition.CheckChallengeCopyRank(rankType))
		{
			challengeCopyRankDatas.Clear();
			AddChallengeCopyRankInfo(await rankService.RequestChallengeCopyRankData(rankType, rankTarget));
		}
		else if (RankDefinition.CheckTowerRank(rankType))
		{
			towerCopyRankDatas.Clear();
			AddTowerCopyRankInfo(await rankService.RequestTowerCopyRankData(rankType, rankTarget));
		}
		loading?.Dispose();
	}

	private void AddSuitBoxCopyRankInfo(List<PbSuitboxCopyRankInfo> infos)
	{
		if (infos != null)
		{
			multiDatas.AddRange(infos);
		}
		if (multiDatas.Count <= 0)
		{
			MyRankEmpty = true;
		}
		else
		{
			multiDatas.Sort((PbSuitboxCopyRankInfo x, PbSuitboxCopyRankInfo y) => x.Rank.CompareTo(y.Rank));
			List<PbSuitboxCopyRankInfo> list = multiDatas.FindAll((PbSuitboxCopyRankInfo p) => p.Players.Exists((PbSuitboxCopyRankSingleUserInfo v) => v.UserId == Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid));
			if (list.Count > 0)
			{
				MyRankEmpty = false;
				PbSuitboxCopyRankInfo myData = list[0];
				list.ForEach(delegate(PbSuitboxCopyRankInfo p)
				{
					if (p.Rank < myData.Rank)
					{
						myData = p;
					}
				});
				myRankItemData = RankItemData.Create(myData, this);
			}
			else
			{
				MyRankEmpty = true;
			}
		}
		multiDatas?.RemoveAll((PbSuitboxCopyRankInfo p) => p.Rank < 0 || p.Rank > _maxRankDisplay);
		_rankInfosChanged.Raise(1);
	}

	private void AddRaceCopyRankInfo(List<PbRaceCopyRankInfo> infos)
	{
		if (infos != null)
		{
			singleDatas.AddRange(infos);
		}
		if (singleDatas.Count <= 0)
		{
			MyRankEmpty = true;
		}
		else
		{
			singleDatas.Sort((PbRaceCopyRankInfo x, PbRaceCopyRankInfo y) => x.Rank.CompareTo(y.Rank));
			PbRaceCopyRankInfo pbRaceCopyRankInfo = singleDatas.Find((PbRaceCopyRankInfo p) => p.UserId == Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid);
			if (pbRaceCopyRankInfo != null)
			{
				MyRankEmpty = false;
				myRankItemData = RankItemData.Create(pbRaceCopyRankInfo, this, ShowSingleHeroes);
			}
			else
			{
				MyRankEmpty = true;
			}
		}
		singleDatas?.RemoveAll((PbRaceCopyRankInfo p) => p.Rank < 0 || p.Rank > _maxRankDisplay);
		_rankInfosChanged.Raise(2);
	}

	private void AddHeroChallengeRankInfo(List<PbHeroRankInfo> infos)
	{
		if (infos != null)
		{
			heroChallengeDatas.AddRange(infos);
		}
		if (heroChallengeDatas.Count <= 0)
		{
			MyRankEmpty = true;
		}
		else
		{
			heroChallengeDatas.Sort((PbHeroRankInfo x, PbHeroRankInfo y) => x.Rank.CompareTo(y.Rank));
			PbHeroRankInfo pbHeroRankInfo = heroChallengeDatas.Find((PbHeroRankInfo p) => p.UserId == Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid);
			if (pbHeroRankInfo != null)
			{
				MyRankEmpty = false;
				myRankItemData = RankItemData.Create(pbHeroRankInfo, this);
			}
			else
			{
				MyRankEmpty = true;
			}
		}
		heroChallengeDatas?.RemoveAll((PbHeroRankInfo p) => p.Rank < 0 || p.Rank > _maxRankDisplay);
		_rankInfosChanged.Raise(3);
	}

	private void AddGuildSevenDayActiveRankInfo(List<PbUnionRankInfo> infos)
	{
		if (infos != null)
		{
			guildActiveRankDatas.AddRange(infos);
		}
		if (guildActiveRankDatas.Count <= 0)
		{
			MyRankEmpty = true;
		}
		else
		{
			guildActiveRankDatas.Sort((PbUnionRankInfo x, PbUnionRankInfo y) => x.Rank.CompareTo(y.Rank));
			MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
			if (myGuildData == null)
			{
				MyRankEmpty = true;
			}
			else
			{
				PbUnionRankInfo pbUnionRankInfo = guildActiveRankDatas.Find((PbUnionRankInfo p) => p.UnionInfo.UnionId == myGuildData.Uid);
				if (pbUnionRankInfo != null)
				{
					MyRankEmpty = false;
					myRankItemData = RankItemData.Create(pbUnionRankInfo, this);
				}
				else
				{
					MyRankEmpty = true;
				}
			}
		}
		guildActiveRankDatas?.RemoveAll((PbUnionRankInfo p) => p.Rank < 0 || p.Rank > _maxRankDisplay);
		_rankInfosChanged.Raise(RankDefinition.GetGuildActiveRankType());
	}

	private void AddGuildCopyRankInfo(List<PbUnionCopyRankInfo> infos)
	{
		if (infos != null)
		{
			guildCopyRankDatas.AddRange(infos);
		}
		if (guildCopyRankDatas.Count <= 0)
		{
			MyRankEmpty = true;
		}
		else
		{
			guildCopyRankDatas.Sort((PbUnionCopyRankInfo x, PbUnionCopyRankInfo y) => x.Rank.CompareTo(y.Rank));
			MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
			if (myGuildData == null)
			{
				MyRankEmpty = true;
			}
			else
			{
				PbUnionCopyRankInfo pbUnionCopyRankInfo = guildCopyRankDatas.Find((PbUnionCopyRankInfo p) => p.UnionInfo.UnionId == myGuildData.Uid);
				if (pbUnionCopyRankInfo != null)
				{
					MyRankEmpty = false;
					myRankItemData = RankItemData.Create(pbUnionCopyRankInfo, this);
				}
				else
				{
					MyRankEmpty = true;
				}
			}
		}
		guildCopyRankDatas?.RemoveAll((PbUnionCopyRankInfo p) => p.Rank < 0 || p.Rank > _maxRankDisplay);
		_rankInfosChanged.Raise(RankDefinition.GetGuildCopyRankType());
	}

	private void AddChallengeCopyRankInfo(List<PbChallengeCopyRankInfo> infos)
	{
		if (infos != null)
		{
			challengeCopyRankDatas.AddRange(infos);
		}
		if (challengeCopyRankDatas.Count <= 0)
		{
			MyRankEmpty = true;
		}
		else
		{
			challengeCopyRankDatas.Sort((PbChallengeCopyRankInfo x, PbChallengeCopyRankInfo y) => x.Rank.CompareTo(y.Rank));
			List<PbChallengeCopyRankInfo> list = challengeCopyRankDatas.FindAll((PbChallengeCopyRankInfo p) => p.Players.Exists((PbSuitboxCopyRankSingleUserInfo v) => v.UserId == Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid));
			if (list.Count > 0)
			{
				MyRankEmpty = false;
				PbChallengeCopyRankInfo myData = list[0];
				list.ForEach(delegate(PbChallengeCopyRankInfo p)
				{
					if (p.Rank < myData.Rank)
					{
						myData = p;
					}
				});
				myRankItemData = RankItemData.Create(myData, this);
			}
			else
			{
				MyRankEmpty = true;
			}
		}
		challengeCopyRankDatas?.RemoveAll((PbChallengeCopyRankInfo p) => p.Rank < 0 || p.Rank > _maxRankDisplay);
		_rankInfosChanged.Raise(RankDefinition.GetChallengeCopyRankType());
	}

	private void AddTowerCopyRankInfo(List<PbChallengeCopyRankInfo> infos)
	{
		if (infos == null)
		{
			return;
		}
		towerCopyRankDatas.AddRange(infos);
		if (towerCopyRankDatas.Count <= 0)
		{
			MyRankEmpty = true;
		}
		else
		{
			towerCopyRankDatas.Sort((PbChallengeCopyRankInfo x, PbChallengeCopyRankInfo y) => x.Rank.CompareTo(y.Rank));
			List<PbChallengeCopyRankInfo> list = towerCopyRankDatas.FindAll((PbChallengeCopyRankInfo p) => p.Players.Exists((PbSuitboxCopyRankSingleUserInfo v) => v.UserId == Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid));
			if (list.Count > 0)
			{
				MyRankEmpty = false;
				PbChallengeCopyRankInfo myData = list[0];
				list.ForEach(delegate(PbChallengeCopyRankInfo p)
				{
					if (p.Rank < myData.Rank)
					{
						myData = p;
					}
				});
				myRankItemData = RankItemData.Create(myData, this);
			}
			else
			{
				MyRankEmpty = true;
			}
		}
		towerCopyRankDatas?.RemoveAll((PbChallengeCopyRankInfo p) => p.Rank < 0 || p.Rank > _maxRankDisplay);
		_rankInfosChanged.Raise(RankDefinition.GetTowerCopyRankType());
	}

	private void OnRankListNotify(S2C_RankListNotify notify)
	{
		if (notify == null)
		{
			return;
		}
		DRRank dataRow = GameEntry.DataTable.GetDataRow<DRRank>(CurSubType);
		if (dataRow == null)
		{
			return;
		}
		DRRankType dataRow2 = GameEntry.DataTable.GetDataRow<DRRankType>(dataRow.RankType);
		if (dataRow2 == null)
		{
			return;
		}
		int type = dataRow2.Type;
		if (RankDefinition.CheckSuitBoxCopyRank(type))
		{
			AddSuitBoxCopyRankInfo(notify.SuitboxCopyRankInfos);
		}
		else if (RankDefinition.CheckRaceCopyRank(type))
		{
			AddRaceCopyRankInfo(notify.RaceCopyRankInfos);
		}
		else if (RankDefinition.CheckHeroChallengeRank(type))
		{
			AddHeroChallengeRankInfo(notify.HeroRankInfos);
		}
		else if (!RankDefinition.CheckGuildSevenDayActiveRank(type) && !RankDefinition.CheckGuildCopyRank(type))
		{
			if (RankDefinition.CheckChallengeCopyRank(type))
			{
				AddChallengeCopyRankInfo(notify.ChallengeCopyRankInfos);
			}
			else if (RankDefinition.CheckTowerRank(type))
			{
				AddTowerCopyRankInfo(notify.ChallengeCopyRankInfos);
			}
		}
	}

	private void ResetUiLayout(DRRankType drRankType, DRRank drRank)
	{
		if (RankDefinition.CheckSuitBoxCopyRank(drRankType.Type))
		{
			RankTitle = "暗箱裂隙积分榜";
			RankDesc = "组队通关暗箱裂隙后的积分排名";
			RankState = "排名每周一4:00结算";
			ShowRewardBtn = true;
		}
		else if (RankDefinition.CheckRaceCopyRank(drRankType.Type))
		{
			RankTitle = ((drRank.RankTarget == 999) ? "竞速副本总积分榜" : (drRank.RankName + "积分榜"));
			RankDesc = ((drRank.RankTarget == 999) ? "单人通关所有竞速副本获得的总积分排名" : ("单人通关" + drRank.RankName + "竞速副本获得的积分排名"));
			ShowRewardBtn = true;
			if (rankTypeDatas[drRank.RankType].State == RankDefinition.RankState.AlreadySettled)
			{
				RankState = "已结算";
			}
			else
			{
				UpdateTimer(rankTypeDatas[drRank.RankType].EndTime);
			}
		}
		else if (RankDefinition.CheckHeroChallengeRank(drRankType.Type))
		{
			int heroChallengeIdForRank = Singleton<ServiceSystem>.Instance.GetService<IRankService>().GetHeroChallengeIdForRank();
			DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(heroChallengeIdForRank);
			bool flag = drRankType.Type == 10;
			RankTitle = (flag ? "火力试炼积分榜" : "极限挑战积分榜");
			RankDesc = (flag ? ("火力模式下，使用" + dataRow.Name + "通关暗箱裂隙后的积分排名") : ("极限模式下，使用" + dataRow.Name + "通关暗箱裂隙后的积分排名"));
			RankState = "排名每周一4:00结算";
			ShowRewardBtn = true;
			ChallengeHeroImg = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.RectangleHorizontal, dataRow.Id);
			ChallengeHeroName = "(" + dataRow.Name + ")";
		}
		else if (RankDefinition.CheckGuildSevenDayActiveRank(drRankType.Type))
		{
			RankTitle = "公会活跃度总榜";
			RankDesc = "公会周活跃为公会上周累计获取的活跃度，每周一统计排行";
			RankState = "排名每周一4:00结算";
			ShowRewardBtn = false;
		}
		else if (RankDefinition.CheckGuildCopyRank(drRankType.Type))
		{
			RankTitle = "公会远征总伤害榜";
			RankDesc = "公会中所有玩家在公会远征最终战造成的最高伤害总和";
			RankState = "排名每周一4:00结算";
			ShowRewardBtn = true;
		}
		else if (RankDefinition.CheckChallengeCopyRank(drRankType.Type))
		{
			bool flag2 = drRank.RankTarget == 999;
			RankTitle = (flag2 ? "炬隙征伐总积分榜" : (drRank.RankName + "积分榜"));
			RankDesc = (flag2 ? "根据当期炬隙征伐·巅峰所有副本总积分排名" : ("根据通关" + drRank.RankName + "副本的剩余时间获得的积分（1秒=10分）排名"));
			if (rankTypeDatas[drRank.RankType].State == RankDefinition.RankState.AlreadySettled)
			{
				RankState = "已结算";
			}
			else
			{
				UpdateTimer(rankTypeDatas[drRank.RankType].EndTime);
			}
			ShowRewardBtn = true;
		}
		else if (RankDefinition.CheckTowerRank(drRankType.Type))
		{
			RankTitle = drRank.RankName + "积分榜";
			RankDesc = "根据当期" + drRank.RankName + "总积分排名";
			if (rankTypeDatas[drRank.RankType].State == RankDefinition.RankState.AlreadySettled)
			{
				RankState = "已结算";
			}
			else
			{
				UpdateTimer(rankTypeDatas[drRank.RankType].EndTime);
			}
			ShowRewardBtn = true;
		}
	}

	private void ResetSeasonTabs(DRRankType drRankType, DRRank drRank)
	{
		if (RankDefinition.CheckSuitBoxCopyRank(drRankType.Type))
		{
			ShowSeasonTab = true;
		}
		else if (RankDefinition.CheckRaceCopyRank(drRankType.Type))
		{
			ShowSeasonTab = drRank.RankTarget == 999;
		}
		else if (RankDefinition.CheckHeroChallengeRank(drRankType.Type))
		{
			ShowSeasonTab = true;
		}
		else if (RankDefinition.CheckGuildSevenDayActiveRank(drRankType.Type))
		{
			ShowSeasonTab = false;
		}
		else if (RankDefinition.CheckGuildCopyRank(drRankType.Type))
		{
			ShowSeasonTab = false;
		}
		else if (RankDefinition.CheckChallengeCopyRank(drRankType.Type))
		{
			ShowSeasonTab = false;
		}
		else if (RankDefinition.CheckTowerRank(drRankType.Type))
		{
			ShowSeasonTab = false;
		}
		ShowHeroChallengeInfo = RankDefinition.CheckHeroChallengeRank(drRankType.Type);
		SetSeasonTabSelected(-2, refreshData: false);
	}

	private int GetAutoSelectRankId(int mainType, int rankTarget)
	{
		return GameEntry.DataTable.GetDataRow((DRRank p) => p.RankType == mainType && p.RankTarget == rankTarget)?.Id ?? 0;
	}

	private void CancelTimer()
	{
		if (timer != null)
		{
			timer.Cancel();
			timer = null;
		}
	}

	private void UpdateTimer(DateTime targetTime)
	{
		timestamp = Convert.ToInt64((targetTime - DateTime.Now).TotalSeconds);
		try
		{
			timer = Timer.Register(1f, OnComplete, null, isLooped: true, useRealTime: true);
		}
		catch (Exception arg)
		{
			Log.Error($"ShopWindow：开启计时器失败:{arg}");
		}
	}

	private void OnComplete()
	{
		timestamp--;
		if (timestamp <= 0)
		{
			RankState = "已结算";
			CancelTimer();
		}
		else
		{
			RankState = Utility.DateTime.GetLeftDateTime(timestamp, "dd\\日hh\\时mm\\分") + "后结算";
		}
	}

	private async void OpenRankHeroSelectWindow()
	{
		try
		{
			_openHeroSelectWindowCmd.Enabled = false;
			IRankService rankService = Singleton<ServiceSystem>.Instance.GetService<IRankService>();
			List<RankDefinition.HeroChallengeData> heroChallengeData = rankService.GetHeroChallengeData();
			if (heroChallengeData == null || heroChallengeData.Count <= 0)
			{
				await RequestHeroChallengeData();
				heroChallengeData = rankService.GetHeroChallengeData();
			}
			if (heroChallengeData == null || heroChallengeData.Count <= 0)
			{
				Toast.ShowInfo("暂无角色排行数据");
				_openHeroSelectWindowCmd.Enabled = true;
				return;
			}
			int heroChallengeIdForRank = rankService.GetHeroChallengeIdForRank();
			openWindowRequest.Raise(new OpenViewArg(typeof(RankHeroSelectWindow), new RankHeroSelectViewModel(this, heroChallengeData, heroChallengeIdForRank)), delegate
			{
				_openHeroSelectWindowCmd.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error(ex.ToString());
			_openHeroSelectWindowCmd.Enabled = true;
		}
	}

	private void OpenRankRewardWindow()
	{
		if (CurSubType <= 0)
		{
			return;
		}
		DRRank drRank = GameEntry.DataTable.GetDataRow<DRRank>(CurSubType);
		if (drRank == null)
		{
			return;
		}
		List<DRRankReward> rewards = GameEntry.DataTable.GetDataRows((DRRankReward p) => p.RankId == drRank.Id).ToList();
		_openRankRewardWindowCmd.Enabled = false;
		try
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(RankRewardWindow), new RankRewardViewModel(rewards)), delegate
			{
				_openRankRewardWindowCmd.Enabled = true;
			});
		}
		catch (Exception)
		{
			_openRankRewardWindowCmd.Enabled = true;
		}
	}

	private async void OpenPlayerInfoWindow(int userId)
	{
		_openPlayerInfoWindowCmd.Enabled = false;
		try
		{
			Loading loading = await Loading.Show();
			PlayerData playerData = await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestSearchPlayer(userId);
			loading.Dispose();
			if (playerData == null)
			{
				_openPlayerInfoWindowCmd.Enabled = true;
				return;
			}
			RoleViewModel roleViewModel = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData();
			PlayerInfoViewModel playerInfoViewModel;
			if (roleViewModel.PlayerInfo.Uid.Equals(userId))
			{
				playerInfoViewModel = new PlayerInfoViewModel(this, roleViewModel.PlayerInfo, isSelf: true);
				await playerInfoViewModel.AddSelfShowHeros(roleViewModel.HeroIds);
				await playerInfoViewModel.AddSelfShowAchi(roleViewModel.PlayerInfo.WearMedals);
			}
			else
			{
				playerInfoViewModel = new PlayerInfoViewModel(this, playerData, isSelf: false);
			}
			openWindowRequest.Raise(new OpenViewArg(typeof(PlayerInfoWindow), playerInfoViewModel), delegate
			{
				_openPlayerInfoWindowCmd.Enabled = true;
			});
		}
		catch (Exception)
		{
			_openPlayerInfoWindowCmd.Enabled = true;
		}
	}

	public override void Close()
	{
		CancelTimer();
		base.Close();
	}

	protected override void Dispose(bool disposing)
	{
		_rankListNotify?.Dispose();
		_rankListNotify = null;
		base.Dispose(disposing);
	}
}
