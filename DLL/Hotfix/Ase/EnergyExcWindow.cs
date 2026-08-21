using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EnergyExcWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnBack2;

	[SerializeField]
	private Button btnCancel;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private TextMeshProUGUI tip;

	[SerializeField]
	private GameObject showAddEnergy;

	[SerializeField]
	private GameObject showEnergyMax;

	[SerializeField]
	private TextMeshProUGUI autoAddEnergyText;

	[SerializeField]
	private TextMeshProUGUI autoAddAllEnergyText;

	[SerializeField]
	private LoopListView2 energyItemList;

	private EnergyExcViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<EnergyExcViewModel>();
		BindingSet<EnergyExcWindow, EnergyExcViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((EnergyExcWindow v) => v.OnVisibleChanged).To((EnergyExcViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(this).For((EnergyExcWindow v) => v.OnDismissRequest).To((EnergyExcViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((EnergyExcWindow v) => v.OpenUguiWindow).To((EnergyExcViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((EnergyExcViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((EnergyExcViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((EnergyExcViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind<TextMeshProUGUI>(autoAddEnergyText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EnergyExcViewModel vm) => vm.AutoAddEnergyText);
		bindingSet.Bind<TextMeshProUGUI>(autoAddAllEnergyText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EnergyExcViewModel vm) => vm.AutoAddAllEnergyText);
		bindingSet.Bind(showAddEnergy).For((GameObject v) => v.activeSelf).To((EnergyExcViewModel vm) => vm.ShowAddEnergy);
		bindingSet.Bind(showEnergyMax).For((GameObject v) => v.activeSelf).ToExpression((EnergyExcViewModel vm) => !vm.ShowAddEnergy);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((EnergyExcViewModel vm) => vm.ExcConfirmCmd);
		bindingSet.Bind<TextMeshProUGUI>(tip).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EnergyExcViewModel vm) => vm.EnergyExcItemViewModel.ItemDesc);
		bindingSet.Build();
		energyItemList.InitListView(viewModel.EnergyExcItemViewModels.Count, OnGetEnergyItemByIndex);
	}

	private LoopListViewItem2 OnGetEnergyItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.EnergyExcItemViewModels.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("EnergyItem");
		if (loopListViewItem != null)
		{
			EnergyExcItemView component = loopListViewItem.GetComponent<EnergyExcItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.EnergyExcItemViewModels[index]);
			}
			else
			{
				component.RefreshData(viewModel.EnergyExcItemViewModels[index]);
			}
		}
		return loopListViewItem;
	}
}
