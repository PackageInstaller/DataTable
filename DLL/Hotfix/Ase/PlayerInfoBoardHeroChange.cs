using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PlayerInfoBoardHeroChange : UGuiView
{
	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private Button saveBtn;

	[SerializeField]
	private LoopListView2 spineListView;

	[SerializeField]
	private LoopGridView heroGridView;

	private PlayerInfoBoardHeroChangeViewModel viewModel;

	private int curSpineItemIndex = -1;

	private int curBoardHeroIndex = -1;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<PlayerInfoBoardHeroChangeViewModel>(userData);
		BindingSet<PlayerInfoBoardHeroChange, PlayerInfoBoardHeroChangeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((PlayerInfoBoardHeroChangeViewModel vm) => vm.BackCmd);
		bindingSet.Bind(saveBtn).For((Button v) => v.onClick).To((PlayerInfoBoardHeroChangeViewModel vm) => vm.SaveCmd);
		bindingSet.Bind(this).For((PlayerInfoBoardHeroChange v) => ((UGuiView)v).OnVisibleChanged).To((PlayerInfoBoardHeroChangeViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind().For((PlayerInfoBoardHeroChange v) => RefreshHeroGridView).To((PlayerInfoBoardHeroChangeViewModel vm) => vm.RefreshHeroListRst);
		bindingSet.Bind().For((PlayerInfoBoardHeroChange v) => RefreshSpineListView).To((PlayerInfoBoardHeroChangeViewModel vm) => vm.RefreshSpineListRst);
		bindingSet.Build();
		InitSpineListView();
		InitHeroGridView();
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		Visibility = viewModel.IsVisible;
		if (viewModel.IsVisible)
		{
			RefreshHeroGridView(null, null);
			RefreshSpineListView(null, null);
		}
	}

	private void InitSpineListView()
	{
		spineListView.InitListView(viewModel.ScreenHeroDatas.Count, OnGetSpineListItemByIndex);
		if (curSpineItemIndex >= 0)
		{
			spineListView.MovePanelToItemIndex(curSpineItemIndex, 0f);
		}
	}

	private void GetCurSpineItemIndex()
	{
		curSpineItemIndex = 0;
		DRBoardHeroList dataRow = GameEntry.DataTable.GetDataRow<DRBoardHeroList>(viewModel.CurrentBoardData.BoardHeroId);
		if (dataRow == null)
		{
			return;
		}
		if (viewModel.CurSelectHeroItemData != null && viewModel.CurSelectHeroItemData.HeroId == dataRow.HeroId)
		{
			curSpineItemIndex = viewModel.ScreenHeroDatas.FindIndex((BoardChangeItemData p) => p.DrHero.Id == viewModel.CurrentBoardData.BoardHeroId);
		}
		if (curSpineItemIndex < 0)
		{
			curSpineItemIndex = 0;
		}
	}

	private LoopListViewItem2 OnGetSpineListItemByIndex(LoopListView2 arg1, int itemIndex)
	{
		if (itemIndex < 0 || itemIndex > viewModel.ScreenHeroDatas.Count)
		{
			return null;
		}
		BoardChangeItemData boardChangeItemData = viewModel.ScreenHeroDatas[itemIndex];
		if (boardChangeItemData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = arg1.NewListViewItem("BoardChangeItem");
		BoardChangeItem component = loopListViewItem.GetComponent<BoardChangeItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(boardChangeItemData);
		}
		else
		{
			component.RefreshData(boardChangeItemData);
		}
		if (itemIndex == curSpineItemIndex)
		{
			viewModel.SetSpineItemSelected(boardChangeItemData);
		}
		return loopListViewItem;
	}

	private void RefreshSpineListView(object sender, InteractionEventArgs e)
	{
		GetCurSpineItemIndex();
		spineListView.SetListItemCount(viewModel.ScreenHeroDatas.Count);
		spineListView.RefreshAllShownItem();
		if (curSpineItemIndex >= 0)
		{
			spineListView.MovePanelToItemIndex(curSpineItemIndex, 0f);
		}
	}

	private void RefreshHeroGridView(object sender, InteractionEventArgs e)
	{
		GetCurBoardHeroIndex();
		heroGridView.SetListItemCount(viewModel.HeroIdList.Count);
		heroGridView.RefreshAllShownItem();
		if (curBoardHeroIndex >= 0)
		{
			heroGridView.MovePanelToItemByIndex(curBoardHeroIndex);
		}
	}

	private void InitHeroGridView()
	{
		GetCurBoardHeroIndex();
		heroGridView.InitGridView(viewModel.HeroIdList.Count, OnGetHeroItemByIndex);
		if (curBoardHeroIndex >= 0)
		{
			heroGridView.MovePanelToItemByIndex(curBoardHeroIndex);
		}
	}

	private void GetCurBoardHeroIndex()
	{
		DRBoardHeroList drBoardHeroList = GameEntry.DataTable.GetDataRow<DRBoardHeroList>(viewModel.CurrentBoardData.BoardHeroId);
		curBoardHeroIndex = ((drBoardHeroList != null) ? viewModel.HeroIdList.FindIndex((int p) => p == drBoardHeroList.HeroId) : 0);
	}

	protected LoopGridViewItem OnGetHeroItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.HeroIdList.Count)
		{
			return null;
		}
		int num = viewModel.HeroIdList[index];
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("BoardHeroItem");
		if (loopGridViewItem != null)
		{
			BoardHeroItemData boardHeroItemData = new BoardHeroItemData(viewModel, num);
			BoardHeroItem component = loopGridViewItem.GetComponent<BoardHeroItem>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(boardHeroItemData);
			}
			else
			{
				component.RefreshData(boardHeroItemData);
			}
			bool showCustomTag = curBoardHeroIndex >= 0 && index == curBoardHeroIndex;
			bool selected = viewModel.CurSelectHeroItemData != null && num == viewModel.CurSelectHeroItemData.HeroId;
			boardHeroItemData.SetShowCustomTag(showCustomTag);
			boardHeroItemData.SetSelected(selected);
		}
		return loopGridViewItem;
	}
}
