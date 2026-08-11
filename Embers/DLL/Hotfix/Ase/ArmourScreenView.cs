using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourScreenView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private GameObject normalBg;

	[SerializeField]
	private GameObject specialBg;

	[SerializeField]
	private GameObject fixBg;

	[SerializeField]
	private GameObject otherBg;

	[SerializeField]
	private Button btn;

	private ArmourScreenTagItemData _viewModel;

	public void Init(ArmourScreenTagItemData viewModel)
	{
		_viewModel = viewModel;
		BindingSet<ArmourScreenView, ArmourScreenTagItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (normalBg != null)
		{
			bindingSet.Bind(normalBg).For((GameObject v) => v.activeSelf).ToExpression((ArmourScreenTagItemData vm) => vm.BgType == 1);
		}
		if (specialBg != null)
		{
			bindingSet.Bind(specialBg).For((GameObject v) => v.activeSelf).ToExpression((ArmourScreenTagItemData vm) => vm.BgType == 2);
		}
		if (fixBg != null)
		{
			bindingSet.Bind(fixBg).For((GameObject v) => v.activeSelf).ToExpression((ArmourScreenTagItemData vm) => vm.BgType == 3);
		}
		if (otherBg != null)
		{
			bindingSet.Bind(otherBg).For((GameObject v) => v.activeSelf).ToExpression((ArmourScreenTagItemData vm) => vm.BgType == 4);
		}
		bindingSet.Bind<TextMeshProUGUI>(text).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourScreenTagItemData vm) => vm.ShowText);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((ArmourScreenTagItemData vm) => vm.ButtonOnclick);
		bindingSet.Build();
	}

	public void RefreshData(ArmourScreenTagItemData viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
