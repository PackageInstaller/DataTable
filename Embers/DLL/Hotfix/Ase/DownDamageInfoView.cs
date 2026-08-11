using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class DownDamageInfoView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI damageText;

	[SerializeField]
	private TextMeshProUGUI indexText;

	[SerializeField]
	private GameObject line;

	[SerializeField]
	private GameObject icon1;

	[SerializeField]
	private GameObject icon2;

	[SerializeField]
	private GameObject icon3;

	private DamageInfoViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = userData as DamageInfoViewModel;
		BindingSet<DownDamageInfoView, DamageInfoViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(damageText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DamageInfoViewModel vm) => vm.DownDamageText);
		bindingSet.Bind<TextMeshProUGUI>(indexText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((DamageInfoViewModel vm) => $"{vm.ShowIndex}");
		bindingSet.Bind(line).For((GameObject v) => v.activeSelf).ToExpression((DamageInfoViewModel vm) => vm.ShowIndex != 1);
		bindingSet.Bind(icon1).For((GameObject v) => v.activeSelf).ToExpression((DamageInfoViewModel vm) => vm.ShowIndex == 1);
		bindingSet.Bind(icon2).For((GameObject v) => v.activeSelf).ToExpression((DamageInfoViewModel vm) => vm.ShowIndex == 2);
		bindingSet.Bind(icon3).For((GameObject v) => v.activeSelf).ToExpression((DamageInfoViewModel vm) => vm.ShowIndex == 3);
		bindingSet.Build();
	}

	public void UpdateData(DamageInfoViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
