using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TipWithPropWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnBack2;

	[SerializeField]
	private TextMeshProUGUI title1;

	[SerializeField]
	private TextMeshProUGUI title2;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private Image itemIcon;

	[SerializeField]
	private Image itemRarity;

	private TipWithPropViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<TipWithPropViewModel>();
		BindingSet<TipWithPropWindow, TipWithPropViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TipWithPropWindow v) => v.CloseWindow).To((TipWithPropViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((TipWithPropViewModel vm) => vm.Close);
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((TipWithPropViewModel vm) => vm.Close);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((TipWithPropViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind<TextMeshProUGUI>(title1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TipWithPropViewModel vm) => vm.Title1);
		bindingSet.Bind<TextMeshProUGUI>(title2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TipWithPropViewModel vm) => vm.Title2);
		bindingSet.Bind(itemIcon).For((Image v) => v.sprite).ToExpression((TipWithPropViewModel vm) => vm.ItemIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(itemRarity).For((Image v) => v.sprite).ToExpression((TipWithPropViewModel vm) => $"Rarity_Middle_{vm.ItemRarity}")
			.WithConversion("ItemIcon");
		bindingSet.Build();
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
