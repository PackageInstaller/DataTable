using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BPCarryItemView : UGuiView
{
	[SerializeField]
	protected Button btn;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject lackMask;

	[SerializeField]
	private GameObject select;

	[SerializeField]
	private GameObject addItem;

	private bool isInit;

	private BPCarryItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (userData == null)
		{
			return;
		}
		if (isInit)
		{
			RefreshData(userData);
			return;
		}
		isInit = true;
		viewModel = GetUserData<BPCarryItemViewModel>(userData);
		BindingSet<BPCarryItemView, BPCarryItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BPCarryItemViewModel vm) => !vm.IsEmpty);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((BPCarryItemViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((BPCarryItemViewModel vm) => vm.OnClick);
		bindingSet.Bind(lackMask).For((GameObject v) => v.activeSelf).ToExpression((BPCarryItemViewModel vm) => !vm.IsEmpty && vm.Count <= 0);
		if (select != null)
		{
			bindingSet.Bind(select).For((GameObject v) => v.activeSelf).To((BPCarryItemViewModel vm) => vm.IsSelect);
		}
		if (addItem != null)
		{
			bindingSet.Bind(addItem).For((GameObject v) => v.activeSelf).ToExpression((BPCarryItemViewModel vm) => vm.IsEmpty && vm.CanAdd);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<BPCarryItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
