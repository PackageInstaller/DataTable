using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SailEventItem : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image rarity;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private GameObject newObj;

	[SerializeField]
	private GameObject finishState;

	[SerializeField]
	private GameObject sailState;

	[SerializeField]
	private TextMeshProUGUI leftTimeText;

	[SerializeField]
	private Button button;

	[SerializeField]
	private GameObject isSelect;

	private SailEventItemData viewModel;

	public void Init(SailEventItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<SailEventItem, SailEventItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((SailEventItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(rarity).For((Image v) => v.sprite).ToExpression((SailEventItemData vm) => $"dispatch_list_itembg_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SailEventItemData vm) => vm.EventName);
		bindingSet.Bind(newObj).For((GameObject v) => v.activeSelf).To((SailEventItemData vm) => vm.IsNew);
		bindingSet.Bind(finishState).For((GameObject v) => v.activeSelf).ToExpression((SailEventItemData vm) => vm.State == 1);
		bindingSet.Bind(sailState).For((GameObject v) => v.activeSelf).ToExpression((SailEventItemData vm) => vm.State == 3);
		bindingSet.Bind<TextMeshProUGUI>(leftTimeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SailEventItemData vm) => vm.LeftTimeText);
		bindingSet.Bind(button).For((Button v) => v.onClick).To((SailEventItemData vm) => vm.Onclick);
		bindingSet.Bind(isSelect).For((GameObject v) => v.activeSelf).To((SailEventItemData vm) => vm.IsSelect);
		bindingSet.Build();
	}

	public void RefreshSailEvent(SailEventItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
