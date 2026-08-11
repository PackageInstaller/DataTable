using SuperScrollView;

namespace Ase;

public class GuildActivityView : UGuiView
{
	public LoopListView2 itemList;

	private GuildActivityViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<GuildActivityViewModel>(userData);
		itemList.InitListView(viewModel.ItemDatas.Count, OnGetItemByIndex);
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ItemDatas.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("GuildActivityItemView");
		if (loopListViewItem != null)
		{
			GuildActivityItemView component = loopListViewItem.GetComponent<GuildActivityItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ItemDatas[index]);
			}
			else
			{
				component.RefreshData(viewModel.ItemDatas[index]);
			}
		}
		return loopListViewItem;
	}
}
