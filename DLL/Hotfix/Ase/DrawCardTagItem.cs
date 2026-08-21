using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardTagItem : UGuiView
{
	[SerializeField]
	private Image BgImg;

	[SerializeField]
	private TextMeshProUGUI TagName;

	private DrawCardTagItemData viewModel;

	public void Init(DrawCardTagItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<DrawCardTagItem, DrawCardTagItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(BgImg).For((Image v) => v.color).To((DrawCardTagItemData vm) => vm.TagColor);
		bindingSet.Bind<TextMeshProUGUI>(TagName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardTagItemData vm) => vm.TagName);
		bindingSet.Build();
	}

	public void RefreshTag(DrawCardTagItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
