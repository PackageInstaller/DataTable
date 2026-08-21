using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DropdowmItemView : UGuiView
{
	[SerializeField]
	private Toggle toggle;

	[SerializeField]
	private TextMeshProUGUI textDisctive;

	[SerializeField]
	private GameObject textActive;

	private DropdowmItemViewModel viewModel;

	public void Init(DropdowmItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<DropdowmItemView, DropdowmItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(textActive).For((GameObject v) => v.activeSelf).ToExpression((DropdowmItemViewModel vm) => vm.IsOn);
		bindingSet.Bind(((Component)(object)textDisctive).gameObject).For((GameObject v) => v.activeSelf).ToExpression((DropdowmItemViewModel vm) => !vm.IsOn);
		bindingSet.Bind<TextMeshProUGUI>(textDisctive).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((DropdowmItemViewModel vm) => vm.Desc);
		bindingSet.Build();
		toggle.onValueChanged.AddListener(this.viewModel.OnClick);
	}

	public void RefreshData(DropdowmItemViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
