using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardTabItem : UGuiView
{
	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private Image normalIcon;

	[SerializeField]
	private Image selectedIcon;

	[SerializeField]
	private TextMeshProUGUI tagText;

	[SerializeField]
	private Image tagColor;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject redPoint;

	private DrawCardTabData viewModel;

	public void Init(DrawCardTabData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<DrawCardTabItem, DrawCardTabData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((DrawCardTabData vm) => vm.IsSelected);
		bindingSet.Bind(normalIcon).For((Image v) => v.sprite).To((DrawCardTabData vm) => vm.NormalIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(selectedIcon).For((Image v) => v.sprite).To((DrawCardTabData vm) => vm.SelectedIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((DrawCardTabData vm) => vm.ItemOnclick);
		bindingSet.Bind<TextMeshProUGUI>(tagText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardTabData vm) => vm.Tag);
		bindingSet.Bind(tagColor).For((Image v) => v.color).To((DrawCardTabData vm) => vm.TagColor);
		if (redPoint != null)
		{
			bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((DrawCardTabData vm) => vm.RedPoint);
		}
		bindingSet.Build();
	}

	public void RefreshData(DrawCardTabData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
