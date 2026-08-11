using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropSourceItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private GameObject normal;

	[SerializeField]
	private Button button;

	[SerializeField]
	private GameObject mask;

	private PropSourceItemData _viewModel;

	public void Init(PropSourceItemData data)
	{
		_viewModel = data;
		BindingSet<PropSourceItem, PropSourceItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(text).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropSourceItemData vm) => vm.Text);
		bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((PropSourceItemData vm) => !vm.JumpEnable);
		bindingSet.Bind(mask).For((GameObject v) => v.activeSelf).ToExpression((PropSourceItemData vm) => vm.JumpEnable && !vm.JumpWindowUnlock);
		bindingSet.Bind(button.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PropSourceItemData vm) => vm.JumpEnable && vm.JumpWindowUnlock);
		bindingSet.Bind(button).For((Button v) => v.onClick).To((PropSourceItemData vm) => vm.OnItemClick);
		bindingSet.Build();
	}

	public void RefreshData(PropSourceItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
	}
}
