using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourCustomOptionItem : UGuiView
{
	[SerializeField]
	private Button button;

	[SerializeField]
	private List<GameObject> selecteds;

	[SerializeField]
	private Image entryIcon;

	[SerializeField]
	private Image attrIcon;

	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private GameObject fixBg;

	[SerializeField]
	private GameObject interactiveBg;

	[SerializeField]
	private GameObject toggleGo;

	private ArmourCustomOptionItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<ArmourCustomOptionItemData>(userData);
		BindingSet<ArmourCustomOptionItem, ArmourCustomOptionItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(button).For((Button v) => v.enabled).ToExpression((ArmourCustomOptionItemData vm) => (int)vm.Mode == 0);
		bindingSet.Bind(button).For((Button v) => v.onClick).To((ArmourCustomOptionItemData vm) => vm.OnItemClick);
		if (selecteds != null)
		{
			foreach (GameObject selected in selecteds)
			{
				bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((ArmourCustomOptionItemData vm) => vm.Selected);
			}
		}
		bindingSet.Bind(entryIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((ArmourCustomOptionItemData vm) => !string.IsNullOrEmpty(vm.EntryIcon));
		bindingSet.Bind(entryIcon).For((Image v) => v.sprite).To((ArmourCustomOptionItemData vm) => vm.EntryIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(attrIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((ArmourCustomOptionItemData vm) => !string.IsNullOrEmpty(vm.AttrIcon));
		bindingSet.Bind(attrIcon).For((Image v) => v.sprite).To((ArmourCustomOptionItemData vm) => vm.AttrIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(text).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourCustomOptionItemData vm) => vm.Text);
		bindingSet.Bind(toggleGo).For((GameObject v) => v.activeSelf).ToExpression((ArmourCustomOptionItemData vm) => (int)vm.Mode == 0);
		bindingSet.Bind(interactiveBg).For((GameObject v) => v.activeSelf).ToExpression((ArmourCustomOptionItemData vm) => (int)vm.Mode == 0);
		bindingSet.Bind(fixBg).For((GameObject v) => v.activeSelf).ToExpression((ArmourCustomOptionItemData vm) => (int)vm.Mode != 0);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is ArmourCustomOptionItemData armourCustomOptionItemData)
		{
			_viewModel = armourCustomOptionItemData;
			this.SetDataContext(armourCustomOptionItemData);
		}
	}
}
