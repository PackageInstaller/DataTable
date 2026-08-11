using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyType4ItemView : UGuiView
{
	public Button btn;

	public new TextMeshProUGUI name;

	public TextMeshProUGUI name2;

	public GameObject selectRoot;

	public GameObject lockRoot1;

	public GameObject lockRoot2;

	public GameObject normalRoot;

	public GameObject completeRoot1;

	public GameObject completeRoot2;

	public GameObject redRoot;

	private CopyTypeItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyTypeItemViewModel>(userData);
		BindingSet<CopyType4ItemView, CopyTypeItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyTypeItemViewModel vm) => vm.OptCommand);
		bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).To((CopyTypeItemViewModel vm) => vm.IsSelect);
		bindingSet.Bind(normalRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyTypeItemViewModel vm) => !vm.IsSelect);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyTypeItemViewModel vm) => vm.Data.CopyTypeName);
		bindingSet.Bind<TextMeshProUGUI>(name2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyTypeItemViewModel vm) => vm.Data.CopyTypeName);
		bindingSet.Bind(lockRoot1).For((GameObject v) => v.activeSelf).To((CopyTypeItemViewModel vm) => vm.Data.IsLock);
		bindingSet.Bind(lockRoot2).For((GameObject v) => v.activeSelf).To((CopyTypeItemViewModel vm) => vm.Data.IsLock);
		bindingSet.Bind(completeRoot1).For((GameObject v) => v.activeSelf).To((CopyTypeItemViewModel vm) => vm.IsComplete);
		bindingSet.Bind(completeRoot2).For((GameObject v) => v.activeSelf).To((CopyTypeItemViewModel vm) => vm.IsComplete);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyTypeItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
