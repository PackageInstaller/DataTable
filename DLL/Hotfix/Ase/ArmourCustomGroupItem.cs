using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class ArmourCustomGroupItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private RectTransform optionRect;

	[SerializeField]
	private ArmourCustomOptionItem optionTpl;

	private GameObjectPool _optionItemPool;

	private ArmourCustomGroupData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<ArmourCustomGroupData>(userData);
		_optionItemPool = new GameObjectPool(optionTpl.gameObject, optionRect);
		BindingSet<ArmourCustomGroupItem, ArmourCustomGroupData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourCustomGroupData vm) => vm.Title);
		bindingSet.Build();
		RefreshOptionItems();
	}

	private void RefreshOptionItems()
	{
		_optionItemPool.RecycleAll();
		if (_viewModel.OptionList == null)
		{
			return;
		}
		foreach (ArmourCustomOptionItemData option in _viewModel.OptionList)
		{
			ArmourCustomOptionItem component = _optionItemPool.Allocate(out var newCreate).GetComponent<ArmourCustomOptionItem>();
			if (newCreate)
			{
				component.Init(option);
			}
			else
			{
				component.RefreshData(option);
			}
		}
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is ArmourCustomGroupData armourCustomGroupData)
		{
			_viewModel = armourCustomGroupData;
			this.SetDataContext(armourCustomGroupData);
			RefreshOptionItems();
		}
	}
}
