using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CampaignTimelineWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private LoopListView2 timelineList;

	private CampaignTimelineViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<CampaignTimelineViewModel>();
		BindingSet<CampaignTimelineWindow, CampaignTimelineViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((CampaignTimelineWindow v) => v.OnDismissRequest).To((CampaignTimelineViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((CampaignTimelineWindow v) => v.OpenUguiWindow).To((CampaignTimelineViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((CampaignTimelineViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((CampaignTimelineWindow v) => v.RefreshDataList).To((CampaignTimelineViewModel vm) => vm.RefreshDataRequest);
		bindingSet.Build();
		timelineList.InitListView(viewModel.TimelineDataList.Count, OnGetTimeLineItemByIndex);
	}

	private void RefreshDataList(object sender, InteractionEventArgs e)
	{
		timelineList.SetListItemCount(viewModel.TimelineDataList.Count);
		timelineList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetTimeLineItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TimelineDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = (viewModel.TimelineDataList[index].UpDown ? listView2.NewListViewItem("TimeLineGuideItemTop") : listView2.NewListViewItem("TimeLineGuideItemBottom"));
		if (loopListViewItem != null)
		{
			CampaignTimelineItem component = loopListViewItem.GetComponent<CampaignTimelineItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TimelineDataList[index]);
			}
			else
			{
				component.RefreshStoryGuideItem(viewModel.TimelineDataList[index]);
			}
		}
		return loopListViewItem;
	}
}
