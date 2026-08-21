using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BSItemView : UGuiView
{
	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI damage;

	[SerializeField]
	private Image proportion;

	protected BSItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<BSItemViewModel>(userData);
		BindingSet<BSItemView, BSItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BSItemViewModel vm) => vm.StatisticName);
		bindingSet.Bind<TextMeshProUGUI>(damage).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BSItemViewModel vm) => vm.TotalValue);
		bindingSet.Bind(proportion).For((Image v) => v.fillAmount).ToExpression((BSItemViewModel vm) => vm.Proportion);
		bindingSet.Bind(proportion).For((Image v) => v.color).ToExpression((BSItemViewModel vm) => vm.Color);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<BSItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
