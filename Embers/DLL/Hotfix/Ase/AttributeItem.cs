using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AttributeItem : UGuiView
{
	[SerializeField]
	private Image attributeIcon;

	[SerializeField]
	private TextMeshProUGUI attributeName;

	[SerializeField]
	private TextMeshProUGUI attributeValue;

	private AttributeItemData viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<AttributeItemData>(userData);
		BindingSet<AttributeItem, AttributeItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(attributeIcon).For((Image v) => v.sprite).ToExpression((AttributeItemData vm) => vm.IconPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(attributeName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AttributeItemData vm) => vm.AttributeName);
		bindingSet.Bind<TextMeshProUGUI>(attributeValue).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AttributeItemData vm) => vm.ShowValue);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is AttributeItemData data)
		{
			RefreshAttributeData(data);
		}
	}

	public void RefreshAttributeData(AttributeItemData data)
	{
		viewModel = data;
		this.SetDataContext(data);
	}
}
