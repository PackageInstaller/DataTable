using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RankWindow : UGuiWindowBase
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnReward;

	[SerializeField]
	private RectTransform multiTabRoot;

	[SerializeField]
	private MultiTabItem multiTabTpl;

	[SerializeField]
	private TextMeshProUGUI rankTitle;

	[SerializeField]
	private TextMeshProUGUI rankDesc;

	[SerializeField]
	private TextMeshProUGUI rankState;

	[SerializeField]
	private List<GameObject> heroChallengeInfos;

	[SerializeField]
	private Image challengeHeroImg;

	[SerializeField]
	private TextMeshProUGUI challengeHeroName;

	[SerializeField]
	private Button btnOpenHeroList;

	[SerializeField]
	private GameObject singleTitleBar;

	[SerializeField]
	private GameObject singleHeroes;

	[SerializeField]
	private GameObject multiTitleBar;

	[SerializeField]
	private GameObject heroChallengeBar;

	[SerializeField]
	private GameObject guildActiveBar;

	[SerializeField]
	private GameObject guildCopyRankBar;

	[SerializeField]
	private GameObject challengeCopyTotalBar;

	[SerializeField]
	private GameObject challengeCopySubBar;

	[SerializeField]
	private GameObject towerCopyBar;

	[SerializeField]
	private LoopListView2 rankTeamScrollRect;

	[SerializeField]
	private GameObject nothing;

	[SerializeField]
	private List<RankItem> myRankItems;

	[SerializeField]
	private GameObject noMyTeam;

	[SerializeField]
	private CanvasGroup seasonCanvasGroup;

	[SerializeField]
	private TabItem pastSeasonTab;

	[SerializeField]
	private TabItem curSeasonTab;

	[SerializeField]
	private int maxRankDisplay = 300;

	private RankViewModel _viewModel;

	private int curRankType;

	private GameObjectPool _multiTabPool;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<RankViewModel>();
		_viewModel.SetMaxRankDisplay(maxRankDisplay);
		curRankType = _viewModel.AutoSelectMainType;
		nothing.SetActive(value: true);
		BindingSet<RankWindow, RankViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((RankWindow v) => v.OpenUguiWindow).To((RankViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((RankWindow v) => v.OnDismissRequest).To((RankViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((RankViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind<TextMeshProUGUI>(rankTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RankViewModel vm) => vm.RankTitle);
		bindingSet.Bind<TextMeshProUGUI>(rankDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RankViewModel vm) => vm.RankDesc);
		bindingSet.Bind<TextMeshProUGUI>(rankState).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RankViewModel vm) => vm.RankState);
		bindingSet.Bind(singleHeroes).For((GameObject v) => v.activeSelf).To((RankViewModel vm) => vm.ShowSingleHeroes);
		bindingSet.Bind().For((RankWindow v) => v.RefreshRankItems).To((RankViewModel vm) => vm.RankInfosChanged);
		bindingSet.Bind(noMyTeam).For((GameObject v) => v.activeSelf).To((RankViewModel vm) => vm.MyRankEmpty);
		if (heroChallengeInfos != null)
		{
			foreach (GameObject heroChallengeInfo in heroChallengeInfos)
			{
				bindingSet.Bind(heroChallengeInfo).For((GameObject v) => v.activeSelf).To((RankViewModel vm) => vm.ShowHeroChallengeInfo);
			}
		}
		bindingSet.Bind(challengeHeroImg).For((Image v) => v.sprite).To((RankViewModel vm) => vm.ChallengeHeroImg)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(challengeHeroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RankViewModel vm) => vm.ChallengeHeroName);
		bindingSet.Bind(btnOpenHeroList).For((Button v) => v.onClick).To((RankViewModel vm) => vm.OpenHeroSelectWindowCmd);
		bindingSet.Bind(btnReward).For((Button v) => v.onClick).To((RankViewModel vm) => vm.OpenRankRewardWindowCmd);
		bindingSet.Bind(btnReward.gameObject).For((GameObject v) => v.activeSelf).To((RankViewModel vm) => vm.ShowRewardBtn);
		bindingSet.Bind<CanvasGroup>(seasonCanvasGroup).For((Expression<Func<CanvasGroup, float>>)((CanvasGroup v) => v.alpha)).ToExpression((RankViewModel vm) => vm.ShowSeasonTab ? 1 : 0);
		bindingSet.Bind<CanvasGroup>(seasonCanvasGroup).For((Expression<Func<CanvasGroup, bool>>)((CanvasGroup v) => v.blocksRaycasts)).To((RankViewModel vm) => vm.ShowSeasonTab);
		bindingSet.Build();
		rankTeamScrollRect.InitListView(0, OnGetRankItemByIndex);
		_multiTabPool = new GameObjectPool(multiTabTpl.gameObject, multiTabRoot);
		RefreshMultiTabs();
		pastSeasonTab.Init(_viewModel.PastSeasonTabData);
		curSeasonTab.Init(_viewModel.CurSeasonTabItemData);
		RefreshMyRankItem();
	}

	private void RefreshMultiTabs()
	{
		_multiTabPool.RecycleAll();
		if (_viewModel.RankTypeDatas == null || _viewModel.RankTypeDatas.Count <= 0)
		{
			return;
		}
		Dictionary<int, List<RankTypeData>> dictionary = new Dictionary<int, List<RankTypeData>>();
		foreach (RankTypeData value in _viewModel.RankTypeDatas.Values)
		{
			if (value.State != RankDefinition.RankState.InvalidConfig && value.State != RankDefinition.RankState.NotStarted && value.State != RankDefinition.RankState.Removed && value.RankDatas.Count > 0 && !string.IsNullOrEmpty(value.Name))
			{
				if (!dictionary.ContainsKey(value.TabId))
				{
					dictionary.Add(value.TabId, new List<RankTypeData> { value });
				}
				else
				{
					dictionary[value.TabId].Add(value);
				}
			}
		}
		bool flag = false;
		MultiTabItemData multiTabItemData = null;
		foreach (KeyValuePair<int, List<RankTypeData>> item2 in dictionary)
		{
			MultiTabItem component = _multiTabPool.Allocate(out var newCreate).GetComponent<MultiTabItem>();
			MultiTabItemData multiTabItemData2 = new MultiTabItemData(_viewModel, item2.Key);
			DRRankUIType dataRow = GameEntry.DataTable.GetDataRow<DRRankUIType>(item2.Key);
			multiTabItemData2.TextNormal = dataRow.TabName;
			multiTabItemData2.TextSelected = dataRow.TabName;
			List<TabItemData> list = new List<TabItemData>();
			foreach (RankTypeData item3 in item2.Value)
			{
				foreach (DRRank rankData in item3.RankDatas)
				{
					if (rankData.NoSubDisplay)
					{
						multiTabItemData2.TabArg = rankData.Id;
						list.Clear();
						break;
					}
					TabItemData item = new TabItemData(multiTabItemData2, rankData.Id)
					{
						TextNormal = rankData.RankName,
						TextSelected = rankData.RankName
					};
					list.Add(item);
				}
			}
			multiTabItemData2.SetSubTabDatas(list);
			if (newCreate)
			{
				component.Init(multiTabItemData2);
			}
			else
			{
				component.RefreshData(multiTabItemData2);
			}
			component.transform.SetAsLastSibling();
			component.gameObject.SetActive(value: true);
			multiTabItemData = multiTabItemData ?? multiTabItemData2;
			DRRankType dataRow2 = GameEntry.DataTable.GetDataRow<DRRankType>(_viewModel.AutoSelectMainType);
			if (dataRow2 != null && multiTabItemData2.TabIndex == dataRow2.UITabType)
			{
				flag = true;
				multiTabItemData2.TabOnClick();
			}
		}
		if (!flag)
		{
			multiTabItemData?.TabOnClick();
		}
	}

	private LoopListViewItem2 OnGetRankItemByIndex(LoopListView2 arg1, int itemIndex)
	{
		if ((RankDefinition.CheckSuitBoxCopyRank(curRankType) && _viewModel.MultiDatas == null) || (RankDefinition.CheckRaceCopyRank(curRankType) && _viewModel.SingleDatas == null) || (RankDefinition.CheckHeroChallengeRank(curRankType) && _viewModel.HeroChallengeDatas == null) || (RankDefinition.CheckGuildSevenDayActiveRank(curRankType) && _viewModel.GuildActiveRankDatas == null) || (RankDefinition.CheckGuildCopyRank(curRankType) && _viewModel.GuildCopyRankDatas == null) || (RankDefinition.CheckChallengeCopyRank(curRankType) && _viewModel.ChallengeCopyRankDatas == null) || (RankDefinition.CheckTowerRank(curRankType) && _viewModel.TowerCopyRankDatas == null))
		{
			return null;
		}
		int num = 0;
		if (RankDefinition.CheckSuitBoxCopyRank(curRankType))
		{
			num = _viewModel.MultiDatas.Count;
		}
		else if (RankDefinition.CheckRaceCopyRank(curRankType))
		{
			num = _viewModel.SingleDatas.Count;
		}
		else if (RankDefinition.CheckHeroChallengeRank(curRankType))
		{
			num = _viewModel.HeroChallengeDatas.Count;
		}
		else if (RankDefinition.CheckGuildSevenDayActiveRank(curRankType))
		{
			num = _viewModel.GuildActiveRankDatas.Count;
		}
		else if (RankDefinition.CheckGuildCopyRank(curRankType))
		{
			num = _viewModel.GuildCopyRankDatas.Count;
		}
		else if (RankDefinition.CheckChallengeCopyRank(curRankType))
		{
			num = _viewModel.ChallengeCopyRankDatas.Count;
		}
		else if (RankDefinition.CheckTowerRank(curRankType))
		{
			num = _viewModel.TowerCopyRankDatas.Count;
		}
		if (itemIndex < 0 || itemIndex >= num)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = arg1.NewListViewItem(GetRankItemLayout(curRankType, _viewModel.CurSubType).ToString());
		RankItem component = loopListViewItem.GetComponent<RankItem>();
		RankItemData rankItemData = null;
		if (RankDefinition.CheckSuitBoxCopyRank(curRankType) && _viewModel.MultiDatas[itemIndex] != null)
		{
			rankItemData = RankItemData.Create(_viewModel.MultiDatas[itemIndex], _viewModel);
		}
		else if (RankDefinition.CheckRaceCopyRank(curRankType) && _viewModel.SingleDatas[itemIndex] != null)
		{
			rankItemData = RankItemData.Create(_viewModel.SingleDatas[itemIndex], _viewModel, _viewModel.ShowSingleHeroes);
		}
		else if (RankDefinition.CheckHeroChallengeRank(curRankType) && _viewModel.HeroChallengeDatas[itemIndex] != null)
		{
			rankItemData = RankItemData.Create(_viewModel.HeroChallengeDatas[itemIndex], _viewModel);
		}
		else if (RankDefinition.CheckGuildSevenDayActiveRank(curRankType) && _viewModel.GuildActiveRankDatas[itemIndex] != null)
		{
			rankItemData = RankItemData.Create(_viewModel.GuildActiveRankDatas[itemIndex], _viewModel);
		}
		else if (RankDefinition.CheckGuildCopyRank(curRankType) && _viewModel.GuildCopyRankDatas[itemIndex] != null)
		{
			rankItemData = RankItemData.Create(_viewModel.GuildCopyRankDatas[itemIndex], _viewModel);
		}
		else if (RankDefinition.CheckChallengeCopyRank(curRankType) && _viewModel.ChallengeCopyRankDatas[itemIndex] != null)
		{
			rankItemData = RankItemData.Create(_viewModel.ChallengeCopyRankDatas[itemIndex], _viewModel);
		}
		else if (RankDefinition.CheckTowerRank(curRankType) && _viewModel.TowerCopyRankDatas[itemIndex] != null)
		{
			rankItemData = RankItemData.Create(_viewModel.TowerCopyRankDatas[itemIndex], _viewModel);
		}
		if (rankItemData == null)
		{
			return null;
		}
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(rankItemData);
		}
		else
		{
			component.RefreshData(rankItemData);
		}
		return loopListViewItem;
	}

	private void RefreshRankItems(object sender, InteractionEventArgs e)
	{
		int num = (int)e.Context;
		curRankType = num;
		int num2 = 0;
		if (RankDefinition.CheckSuitBoxCopyRank(curRankType))
		{
			num2 = _viewModel.MultiDatas?.Count ?? 0;
		}
		else if (RankDefinition.CheckRaceCopyRank(curRankType))
		{
			num2 = _viewModel.SingleDatas?.Count ?? 0;
		}
		else if (RankDefinition.CheckHeroChallengeRank(curRankType))
		{
			num2 = _viewModel.HeroChallengeDatas?.Count ?? 0;
		}
		else if (RankDefinition.CheckGuildSevenDayActiveRank(curRankType))
		{
			num2 = _viewModel.GuildActiveRankDatas?.Count ?? 0;
		}
		else if (RankDefinition.CheckGuildCopyRank(curRankType))
		{
			num2 = _viewModel.GuildCopyRankDatas?.Count ?? 0;
		}
		else if (RankDefinition.CheckChallengeCopyRank(curRankType))
		{
			num2 = _viewModel.ChallengeCopyRankDatas?.Count ?? 0;
		}
		else if (RankDefinition.CheckTowerRank(curRankType))
		{
			num2 = _viewModel.TowerCopyRankDatas?.Count ?? 0;
		}
		DRRank dataRow = GameEntry.DataTable.GetDataRow<DRRank>(_viewModel.CurSubType);
		bool flag = dataRow != null && dataRow.RankTarget == 999;
		multiTitleBar.SetActive(RankDefinition.CheckSuitBoxCopyRank(curRankType));
		singleTitleBar.SetActive(RankDefinition.CheckRaceCopyRank(curRankType));
		heroChallengeBar.SetActive(RankDefinition.CheckHeroChallengeRank(curRankType));
		guildActiveBar.SetActive(RankDefinition.CheckGuildSevenDayActiveRank(curRankType));
		guildCopyRankBar.SetActive(RankDefinition.CheckGuildCopyRank(curRankType));
		challengeCopyTotalBar.SetActive(RankDefinition.CheckChallengeCopyRank(curRankType) & flag);
		challengeCopySubBar.SetActive(RankDefinition.CheckChallengeCopyRank(curRankType) && !flag);
		towerCopyBar.SetActive(RankDefinition.CheckTowerRank(curRankType));
		if (RankDefinition.CheckRaceCopyRank(curRankType) && flag)
		{
			singleTitleBar.SetActive(value: false);
			heroChallengeBar.SetActive(value: true);
		}
		nothing.SetActive(num2 <= 0);
		rankTeamScrollRect.SetListItemCount(num2);
		rankTeamScrollRect.RefreshAllShownItem();
		RefreshMyRankItem();
	}

	private void RefreshMyRankItem(object sender = null, InteractionEventArgs e = null)
	{
		if (myRankItems == null)
		{
			return;
		}
		RankItemLayout rankItemLayout = GetRankItemLayout(curRankType, _viewModel.CurSubType);
		for (int i = 0; i < myRankItems.Count; i++)
		{
			if (_viewModel.MyRankEmpty || _viewModel.MyRankItemData == null || i != (int)rankItemLayout)
			{
				myRankItems[i].CanvasGroup.alpha = 0f;
				myRankItems[i].CanvasGroup.blocksRaycasts = false;
				continue;
			}
			if (!myRankItems[i].IsInitHandlerCalled)
			{
				myRankItems[i].Init(_viewModel.MyRankItemData);
			}
			else
			{
				myRankItems[i].RefreshData(_viewModel.MyRankItemData);
			}
			myRankItems[i].CanvasGroup.alpha = 1f;
			myRankItems[i].CanvasGroup.blocksRaycasts = true;
		}
	}

	private RankItemLayout GetRankItemLayout(int rankType, int subType)
	{
		DRRank dataRow = GameEntry.DataTable.GetDataRow<DRRank>(subType);
		bool flag = dataRow != null && dataRow.RankTarget == 999;
		if (RankDefinition.CheckSuitBoxCopyRank(rankType) || (RankDefinition.CheckRaceCopyRank(rankType) && !flag) || (RankDefinition.CheckChallengeCopyRank(rankType) && !flag))
		{
			return RankItemLayout.ScorePlayer1Hero3;
		}
		if (RankDefinition.CheckHeroChallengeRank(rankType) || (RankDefinition.CheckRaceCopyRank(rankType) & flag) || (RankDefinition.CheckChallengeCopyRank(rankType) & flag) || RankDefinition.CheckTowerRank(rankType))
		{
			return RankItemLayout.ScorePlayer1;
		}
		if (RankDefinition.CheckGuildSevenDayActiveRank(rankType) || RankDefinition.CheckGuildCopyRank(rankType))
		{
			return RankItemLayout.Player1Text3;
		}
		return RankItemLayout.ScorePlayer1Hero3;
	}

	protected override void OnDestroy()
	{
		_multiTabPool?.Dispose();
		_multiTabPool = null;
		base.OnDestroy();
	}
}
