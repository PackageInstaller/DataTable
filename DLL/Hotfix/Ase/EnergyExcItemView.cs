using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class EnergyExcItemView : KnapsackItemNew
{
	[SerializeField]
	private TextMeshProUGUI itemName;

	private EnergyExcItemViewModel _viewModel;

	public void Init(EnergyExcItemViewModel viewModel)
	{
		_viewModel = viewModel;
		Init((KnapsackItemViewModel)_viewModel);
		BindingSet<EnergyExcItemView, EnergyExcItemViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(itemName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EnergyExcItemViewModel vm) => vm.ItemName);
		bindingSet.Build();
	}

	public void RefreshData(EnergyExcItemViewModel viewModel)
	{
		base.RefreshData(viewModel);
		this.SetDataContext(viewModel);
	}
}
