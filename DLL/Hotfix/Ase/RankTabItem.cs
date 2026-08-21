using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RankTabItem : UGuiView
{
	[SerializeField]
	private GameObject normal;

	[SerializeField]
	private TextMeshProUGUI textNormal;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private TextMeshProUGUI textSelected;

	[SerializeField]
	private Button btn;

	private RankTabItemData _viewModel;

	public void Init(RankTabItemData data)
	{
		_viewModel = data;
		BindingSet<RankTabItem, RankTabItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((RankTabItemData vm) => !vm.Selected);
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((RankTabItemData vm) => vm.Selected);
		bindingSet.Bind<TextMeshProUGUI>(textNormal).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RankTabItemData vm) => vm.CopyName);
		bindingSet.Bind<TextMeshProUGUI>(textSelected).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RankTabItemData vm) => vm.CopyName);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((RankTabItemData vm) => vm.OnItemClick);
		bindingSet.Build();
	}

	public void RefreshData(RankTabItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
	}
}
