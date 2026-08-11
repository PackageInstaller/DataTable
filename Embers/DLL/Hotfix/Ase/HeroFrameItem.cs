using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroFrameItem : UGuiView
{
	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private GameObject activeMask;

	[SerializeField]
	private GameObject haveTimeLimit;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject appliedTag1;

	[SerializeField]
	private GameObject appliedTag2;

	[SerializeField]
	private GameObject appliedTag3;

	public string itemSizeType = "Large";

	[SerializeField]
	protected Button btn;

	private HeroFrameItemData _viewModel;

	public HeroFrameItemData ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<HeroFrameItemData>(userData);
		BindingSet<HeroFrameItem, HeroFrameItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((HeroFrameItemData vm) => vm.Selected);
		}
		if (activeMask != null)
		{
			bindingSet.Bind(activeMask).For((GameObject v) => v.activeSelf).To((HeroFrameItemData vm) => vm.ActiveMask);
		}
		if (haveTimeLimit != null)
		{
			bindingSet.Bind(haveTimeLimit).For((GameObject v) => v.activeSelf).To((HeroFrameItemData vm) => vm.HaveTimeLimit);
		}
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((HeroFrameItemData vm) => $"RarityBG_{itemSizeType}_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((HeroFrameItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		if (appliedTag1 != null)
		{
			bindingSet.Bind(appliedTag1).For((GameObject v) => v.activeSelf).To((HeroFrameItemData vm) => vm.Applied1);
		}
		if (appliedTag2 != null)
		{
			bindingSet.Bind(appliedTag2).For((GameObject v) => v.activeSelf).To((HeroFrameItemData vm) => vm.Applied2);
		}
		if (appliedTag3 != null)
		{
			bindingSet.Bind(appliedTag3).For((GameObject v) => v.activeSelf).To((HeroFrameItemData vm) => vm.Applied3);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((HeroFrameItemData vm) => vm.OnItemClick);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is HeroFrameItemData heroFrameItemData)
		{
			_viewModel = heroFrameItemData;
			this.SetDataContext(heroFrameItemData);
		}
	}
}
