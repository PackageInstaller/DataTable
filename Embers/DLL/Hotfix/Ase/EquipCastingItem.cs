using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EquipCastingItem : KnapsackItemNew
{
	[SerializeField]
	private GameObject isLocked;

	[SerializeField]
	private Button btnSelf;

	[SerializeField]
	private TextMeshProUGUI nameText;

	private EquipCastingItemData viewModel;

	public void Init(EquipCastingItemData viewModel)
	{
		this.viewModel = viewModel;
		Init((KnapsackItemViewModel)viewModel);
		BindingSet<EquipCastingItem, EquipCastingItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(isLocked).For((GameObject v) => v.activeSelf).To((EquipCastingItemData vm) => vm.IsLocked);
		bindingSet.Bind(btnSelf).For((Button v) => v.onClick).To((EquipCastingItemData vm) => vm.CastingItemOnClick);
		bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).To((EquipCastingItemData vm) => vm.TextColor);
		bindingSet.Build();
		IconSetNativeSize();
	}

	public void RefreshData(EquipCastingItemData viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
