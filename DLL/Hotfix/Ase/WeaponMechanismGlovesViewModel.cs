using System;
using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class WeaponMechanismGlovesViewModel : WeaponMechanismViewModel
{
	protected Action onHeroAngerChanged;

	protected float eachEnergyLayerMax;

	public float EachEnergyLayerMax
	{
		get
		{
			return eachEnergyLayerMax;
		}
		set
		{
			Set(ref eachEnergyLayerMax, value, "EachEnergyLayerMax");
		}
	}

	public WeaponMechanismGlovesViewModel(WeaponEnum weaponEnum, ObservableDictionary<string, Ase.ECS.PropertyData> propertyList)
		: base(weaponEnum, propertyList)
	{
	}

	public void AddHeroAngerChanged(Action onHeroAngerChanged)
	{
		this.onHeroAngerChanged = onHeroAngerChanged;
	}

	public void OnHeroAngerChanged()
	{
		onHeroAngerChanged?.Invoke();
	}
}
