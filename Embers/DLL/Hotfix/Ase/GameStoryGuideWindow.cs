using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameStoryGuideWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TabItemNormal switchBtn;

	[SerializeField]
	private LoopListView2 chapterList;

	[SerializeField]
	private LoopListView2 storyList;

	[SerializeField]
	private ScrollRect timelineScrollRect;

	[SerializeField]
	private LoopListView2 timelineList;

	[SerializeField]
	private LoopGridView photoList;

	[SerializeField]
	private GameObject infoObj;

	[SerializeField]
	private GameObject emptyObj;

	[SerializeField]
	private GameObject storyListObj;

	[SerializeField]
	private GameObject timeLineObj;

	private GameStoryGuideViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GameStoryGuideViewModel>();
		BindingSet<GameStoryGuideWindow, GameStoryGuideViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GameStoryGuideViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((GameStoryGuideWindow v) => v.OpenUguiWindow).To((GameStoryGuideViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GameStoryGuideWindow v) => v.CloseWindow).To((GameStoryGuideViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(infoObj).For((GameObject v) => v.activeSelf).ToExpression((GameStoryGuideViewModel vm) => !vm.IsEmpty);
		bindingSet.Bind(emptyObj).For((GameObject v) => v.activeSelf).To((GameStoryGuideViewModel vm) => vm.IsEmpty);
		bindingSet.Bind(storyListObj).For((GameObject v) => v.activeSelf).To((GameStoryGuideViewModel vm) => vm.BtnSwitch.IsSelected);
		bindingSet.Bind(timeLineObj).For((GameObject v) => v.activeSelf).ToExpression((GameStoryGuideViewModel vm) => !vm.BtnSwitch.IsSelected);
		bindingSet.Bind(this).For((GameStoryGuideWindow v) => v.RefreshDataList).To((GameStoryGuideViewModel vm) => vm.RefreshDataRequest);
		bindingSet.Build();
		switchBtn.Init(viewModel.BtnSwitch);
		chapterList.InitListView(viewModel.ChapterDataList.Count, OnGetChapterItemByIndex);
		storyList.InitListView(viewModel.StoryTypeList.Count, OnGetStoryTypeItemByIndex);
		timelineList.InitListView(viewModel.ShowTimeLineDataList.Count, OnGetTimeLineItemByIndex);
		photoList.InitGridView(viewModel.ShowPhotoDataList.Count, OnGetPhotoItemByIndex);
		SuitSetting();
	}

	private void SuitSetting()
	{
		int count = ((RectTransform.rect.width >= 2200f) ? 3 : 2);
		photoList.SetGridFixedGroupCount(GridFixedType.ColumnCountFixed, count);
	}

	private void RefreshDataList(object sender, InteractionEventArgs e)
	{
		chapterList.SetListItemCount(viewModel.ChapterDataList.Count);
		chapterList.RefreshAllShownItem();
		timelineList.SetListItemCount(viewModel.ShowTimeLineDataList.Count);
		timelineList.RefreshAllShownItem();
		timelineScrollRect.horizontalNormalizedPosition = 0f;
		photoList.SetListItemCount(viewModel.ShowPhotoDataList.Count);
		photoList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetChapterItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ChapterDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ChapterItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ChapterDataList[index]);
			}
			else
			{
				component.RefreshData(viewModel.ChapterDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetStoryTypeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.StoryTypeList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("StoryTypeItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.StoryTypeList[index]);
			}
			else
			{
				component.RefreshData(viewModel.StoryTypeList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetTimeLineItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ShowTimeLineDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = (viewModel.ShowTimeLineDataList[index].UpDown ? listView2.NewListViewItem("TimeLineGuideItemTop") : listView2.NewListViewItem("TimeLineGuideItemBottom"));
		if (loopListViewItem != null)
		{
			GameStoryGuideItem component = loopListViewItem.GetComponent<GameStoryGuideItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ShowTimeLineDataList[index]);
			}
			else
			{
				component.RefreshStoryGuideItem(viewModel.ShowTimeLineDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopGridViewItem OnGetPhotoItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		GameStoryGuideItemData gameStoryGuideItemData = viewModel.ShowPhotoDataList[index];
		if (gameStoryGuideItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = photoList.NewListViewItem("PhotoItem");
		GameStoryGuideItem component = loopGridViewItem.GetComponent<GameStoryGuideItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(gameStoryGuideItemData);
		}
		else
		{
			component.RefreshStoryGuideItem(gameStoryGuideItemData);
		}
		return loopGridViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
