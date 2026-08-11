using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourCustomWindow : UGuiWindow
{
	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnCancel;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private RectTransform optionRoot;

	[SerializeField]
	private ArmourCustomGroupItem optionGroupTpl;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private GameObject btnConfirmMask;

	private GameObjectPool _optionGroupPool;

	private ArmourCustomViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<ArmourCustomViewModel>();
		_optionGroupPool = new GameObjectPool(optionGroupTpl.gameObject, optionRoot);
		BindingSet<ArmourCustomWindow, ArmourCustomViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((ArmourCustomWindow v) => v.OnDismissRequest).To((ArmourCustomViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((ArmourCustomWindow v) => v.OpenUguiWindow).To((ArmourCustomViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((ArmourCustomViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((ArmourCustomViewModel vm) => vm.Close);
		bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((ArmourCustomViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourCustomViewModel vm) => vm.Title);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((ArmourCustomViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(btnConfirmMask).For((GameObject v) => v.activeSelf).ToExpression((ArmourCustomViewModel vm) => !vm.EnableConfirm);
		bindingSet.Build();
		RefreshOptionGroups();
	}

	private void RefreshOptionGroups()
	{
		_optionGroupPool.RecycleAll();
		if (_viewModel.OptionGroupDataList == null)
		{
			return;
		}
		foreach (ArmourCustomGroupData optionGroupData in _viewModel.OptionGroupDataList)
		{
			ArmourCustomGroupItem component = _optionGroupPool.Allocate(out var newCreate).GetComponent<ArmourCustomGroupItem>();
			if (newCreate)
			{
				component.Init(optionGroupData);
			}
			else
			{
				component.RefreshData(optionGroupData);
			}
		}
	}
}
