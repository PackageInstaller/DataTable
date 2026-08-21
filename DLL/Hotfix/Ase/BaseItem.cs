using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BaseItem : UGuiView
{
	[SerializeField]
	protected Image icon;

	[SerializeField]
	protected TextMeshProUGUI text;

	[SerializeField]
	protected Button button;

	private BaseItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<BaseItemData>(userData);
		BindingSet<BaseItem, BaseItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((BaseItemData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)text != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(text).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BaseItemData vm) => vm.Text);
		}
		if (button != null)
		{
			bindingSet.Bind(button).For((Button v) => v.onClick).To((BaseItemData vm) => vm.OnItemClick);
		}
		bindingSet.Build();
	}

	public void RefreshData(BaseItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
	}
}
