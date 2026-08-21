using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class HeroWarehouseSelectedSortButtonView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI text;

	private HeroWarehouseSortButtonViewModel _viewModel;

	public void Init(HeroWarehouseSortButtonViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<HeroWarehouseSelectedSortButtonView, HeroWarehouseSortButtonViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(text).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroWarehouseSortButtonViewModel vm) => vm.ShowText);
		bindingSet.Build();
	}

	public void RefreshData(HeroWarehouseSortButtonViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
