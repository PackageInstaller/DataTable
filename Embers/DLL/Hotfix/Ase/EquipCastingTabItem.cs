using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EquipCastingTabItem : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private GameObject normal;

	private EquipCastingTabItemData viewModel;

	public void Init(EquipCastingTabItemData viewModel)
	{
		if (viewModel != null)
		{
			this.viewModel = viewModel;
			BindingSet<EquipCastingTabItem, EquipCastingTabItemData> bindingSet = this.CreateBindingSet(this.viewModel);
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((EquipCastingTabItemData vm) => vm.TabOnClick);
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((EquipCastingTabItemData vm) => vm.IsSelected);
			bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((EquipCastingTabItemData vm) => !vm.IsSelected);
			bindingSet.Build();
		}
	}
}
