using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ShortTermCheckinItem : UGuiView
{
	[SerializeField]
	public TextMeshProUGUI day;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI count;

	[SerializeField]
	private GameObject highLight;

	[SerializeField]
	private List<GameObject> highLights;

	[SerializeField]
	private GameObject received;

	[SerializeField]
	private List<GameObject> receiveds;

	[SerializeField]
	private GameObject tomorrowTag;

	[SerializeField]
	private Button btn;

	private ShortTermCheckinItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<ShortTermCheckinItemData>(userData);
		BindingSet<ShortTermCheckinItem, ShortTermCheckinItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if ((UnityEngine.Object)(object)day != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(day).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShortTermCheckinItemData vm) => vm.Day);
		}
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((ShortTermCheckinItemData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)count != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(count).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ShortTermCheckinItemData vm) => vm.Count);
		}
		if (highLight != null)
		{
			bindingSet.Bind(highLight).For((GameObject v) => v.activeSelf).To((ShortTermCheckinItemData vm) => vm.Highlight);
		}
		if (highLights != null)
		{
			foreach (GameObject highLight in highLights)
			{
				if (highLight != null)
				{
					bindingSet.Bind(highLight).For((GameObject v) => v.activeSelf).To((ShortTermCheckinItemData vm) => vm.Highlight);
				}
			}
		}
		if (received != null)
		{
			bindingSet.Bind(received).For((GameObject v) => v.activeSelf).To((ShortTermCheckinItemData vm) => vm.Received);
		}
		if (receiveds != null)
		{
			foreach (GameObject received in receiveds)
			{
				if (received != null)
				{
					bindingSet.Bind(received).For((GameObject v) => v.activeSelf).To((ShortTermCheckinItemData vm) => vm.Received);
				}
			}
		}
		if (tomorrowTag != null)
		{
			bindingSet.Bind(tomorrowTag).For((GameObject v) => v.activeSelf).To((ShortTermCheckinItemData vm) => vm.TomorrowTag);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((ShortTermCheckinItemData vm) => vm.OnItemClick);
		}
		bindingSet.Build();
	}
}
