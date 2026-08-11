using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaponShowView : UGuiView
{
	[SerializeField]
	private Image bg;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image frame;

	[SerializeField]
	private Image type;

	[SerializeField]
	private UIStarGroup starGroup;

	private WeaponData _viewModel;

	public void Init(WeaponData weaponData)
	{
		_viewModel = weaponData;
		BindingSet<WeaponShowView, WeaponData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((WeaponData vm) => $"Rarity_WeaponBg_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((WeaponData vm) => $"{vm.Icon}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(frame).For((Image v) => v.sprite).ToExpression((WeaponData vm) => $"Rarity_WeaponFrame_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(type).For((Image v) => v.sprite).ToExpression((WeaponData vm) => $"WeaponIcon_{(int)vm.WeaponEnum}")
			.WithConversion("ItemIcon");
		bindingSet.Build();
	}

	public void Refresh(WeaponData weaponData)
	{
		_viewModel = weaponData;
		this.SetDataContext(weaponData);
	}
}
