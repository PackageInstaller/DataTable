using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PayItemView : UIView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject first;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI addtion;

	[SerializeField]
	private GameObject addtionRoot;

	[SerializeField]
	private TextMeshProUGUI moneyText;

	[SerializeField]
	private TextMeshProUGUI amount;

	private PayItemViewModel viewModel;

	public void Init(PayItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<PayItemView, PayItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(first).For((GameObject v) => v.activeSelf).To((PayItemViewModel vm) => vm.IsFirst);
		bindingSet.Bind<TextMeshProUGUI>(addtion).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PayItemViewModel vm) => vm.DiamondAdd);
		bindingSet.Bind(addtionRoot).For((GameObject v) => v.activeSelf).ToExpression((PayItemViewModel vm) => vm.DiamondAdd > 0);
		bindingSet.Bind<TextMeshProUGUI>(moneyText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PayItemViewModel vm) => vm.PriceText);
		bindingSet.Bind<TextMeshProUGUI>(amount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PayItemViewModel vm) => $"{vm.Diamond}枚{vm.Name}");
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((PayItemViewModel vm) => $"{vm.Icon}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((PayItemViewModel vm) => vm.OnPay);
		bindingSet.Build();
	}

	public void RefreshData(PayItemViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
