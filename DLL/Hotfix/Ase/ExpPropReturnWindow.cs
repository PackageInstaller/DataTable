using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ExpPropReturnWindow : UGuiWindow
{
	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private Button btnCancel;

	[SerializeField]
	private TextMeshProUGUI tips;

	[SerializeField]
	private LoopListView2 propList;

	[SerializeField]
	private RectTransform rTF;

	[SerializeField]
	private ListPaddingCal padding;

	private ExpPropReturnViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ExpPropReturnViewModel>();
		BindingSet<ExpPropReturnWindow, ExpPropReturnViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ExpPropReturnWindow v) => v.OnDismissRequest).To((ExpPropReturnViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((ExpPropReturnViewModel vm) => vm.Cancel);
		bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((ExpPropReturnViewModel vm) => vm.Cancel);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((ExpPropReturnViewModel vm) => vm.Confirm);
		bindingSet.Bind<TextMeshProUGUI>(tips).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ExpPropReturnViewModel vm) => vm.Tips);
		bindingSet.Build();
		InitListParam();
	}

	public void InitListParam()
	{
		propList.ArrangeType = padding.Cal(viewModel.ExpPropList.Count, rTF.rect.width);
		propList.InitListView(viewModel.ExpPropList.Count, OnGetPropItemByIndex);
	}

	private LoopListViewItem2 OnGetPropItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ExpPropList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ExpItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ExpPropList[index]);
			}
			else
			{
				component.RefreshData(viewModel.ExpPropList[index]);
			}
		}
		return loopListViewItem;
	}
}
