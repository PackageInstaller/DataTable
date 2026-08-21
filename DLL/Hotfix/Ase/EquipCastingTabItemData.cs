namespace Ase;

public class EquipCastingTabItemData : OptionBase
{
	private bool isSelected;

	private bool isWeapon;

	private WeaponEnum weaponType;

	private ArmourEnum armourType;

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public bool IsWeapon
	{
		get
		{
			return isWeapon;
		}
		set
		{
			Set(ref isWeapon, value, "IsWeapon");
		}
	}

	public WeaponEnum WeaponType
	{
		get
		{
			return weaponType;
		}
		private set
		{
			Set(ref weaponType, value, "WeaponType");
		}
	}

	public ArmourEnum ArmourType
	{
		get
		{
			return armourType;
		}
		private set
		{
			Set(ref armourType, value, "ArmourType");
		}
	}

	public EquipCastingTabItemData(OptionBase parent, bool isWeapon, WeaponEnum weaponType, ArmourEnum armourType)
	{
		base.parent = parent;
		this.isWeapon = isWeapon;
		if (IsWeapon)
		{
			this.weaponType = weaponType;
		}
		else
		{
			this.armourType = armourType;
		}
	}

	public void TabOnClick()
	{
		parent.ItemOnClick(this);
	}
}
