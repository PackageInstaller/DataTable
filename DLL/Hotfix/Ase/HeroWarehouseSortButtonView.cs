using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroWarehouseSortButtonView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI showTextNormal;

	[SerializeField]
	private TextMeshProUGUI showTextSelected;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private Button button;

	private HeroWarehouseSortButtonViewModel _viewModel;

	public void Init(HeroWarehouseSortButtonViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<HeroWarehouseSortButtonView, HeroWarehouseSortButtonViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(showTextNormal).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroWarehouseSortButtonViewModel vm) => vm.ShowText);
		bindingSet.Bind<TextMeshProUGUI>(showTextSelected).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroWarehouseSortButtonViewModel vm) => vm.ShowText);
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((HeroWarehouseSortButtonViewModel vm) => vm.IsSelected);
		bindingSet.Bind(button).For((Button v) => v.onClick).To((HeroWarehouseSortButtonViewModel vm) => vm.ButtonOnclick);
		bindingSet.Build();
	}

	public void RefreshData(HeroWarehouseSortButtonViewModel viewModel)
	{
		_viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
