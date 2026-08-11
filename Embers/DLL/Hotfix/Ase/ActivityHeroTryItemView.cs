using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityHeroTryItemView : SelectItemView
{
	public Image headIcon;

	public Image rarityTag;

	public GameObject isRed;

	private ActivityHeroTryItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<ActivityHeroTryItemViewModel>(userData);
		BindingSet<ActivityHeroTryItemView, ActivityHeroTryItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(headIcon).For((Image v) => v.sprite).ToExpression((ActivityHeroTryItemViewModel vm) => $"{vm.Hero.Id}_Card{vm.Hero.SkinSuffix}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(rarityTag).For((Image v) => v.color).To((ActivityHeroTryItemViewModel vm) => vm.RarityColor);
		bindingSet.Bind(isRed).For((GameObject v) => v.activeSelf).To((ActivityHeroTryItemViewModel vm) => vm.IsRed);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<ActivityHeroTryItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
