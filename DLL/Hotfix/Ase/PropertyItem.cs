using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropertyItem : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI nameText;

	[SerializeField]
	private TextMeshProUGUI value1;

	[SerializeField]
	private TextMeshProUGUI value2;

	public void Init(PropertyData data)
	{
		BindingSet<PropertyItem, PropertyData> bindingSet = this.CreateBindingSet(data);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((PropertyData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)nameText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropertyData vm) => vm.Name);
		}
		if ((UnityEngine.Object)(object)value1 != null)
		{
			if (data.CustomValue)
			{
				bindingSet.Bind<TextMeshProUGUI>(value1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropertyData vm) => $"{vm.CustomValueText1}");
			}
			else
			{
				bindingSet.Bind<TextMeshProUGUI>(value1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropertyData vm) => $"{vm.Prefix1}{vm.Value1Text}");
			}
		}
		if ((UnityEngine.Object)(object)value2 != null)
		{
			if (data.CustomValue)
			{
				bindingSet.Bind<TextMeshProUGUI>(value2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropertyData vm) => $"{vm.CustomValueText2}");
			}
			else
			{
				bindingSet.Bind<TextMeshProUGUI>(value2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropertyData vm) => $"{vm.Prefix2}{vm.Value2Text}");
			}
		}
		bindingSet.Build();
	}

	public void RefreshData(PropertyData data)
	{
		this.SetDataContext(data);
	}
}
