using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SailLightDispatchWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnGamePlay;

	[SerializeField]
	private LoopListView2 eventList;

	[SerializeField]
	private SailEventDetailView sailEventDetailView;

	[SerializeField]
	private SailStateView sailStateView;

	private SailLightDispatchViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<SailLightDispatchViewModel>();
		BindingSet<SailLightDispatchWindow, SailLightDispatchViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((SailLightDispatchWindow v) => v.CloseWindow).To((SailLightDispatchViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((SailLightDispatchWindow v) => v.OpenUguiWindow).To((SailLightDispatchViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((SailLightDispatchViewModel vm) => vm.Close);
		bindingSet.Bind(btnGamePlay).For((Button v) => v.onClick).To((SailLightDispatchViewModel vm) => vm.OpenGamePlayWindow);
		bindingSet.Bind(this).For((SailLightDispatchWindow v) => v.RefreshEventList).To((SailLightDispatchViewModel vm) => vm.RefreshEventListRequest);
		bindingSet.Build();
		eventList.InitListView(viewModel.SailEventItemDataList.Count, OnGetSailEventItemByIndex);
		if (viewModel.SailEventItemDataList.Count > 0)
		{
			sailEventDetailView.Init(viewModel.SailEventDetailViewModel);
			sailEventDetailView.gameObject.SetActive(value: true);
		}
		if (viewModel.SailEventItemDataList.Count > 0)
		{
			sailStateView.Init(viewModel.SailStateViewModel);
			sailStateView.gameObject.SetActive(value: true);
		}
	}

	private LoopListViewItem2 OnGetSailEventItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.SailEventItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("SailEventItem");
		if (loopListViewItem != null)
		{
			SailEventItem component = loopListViewItem.GetComponent<SailEventItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.SailEventItemDataList[index]);
			}
			else
			{
				component.RefreshSailEvent(viewModel.SailEventItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void RefreshEventList(object sender, InteractionEventArgs e)
	{
		eventList.SetListItemCount(viewModel.SailEventItemDataList.Count);
		eventList.RefreshAllShownItem();
		sailEventDetailView.gameObject.SetActive(!viewModel.IsEmpty);
		sailStateView.gameObject.SetActive(!viewModel.IsEmpty);
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
