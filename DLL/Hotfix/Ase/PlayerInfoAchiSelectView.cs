using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PlayerInfoAchiSelectView : UGuiView
{
	[SerializeField]
	private GameObject showAchiInfoObj;

	[SerializeField]
	private Button cacelBtn;

	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private Button saveBtn;

	[SerializeField]
	private LoopGridView achiListView;

	[SerializeField]
	private TextMeshProUGUI rankTxt;

	[SerializeField]
	private GameObject rankUpArrow;

	[SerializeField]
	private GameObject rankDownArrow;

	[SerializeField]
	private Button showRankBtn;

	[SerializeField]
	private GameObject showRankObj;

	[SerializeField]
	private Button mrBtn;

	[SerializeField]
	private Button topBtn;

	[SerializeField]
	private Button downBtn;

	[SerializeField]
	private Button rankBgBtn;

	[SerializeField]
	private TextMeshProUGUI filterTxt;

	[SerializeField]
	private Button showFilterbtn;

	[SerializeField]
	private LoopGridView filterListView;

	[SerializeField]
	private GameObject filterObj;

	[SerializeField]
	private Button filterBgBtn;

	public PlayerInfoShowAchiInfoView playerInfoShowAchiInfoView;

	private PlayerInfoAchiSelectViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<PlayerInfoAchiSelectViewModel>(userData);
		BindingSet<PlayerInfoAchiSelectView, PlayerInfoAchiSelectViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((PlayerInfoAchiSelectView v) => ((UGuiView)v).OnVisibleChanged).To((PlayerInfoAchiSelectViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(cacelBtn).For((Button v) => v.onClick).To((PlayerInfoAchiSelectViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((PlayerInfoAchiSelectViewModel vm) => vm.CloseOrSave);
		bindingSet.Bind(saveBtn).For((Button v) => v.onClick).To((PlayerInfoAchiSelectViewModel vm) => vm.OptCommand)
			.CommandParameter("OnSave");
		bindingSet.Bind(showAchiInfoObj).For((GameObject v) => v.activeSelf).ToExpression((PlayerInfoAchiSelectViewModel vm) => vm.IsShowAchiInfoView);
		bindingSet.Bind(showRankObj).For((GameObject v) => v.activeSelf).ToExpression((PlayerInfoAchiSelectViewModel vm) => vm.IsShowRank);
		bindingSet.Bind<TextMeshProUGUI>(rankTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PlayerInfoAchiSelectViewModel vm) => vm.RankTxt);
		bindingSet.Bind(rankUpArrow).For((GameObject v) => v.activeSelf).ToExpression((PlayerInfoAchiSelectViewModel vm) => vm.IsShowUpArrow);
		bindingSet.Bind(rankDownArrow).For((GameObject v) => v.activeSelf).ToExpression((PlayerInfoAchiSelectViewModel vm) => vm.IsShowDownArrow);
		bindingSet.Bind(showRankBtn).For((Button v) => v.onClick).To((PlayerInfoAchiSelectViewModel vm) => vm.OptCommand)
			.CommandParameter("ShowRank");
		bindingSet.Bind(mrBtn).For((Button v) => v.onClick).To((PlayerInfoAchiSelectViewModel vm) => vm.OptCommand)
			.CommandParameter("MRSort");
		bindingSet.Bind(topBtn).For((Button v) => v.onClick).To((PlayerInfoAchiSelectViewModel vm) => vm.OptCommand)
			.CommandParameter("TopSort");
		bindingSet.Bind(downBtn).For((Button v) => v.onClick).To((PlayerInfoAchiSelectViewModel vm) => vm.OptCommand)
			.CommandParameter("DownSort");
		bindingSet.Bind(rankBgBtn).For((Button v) => v.onClick).To((PlayerInfoAchiSelectViewModel vm) => vm.OptCommand)
			.CommandParameter("RankBg");
		bindingSet.Bind<TextMeshProUGUI>(filterTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PlayerInfoAchiSelectViewModel vm) => vm.FilterTxt);
		bindingSet.Bind(filterObj).For((GameObject v) => v.activeSelf).ToExpression((PlayerInfoAchiSelectViewModel vm) => vm.IsShowFilter);
		bindingSet.Bind(showFilterbtn).For((Button v) => v.onClick).To((PlayerInfoAchiSelectViewModel vm) => vm.OptCommand)
			.CommandParameter("ShowFilter");
		bindingSet.Bind(filterBgBtn).For((Button v) => v.onClick).To((PlayerInfoAchiSelectViewModel vm) => vm.OptCommand)
			.CommandParameter("FilterBg");
		bindingSet.Bind(this).For((PlayerInfoAchiSelectView v) => v.UpdateList).To((PlayerInfoAchiSelectViewModel vm) => vm.UpdateAchiListRequest);
		bindingSet.Build();
		playerInfoShowAchiInfoView.Init(viewModel.CurShowAchiInfoVM);
		achiListView.InitGridView(viewModel.AchiItemDatas.Count, OnGetItemByIndex);
		filterListView.InitGridView(viewModel.FilterList.Count, OnGetTabItemByIndex);
	}

	private LoopGridViewItem OnGetTabItemByIndex(LoopGridView view, int itemIndex, int row, int column)
	{
		if (itemIndex < 0 || itemIndex > viewModel.FilterList.Count)
		{
			return null;
		}
		TabItemNormalData tabItemNormalData = viewModel.FilterList[itemIndex];
		if (tabItemNormalData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = view.NewListViewItem("FilterItem");
		TabItemNormal component = loopGridViewItem.GetComponent<TabItemNormal>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(tabItemNormalData);
		}
		else
		{
			component.RefreshData(tabItemNormalData);
		}
		return loopGridViewItem;
	}

	protected override void OnEnable()
	{
		if (viewModel != null)
		{
			viewModel.Refresh();
			UpdateList(null, null);
		}
	}

	private void UpdateList(object sender, InteractionEventArgs e)
	{
		achiListView.SetListItemCount(viewModel.AchiItemDatas.Count);
		achiListView.RefreshAllShownItem();
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		Visibility = viewModel.IsVisible;
	}

	public LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int itemIndex, int row, int column)
	{
		if (itemIndex < 0 || itemIndex > viewModel.AchiItemDatas.Count)
		{
			return null;
		}
		AchiItemData achiItemData = viewModel.AchiItemDatas[itemIndex];
		if (achiItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = arg1.NewListViewItem("AchiItem");
		AchiItem component = loopGridViewItem.GetComponent<AchiItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(achiItemData);
		}
		else
		{
			component.RefreshData(achiItemData);
		}
		return loopGridViewItem;
	}
}
