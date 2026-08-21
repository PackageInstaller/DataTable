using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardInfoItem : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Button btn;

	private DrawCardInfoItemData viewModel;

	public void Init(DrawCardInfoItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<DrawCardInfoItem, DrawCardInfoItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((DrawCardInfoItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((DrawCardInfoItemData vm) => vm.OpenWindowCmd);
		bindingSet.Build();
	}
}
