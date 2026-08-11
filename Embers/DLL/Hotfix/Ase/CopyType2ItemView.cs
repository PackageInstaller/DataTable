using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyType2ItemView : CopyPlayUnlockEffectItemView
{
	public int bindingtype = 1;

	public Button btn;

	public new TextMeshProUGUI name;

	public TextMeshProUGUI name2;

	public CopyLockText2Item lockText;

	public GameObject lockRoot;

	public GameObject selectRoot;

	public GameObject normalRoot;

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
		BindingSet<CopyType2ItemView, CopyTypeItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (bindingtype == 1)
		{
			bindingSet.Bind(redRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyTypeItemViewModel vm) => vm.Data.HasNew && !vm.Data.IsLock && vm.Data.HasPlayUnlock);
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyTypeItemViewModel vm) => vm.OptCommand)
				.CommandParameter("OpenType2");
			bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyTypeItemViewModel vm) => vm.Data.CopyTypeName);
			bindingSet.Bind(lockText).For((CopyLockText2Item v) => v.CopyTypeData).To((CopyTypeItemViewModel vm) => vm.Data);
			bindingSet.Bind(lockRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyTypeItemViewModel vm) => vm.Data.IsLock || !vm.Data.HasPlayUnlock);
			bindingSet.Bind().For((CopyType2ItemView v) => v.OnOpt).To((CopyTypeItemViewModel vm) => vm.OptRequest);
		}
		else if (bindingtype == 2)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyTypeItemViewModel vm) => vm.OptCommand)
				.CommandParameter("OpenType2");
			bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).To((CopyTypeItemViewModel vm) => vm.IsSelect);
			bindingSet.Bind(normalRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyTypeItemViewModel vm) => !vm.IsSelect);
			bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyTypeItemViewModel vm) => vm.Data.CopyTypeName);
			bindingSet.Bind<TextMeshProUGUI>(name2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyTypeItemViewModel vm) => vm.Data.CopyTypeName);
			bindingSet.Bind(lockRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyTypeItemViewModel vm) => !vm.Data.IsLock && vm.Data.HasPlayUnlock);
			bindingSet.Bind(redRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyTypeItemViewModel vm) => vm.Data.HasNew && !vm.Data.IsLock && vm.Data.HasPlayUnlock);
			bindingSet.Bind().For((CopyType2ItemView v) => v.OnOpt).To((CopyTypeItemViewModel vm) => vm.OptRequest);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyTypeItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	public bool CheckOpen()
	{
		if (viewModel == null)
		{
			return false;
		}
		return !viewModel.Data.IsLock;
	}
}
