using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class RockResultItem : UGuiView
{
	[SerializeField]
	private GameObject type1;

	[SerializeField]
	private GameObject type2;

	[SerializeField]
	private TextMeshProUGUI title1;

	[SerializeField]
	private TextMeshProUGUI title2;

	[SerializeField]
	private TextMeshProUGUI exText;

	private RockResultItemData viewModel;

	public void Init(RockResultItemData viewModel)
	{
		this.viewModel = viewModel;
		Init((object)this.viewModel);
		BindingSet<RockResultItem, RockResultItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(type1).For((GameObject v) => v.activeSelf).ToExpression((RockResultItemData vm) => vm.Type == 1);
		bindingSet.Bind(type2).For((GameObject v) => v.activeSelf).ToExpression((RockResultItemData vm) => vm.Type == 2);
		bindingSet.Bind<TextMeshProUGUI>(title1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockResultItemData vm) => vm.Title);
		bindingSet.Bind<TextMeshProUGUI>(title2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockResultItemData vm) => vm.Title);
		bindingSet.Bind<TextMeshProUGUI>(exText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockResultItemData vm) => vm.ExText);
		bindingSet.Build();
	}

	public void RefreshResultData(RockResultItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
