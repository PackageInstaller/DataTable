using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GamePropGuideItem : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image rarity;

	[SerializeField]
	private GameObject redPointObj;

	[SerializeField]
	private GameObject selectObj;

	[SerializeField]
	private Image weaponEnum;

	[SerializeField]
	private GameObject weaponEnumObj;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject lockObj;

	private GamePropGuideItemData viewModel;

	public void Init(GamePropGuideItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<GamePropGuideItem, GamePropGuideItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((GamePropGuideItemData vm) => vm.IconPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind(rarity).For((Image v) => v.sprite).ToExpression((GamePropGuideItemData vm) => $"RarityBG_Large_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(weaponEnum).For((Image v) => v.sprite).ToExpression((GamePropGuideItemData vm) => vm.WeaponEnumIconPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind(redPointObj).For((GameObject v) => v.activeSelf).To((GamePropGuideItemData vm) => vm.IsNew);
		bindingSet.Bind(selectObj).For((GameObject v) => v.activeSelf).To((GamePropGuideItemData vm) => vm.IsSelected);
		bindingSet.Bind(weaponEnumObj).For((GameObject v) => v.activeSelf).ToExpression((GamePropGuideItemData vm) => vm.PropGuideType == 1);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((GamePropGuideItemData vm) => vm.OnClick);
		bindingSet.Bind(lockObj).For((GameObject v) => v.activeSelf).To((GamePropGuideItemData vm) => vm.IsLock);
		bindingSet.Build();
	}

	public void RefreshPropGuideItem(GamePropGuideItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
