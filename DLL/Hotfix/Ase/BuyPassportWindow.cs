using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BuyPassportWindow : UGuiWindowBase
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnGameTip;

	[SerializeField]
	private LoopListView2 passportItemList;

	[SerializeField]
	private RollingView rollingView;

	private BuyPassportViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BuyPassportViewModel>();
		BindingSet<BuyPassportWindow, BuyPassportViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((BuyPassportViewModel vm) => vm.Close);
		bindingSet.Bind(btnGameTip).For((Button v) => v.onClick).To((BuyPassportViewModel vm) => vm.GamePlayCmd);
		bindingSet.Bind(this).For((BuyPassportWindow v) => v.OpenUguiWindow).To((BuyPassportViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((BuyPassportWindow v) => v.CloseWindow).To((BuyPassportViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		rollingView.Init(viewModel.RollingViewModel);
		passportItemList.InitListView(viewModel.PassportItemDataList.Count, OnPassportItemByIndex);
	}

	private LoopListViewItem2 OnPassportItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.PassportItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PassportItem");
		if (loopListViewItem != null)
		{
			PassportItem component = loopListViewItem.GetComponent<PassportItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.PassportItemDataList[index]);
			}
			else
			{
				component.RefreshPassportItem(viewModel.PassportItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
