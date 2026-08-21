using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class ReportItemView : SelectItemView
{
	public new TextMeshProUGUI name;

	private ReportItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<ReportItemViewModel>(userData);
		BindingSet<ReportItemView, ReportItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if ((UnityEngine.Object)(object)name != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ReportItemViewModel vm) => vm.Name);
		}
		if (selectRoot != null)
		{
			bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).To((ReportItemViewModel vm) => vm.IsSelect);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<ReportItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
