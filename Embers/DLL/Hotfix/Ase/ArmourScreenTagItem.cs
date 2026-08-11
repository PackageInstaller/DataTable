using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourScreenTagItem : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI showTextNormal;

	[SerializeField]
	private GameObject normalBg;

	[SerializeField]
	private GameObject specialBg;

	[SerializeField]
	private GameObject fixBg;

	[SerializeField]
	private GameObject otherBg;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private Button button;

	[SerializeField]
	private Image color;

	private ArmourScreenTagItemData _viewModel;

	public void Init(ArmourScreenTagItemData viewModel)
	{
		_viewModel = viewModel;
		BindingSet<ArmourScreenTagItem, ArmourScreenTagItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(showTextNormal).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourScreenTagItemData vm) => vm.ShowText);
		bindingSet.Bind(normalBg).For((GameObject v) => v.activeSelf).ToExpression((ArmourScreenTagItemData vm) => vm.BgType == 1);
		bindingSet.Bind(specialBg).For((GameObject v) => v.activeSelf).ToExpression((ArmourScreenTagItemData vm) => vm.BgType == 2);
		bindingSet.Bind(fixBg).For((GameObject v) => v.activeSelf).ToExpression((ArmourScreenTagItemData vm) => vm.BgType == 3);
		bindingSet.Bind(otherBg).For((GameObject v) => v.activeSelf).ToExpression((ArmourScreenTagItemData vm) => vm.BgType == 4);
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((ArmourScreenTagItemData vm) => vm.IsSelected);
		bindingSet.Bind(button).For((Button v) => v.onClick).To((ArmourScreenTagItemData vm) => vm.ButtonOnclick);
		bindingSet.Build();
	}
}
