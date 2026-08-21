using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BuffTestWindow : UGuiWindow
{
	[SerializeField]
	private Button btnHide;

	[SerializeField]
	private LoopListView2 entityList;

	private BuffTestViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BuffTestViewModel>();
		BindingSet<BuffTestWindow, BuffTestViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BuffTestWindow v) => v.OnDismissRequest).To((BuffTestViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BuffTestWindow v) => v.UpdateEntityList).To((BuffTestViewModel vm) => vm.UpdateEntityListRequest);
		bindingSet.Build();
		entityList.InitListView(viewModel.Count, OnGetEntityItemByIndex);
		btnHide.onClick.AddListener(OnHide);
	}

	protected override void OnHide()
	{
		entityList.gameObject.SetActive(!entityList.gameObject.activeSelf);
	}

	private void UpdateEntityList(object sender, InteractionEventArgs e)
	{
		entityList.SetListItemCount(viewModel.Count);
		entityList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetEntityItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("EntityItem");
		if (loopListViewItem != null)
		{
			BTEntityView component = loopListViewItem.GetComponent<BTEntityView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.BteVMs[index]);
			}
			else
			{
				component.RefreshData(viewModel.BteVMs[index]);
			}
		}
		return loopListViewItem;
	}

	private void FixedUpdate()
	{
		viewModel.OnUpdate();
	}
}
