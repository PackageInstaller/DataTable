using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class WeaponMechanismHammerViewModel : WeaponMechanismViewModel
{
	private int hammerEnergyMax = 200;

	private int hammerEnergyEach = 40;

	private float hammerConsumedMax = 3f;

	private float hammerInterval = 1f;

	private int hammerChargeTime;

	private float hammerDeepYello;

	private float hammerLightYello;

	private int hammerReduce;

	public int HammerEnergyMax
	{
		get
		{
			return hammerEnergyMax;
		}
		set
		{
			Set(ref hammerEnergyMax, value, "HammerEnergyMax");
		}
	}

	public int HammerEnergyEach
	{
		get
		{
			return hammerEnergyEach;
		}
		set
		{
			Set(ref hammerEnergyEach, value, "HammerEnergyEach");
		}
	}

	public float HammerDeepYello
	{
		get
		{
			return hammerDeepYello;
		}
		set
		{
			Set(ref hammerDeepYello, value, "HammerDeepYello");
		}
	}

	public float HammerLightYello
	{
		get
		{
			return hammerLightYello;
		}
		set
		{
			Set(ref hammerLightYello, value, "HammerLightYello");
		}
	}

	public int HammerReduce
	{
		get
		{
			return hammerReduce;
		}
		set
		{
			Set(ref hammerReduce, value, "HammerReduce");
		}
	}

	public WeaponMechanismHammerViewModel(WeaponEnum weaponEnum, ObservableDictionary<string, Ase.ECS.PropertyData> propertyList)
		: base(weaponEnum, propertyList)
	{
	}

	public void OnInitHammer(int hammerEnergyMax, int hammerEnergyEach)
	{
		this.hammerEnergyMax = hammerEnergyMax;
		this.hammerEnergyEach = hammerEnergyEach;
		hammerReduce = 0;
	}
}
