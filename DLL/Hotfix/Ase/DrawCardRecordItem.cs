using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardRecordItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI itemType;

	[SerializeField]
	private TextMeshProUGUI itemName;

	[SerializeField]
	private TextMeshProUGUI poolType;

	[SerializeField]
	private TextMeshProUGUI callTime;

	private DrawCardRecordItemViewModel viewModel;

	public void Init(DrawCardRecordItemViewModel drawCardRecordItemViewModel)
	{
		viewModel = drawCardRecordItemViewModel;
		BindingSet<DrawCardRecordItem, DrawCardRecordItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(itemType).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardRecordItemViewModel vm) => vm.ItemType);
		bindingSet.Bind<TextMeshProUGUI>(itemName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardRecordItemViewModel vm) => vm.ItemName);
		bindingSet.Bind<TextMeshProUGUI>(itemName).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).To((DrawCardRecordItemViewModel vm) => vm.ItemColor);
		bindingSet.Bind<TextMeshProUGUI>(poolType).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardRecordItemViewModel vm) => vm.PoolType);
		bindingSet.Bind<TextMeshProUGUI>(callTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardRecordItemViewModel vm) => vm.CallTime);
		bindingSet.Build();
	}

	public void RefreshRecordItem(DrawCardRecordItemViewModel drawCardRecordItemViewModel)
	{
		viewModel = drawCardRecordItemViewModel;
		this.SetDataContext(drawCardRecordItemViewModel);
	}
}
