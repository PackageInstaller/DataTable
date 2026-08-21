using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CMSortItemView : UGuiView
{
	public Button btn;

	public Image icon;

	public new TextMeshProUGUI name;

	public TextMeshProUGUI name2;

	public GameObject selectRoot;

	private CMSortItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CMSortItemViewModel>(userData);
		BindingSet<CMSortItemView, CMSortItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((CMSortItemViewModel vm) => vm.OnSelect);
		}
		if (selectRoot != null)
		{
			bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).To((CMSortItemViewModel vm) => vm.IsSelect);
		}
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CMSortItemViewModel vm) => vm.Name);
		if ((UnityEngine.Object)(object)name2 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(name2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CMSortItemViewModel vm) => vm.Name);
			bindingSet.Bind(((Component)(object)name).gameObject).For((GameObject v) => v.activeSelf).ToExpression((CMSortItemViewModel vm) => !vm.IsSelect);
		}
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((CMSortItemViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CMSortItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
