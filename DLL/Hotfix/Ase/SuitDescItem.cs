using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;

namespace Ase;

public class SuitDescItem : LoopListViewItem2
{
	[SerializeField]
	private TextMeshProUGUI suitName;

	[SerializeField]
	private TextMeshProUGUI suitDesc;

	private SuitDescItemData _viewModel;

	public void Init(SuitDescItemData data)
	{
		_viewModel = data;
		BindingSet<SuitDescItem, SuitDescItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(suitName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SuitDescItemData vm) => vm.SuitName);
		bindingSet.Bind<TextMeshProUGUI>(suitDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SuitDescItemData vm) => vm.SuitDesc);
		bindingSet.Build();
	}

	public void Refresh(SuitDescItemData data)
	{
		this.SetDataContext(data);
	}
}
