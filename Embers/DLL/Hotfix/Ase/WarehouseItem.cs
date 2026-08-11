using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class WarehouseItem : KnapsackItemNew
{
	[SerializeField]
	private float pressSpeed;

	[SerializeField]
	private GameObject selectPanel;

	[SerializeField]
	private ButtonLong btnAddSelect;

	[SerializeField]
	private ButtonLong btnDecSelect;

	[SerializeField]
	private TextMeshProUGUI selectCount;

	private WarehouseItemData _viewModel;

	public void Init(WarehouseItemData data)
	{
		Init((KnapsackItemViewModel)data);
		_viewModel = data;
		BindingSet<WarehouseItem, WarehouseItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(selectPanel).For((GameObject v) => v.activeSelf).To((WarehouseItemData vm) => vm.ShowSelectPanel);
		bindingSet.Bind(btnAddSelect).For((ButtonLong v) => v.onClick).To((WarehouseItemData vm) => vm.OnBtnAddClick);
		bindingSet.Bind(btnDecSelect).For((ButtonLong v) => v.onClick).To((WarehouseItemData vm) => vm.OnBtnDecClick);
		bindingSet.Bind<TextMeshProUGUI>(selectCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((WarehouseItemData vm) => vm.SelectCount);
		bindingSet.Build();
		btnAddSelect.onPress.AddListener(AddPropPress);
		btnAddSelect.onPointUp.AddListener(_viewModel.OnPressUp);
		btnDecSelect.onPress.AddListener(DecPropPress);
		btnDecSelect.onPointUp.AddListener(_viewModel.OnPressUp);
	}

	public override void RefreshData(KnapsackItemViewModel viewModel)
	{
		_viewModel = (WarehouseItemData)viewModel;
		base.RefreshData(viewModel);
	}

	private void AddPropPress()
	{
		if (_viewModel.SelectCount < _viewModel.SelectCountMax)
		{
			_viewModel.SelectCountFloat = Mathf.Clamp(_viewModel.SelectCountFloat + pressSpeed / (float)_viewModel.SelectCountMax, _viewModel.SelectCountMin, _viewModel.SelectCountMax);
		}
	}

	private void DecPropPress()
	{
		if (_viewModel.SelectCount > _viewModel.SelectCountMin)
		{
			_viewModel.SelectCountFloat = Mathf.Clamp(_viewModel.SelectCountFloat - pressSpeed / (float)_viewModel.SelectCountMax, _viewModel.SelectCountMin, _viewModel.SelectCountMax);
		}
	}
}
