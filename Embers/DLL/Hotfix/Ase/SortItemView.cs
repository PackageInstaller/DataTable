using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SortItemView : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject select;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI nameDisActive;

	private SortItemViewModel viewModel;

	public void Init(SortItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<SortItemView, SortItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((SortItemViewModel vm) => vm.OnSelect);
		bindingSet.Bind(select).For((GameObject v) => v.activeSelf).To((SortItemViewModel vm) => vm.IsSelected);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SortItemViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(nameDisActive).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SortItemViewModel vm) => vm.Name);
		bindingSet.Bind(((Component)(object)nameDisActive).gameObject).For((GameObject v) => v.activeSelf).ToExpression((SortItemViewModel vm) => !vm.IsSelected);
		bindingSet.Build();
	}

	public void RefreshData(SortItemViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
