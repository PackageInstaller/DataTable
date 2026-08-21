using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ToggleItemView : UGuiView
{
	[SerializeField]
	private Button btnSel;

	[SerializeField]
	private TextMeshProUGUI name1;

	[SerializeField]
	private TextMeshProUGUI name2;

	[SerializeField]
	private GameObject selectRoot;

	[SerializeField]
	private GameObject redRoot;

	private ToggleItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<ToggleItemViewModel>(userData);
		BindingSet<ToggleItemView, ToggleItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).To((ToggleItemViewModel vm) => vm.IsSelect);
		bindingSet.Bind(redRoot).For((GameObject v) => v.activeSelf).To((ToggleItemViewModel vm) => vm.Red);
		bindingSet.Bind<TextMeshProUGUI>(name1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ToggleItemViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(name2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ToggleItemViewModel vm) => vm.Name);
		bindingSet.Bind(btnSel).For((Button v) => v.onClick).To((ToggleItemViewModel vm) => vm.OnSelect);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<ToggleItemViewModel>(viewModel);
		this.SetDataContext(viewModel);
	}
}
