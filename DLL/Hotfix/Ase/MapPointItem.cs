using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MapPointItem : UGuiView
{
	[SerializeField]
	private RectTransform rect;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private CircleImage _circleIcon;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private TextMeshProUGUI pointName;

	[SerializeField]
	private GameObject unknowObj;

	[SerializeField]
	private GameObject redPointObj;

	private MapPointItemData viewModel;

	public virtual void Init(MapPointItemData data)
	{
		viewModel = data;
		BindingSet<MapPointItem, MapPointItemData> bindingSet = this.CreateBindingSet(data);
		bindingSet.Bind(rect).For((RectTransform v) => v.anchoredPosition).To((MapPointItemData vm) => vm.Pos);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((MapPointItemData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if (_circleIcon != null)
		{
			bindingSet.Bind(_circleIcon).For((CircleImage v) => v.sprite).To((MapPointItemData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		bindingSet.Bind<TextMeshProUGUI>(pointName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MapPointItemData vm) => vm.PointName);
		if (redPointObj != null)
		{
			bindingSet.Bind(redPointObj).For((GameObject v) => v.activeSelf).To((MapPointItemData vm) => vm.RedPoint);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((MapPointItemData vm) => vm.OnClick);
		}
		if (unknowObj != null)
		{
			bindingSet.Bind(unknowObj).For((GameObject v) => v.activeSelf).To((MapPointItemData vm) => vm.IsLock);
		}
		bindingSet.Build();
	}

	public void RefreshMapPointData(MapPointItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
