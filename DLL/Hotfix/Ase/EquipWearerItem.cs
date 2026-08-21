using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EquipWearerItem : UGuiView
{
	[SerializeField]
	private GameObject selfObj;

	[SerializeField]
	private Image heroImg;

	[SerializeField]
	private TextMeshProUGUI heroName;

	private EquipWearerItemData viewModel;

	public void Init(EquipWearerItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<EquipWearerItem, EquipWearerItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(selfObj).For((GameObject v) => v.activeSelf).ToExpression((EquipWearerItemData vm) => !vm.IsEmpty);
		bindingSet.Bind(heroImg).For((Image v) => v.sprite).ToExpression((EquipWearerItemData vm) => vm.HeroImg)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((EquipWearerItemData vm) => vm.HeroName);
		bindingSet.Build();
	}

	public void RefreshData(EquipWearerItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
