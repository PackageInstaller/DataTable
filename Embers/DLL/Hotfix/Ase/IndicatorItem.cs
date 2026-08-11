using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class IndicatorItem : UGuiView
{
	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private GameObject activeMask;

	[SerializeField]
	private GameObject haveTimeLimit;

	[SerializeField]
	private GameObject useTag;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private Image icon;

	public string itemSizeType = "Large";

	[SerializeField]
	protected Button btn;

	private IndicatorItemData _viewModel;

	public IndicatorItemData ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<IndicatorItemData>(userData);
		BindingSet<IndicatorItem, IndicatorItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((IndicatorItemData vm) => vm.IsSelected);
		bindingSet.Bind(activeMask).For((GameObject v) => v.activeSelf).To((IndicatorItemData vm) => vm.IsActive);
		bindingSet.Bind(haveTimeLimit).For((GameObject v) => v.activeSelf).To((IndicatorItemData vm) => vm.IsTimeLimit);
		bindingSet.Bind(useTag).For((GameObject v) => v.activeSelf).To((IndicatorItemData vm) => vm.IsUse);
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((IndicatorItemData vm) => $"RarityBG_{itemSizeType}_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((IndicatorItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((IndicatorItemData vm) => vm.OnItemClick);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is IndicatorItemData indicatorItemData)
		{
			_viewModel = indicatorItemData;
			this.SetDataContext(indicatorItemData);
		}
	}
}
