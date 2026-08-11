using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AttributeUpgradeItem : UGuiView
{
	[SerializeField]
	private GameObject attributeObj;

	[SerializeField]
	private Image attributeIcon;

	[SerializeField]
	private TextMeshProUGUI attributeName;

	[SerializeField]
	private TextMeshProUGUI attributeValue;

	[SerializeField]
	private TextMeshProUGUI attributeValueUpgrade;

	[SerializeField]
	private GameObject textObj;

	[SerializeField]
	private TextMeshProUGUI descText;

	[SerializeField]
	private TextMeshProUGUI descValue;

	private AttributeUpgradeItemData _viewModel;

	public void Init(AttributeUpgradeItemData data)
	{
		_viewModel = data;
		BindingSet<AttributeUpgradeItem, AttributeUpgradeItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (attributeObj != null)
		{
			bindingSet.Bind(attributeObj).For((GameObject v) => v.activeSelf).To((AttributeUpgradeItemData vm) => vm.IsAttribute);
		}
		if (textObj != null)
		{
			bindingSet.Bind(textObj).For((GameObject v) => v.activeSelf).ToExpression((AttributeUpgradeItemData vm) => !vm.IsAttribute);
		}
		if (_viewModel.IsAttribute)
		{
			if (attributeIcon != null)
			{
				bindingSet.Bind(attributeIcon).For((Image v) => v.sprite).ToExpression((AttributeUpgradeItemData vm) => vm.AttributeData.Icon)
					.WithConversion("ItemIcon");
			}
			if ((UnityEngine.Object)(object)attributeName != null)
			{
				bindingSet.Bind<TextMeshProUGUI>(attributeName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AttributeUpgradeItemData vm) => vm.AttributeData.AttributeName);
			}
			bindingSet.Bind<TextMeshProUGUI>(attributeValue).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AttributeUpgradeItemData vm) => vm.ShowValue1);
			bindingSet.Bind<TextMeshProUGUI>(attributeValueUpgrade).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AttributeUpgradeItemData vm) => vm.ShowValue2);
		}
		else
		{
			bindingSet.Bind<TextMeshProUGUI>(descText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AttributeUpgradeItemData vm) => vm.DescText);
			bindingSet.Bind<TextMeshProUGUI>(descValue).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AttributeUpgradeItemData vm) => vm.DescValue);
		}
		bindingSet.Build();
	}

	public void RefreshAttributeData(AttributeUpgradeItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
	}
}
