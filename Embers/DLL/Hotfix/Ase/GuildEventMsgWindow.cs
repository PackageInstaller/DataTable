using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildEventMsgWindow : UGuiWindow
{
	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private GameObject noEvent;

	[SerializeField]
	private LoopListView2 listView;

	private GuildEventMsgViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<GuildEventMsgViewModel>();
		BindingSet<GuildEventMsgWindow, GuildEventMsgViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((GuildEventMsgWindow v) => v.OnDismissRequest).To((GuildEventMsgViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((GuildEventMsgViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((GuildEventMsgViewModel vm) => vm.Close);
		bindingSet.Build();
		listView.InitListView(_viewModel.EventMsgDatas.Count, OnGetItemByIndex);
		noEvent.SetActive(_viewModel.EventMsgDatas.Count <= 0);
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.EventMsgDatas.Count)
		{
			return null;
		}
		GuildEventMsgData data = _viewModel.EventMsgDatas[index];
		LoopListViewItem2 loopListViewItem = listView.NewListViewItem("GuildEventMsgItem");
		GuildEventMsgItemData userData = new GuildEventMsgItemData(_viewModel, data);
		GuildEventMsgItem component = loopListViewItem.GetComponent<GuildEventMsgItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(userData);
		}
		else
		{
			component.RefreshData(userData);
		}
		return loopListViewItem;
	}
}
