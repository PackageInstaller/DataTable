using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CastingMaterialItem : LoopListViewItem2
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private Image border;

	[SerializeField]
	private Image bar;

	[SerializeField]
	private TextMeshProUGUI num;

	[SerializeField]
	private Button button;

	private Transform rootView;

	private CastingMaterialItemData viewModel;

	public void Init(CastingMaterialItemData data)
	{
		viewModel = data;
		BindingSet<CastingMaterialItem, CastingMaterialItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((CastingMaterialItemData vm) => vm.PropData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((CastingMaterialItemData vm) => $"RarityBG_Middle_{vm.PropData.Quality}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(border).For((Image v) => v.sprite).ToExpression((CastingMaterialItemData vm) => $"Rarity_Middle_{vm.PropData.Quality}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(bar).For((Image v) => v.sprite).ToExpression((CastingMaterialItemData vm) => $"Bar_Middle_{vm.PropData.Quality}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(num).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CastingMaterialItemData vm) => vm.NumShow);
		bindingSet.Bind(button).For((Button v) => v.onClick).To((CastingMaterialItemData vm) => vm.OnClick);
		bindingSet.Build();
	}

	public void RefreshData(CastingMaterialItemData data)
	{
		this.SetDataContext(data);
	}
}
