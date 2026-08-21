using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class LongTermCheckinItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI day;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI count;

	[SerializeField]
	private GameObject highLight;

	[SerializeField]
	private GameObject received;

	public string itemSizeType = "Middle";

	[SerializeField]
	private Button btn;

	private LongTermCheckinItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<LongTermCheckinItemData>(userData);
		BindingSet<LongTermCheckinItem, LongTermCheckinItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if ((UnityEngine.Object)(object)day != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(day).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LongTermCheckinItemData vm) => vm.Day);
		}
		if (bg != null)
		{
			bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((LongTermCheckinItemData vm) => $"RarityBG_{itemSizeType}_{vm.Quality}")
				.WithConversion("ItemIcon");
		}
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((LongTermCheckinItemData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)count != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(count).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LongTermCheckinItemData vm) => vm.Count);
		}
		if (highLight != null)
		{
			bindingSet.Bind(highLight).For((GameObject v) => v.activeSelf).To((LongTermCheckinItemData vm) => vm.Highlight);
		}
		if (received != null)
		{
			bindingSet.Bind(received).For((GameObject v) => v.activeSelf).To((LongTermCheckinItemData vm) => vm.Received);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((LongTermCheckinItemData vm) => vm.OnItemClick);
		}
		bindingSet.Build();
	}
}
