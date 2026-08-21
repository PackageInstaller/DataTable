using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MultiRoomCostItem : UGuiView
{
	[SerializeField]
	private GameObject normal;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private TextMeshProUGUI selectedText;

	[SerializeField]
	private GameObject locked;

	[SerializeField]
	private Button btn;

	private MultiRoomCostItemData viewModel;

	public void Init(MultiRoomCostItemData data)
	{
		viewModel = data;
		BindingSet<MultiRoomCostItem, MultiRoomCostItemData> bindingSet = this.CreateBindingSet(viewModel);
		if (normal != null)
		{
			bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomCostItemData vm) => !vm.IsSelected);
		}
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((MultiRoomCostItemData vm) => vm.IsSelected);
		}
		if ((UnityEngine.Object)(object)text != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(text).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MultiRoomCostItemData vm) => vm.RateDesc);
		}
		if ((UnityEngine.Object)(object)selectedText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(selectedText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MultiRoomCostItemData vm) => vm.RateDesc);
		}
		if (locked != null)
		{
			bindingSet.Bind(locked).For((GameObject v) => v.activeSelf).ToExpression((MultiRoomCostItemData vm) => !vm.IsUnlock);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((MultiRoomCostItemData vm) => vm.OnClick);
		}
		bindingSet.Build();
	}

	public void RefreshData(MultiRoomCostItemData data)
	{
		viewModel = data;
		this.SetDataContext(data);
	}
}
