using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DropPointItem : MonoBehaviour
{
	[SerializeField]
	private GameObject selectObj;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI nameText;

	[SerializeField]
	private Button btn;

	private DropPointItemData viewModel;

	public void Init(DropPointItemData data)
	{
		viewModel = data;
		BindingSet<DropPointItem, DropPointItemData> bindingSet = this.CreateBindingSet(data);
		bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DropPointItemData vm) => vm.Name);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((DropPointItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((DropPointItemData vm) => vm.ItemOnClick);
		bindingSet.Build();
	}

	public void RefreshData(DropPointItemData data)
	{
		viewModel = data;
		this.SetDataContext(data);
	}

	public void SetSelected(bool show)
	{
		selectObj.SetActive(show);
	}
}
