using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class StarConditionItemView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI conditonText;

	[SerializeField]
	private TextMeshProUGUI conditonTextComplete;

	private StarConditionItemData viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<StarConditionItemData>(userData);
		BindingSet<StarConditionItemView, StarConditionItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(conditonText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StarConditionItemData vm) => vm.Condition);
		bindingSet.Bind<TextMeshProUGUI>(conditonTextComplete).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StarConditionItemData vm) => vm.Condition);
		bindingSet.Bind(((Component)(object)conditonText).gameObject).For((GameObject v) => v.activeSelf).ToExpression((StarConditionItemData vm) => !vm.IsTrue);
		bindingSet.Bind(((Component)(object)conditonTextComplete).gameObject).For((GameObject v) => v.activeSelf).ToExpression((StarConditionItemData vm) => vm.IsTrue);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<StarConditionItemData>(userData);
		this.SetDataContext(viewModel);
	}
}
