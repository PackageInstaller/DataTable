namespace Ase;

public class WeaponMaterialItemData : OptionBase
{
	private bool isEmpty;

	private string weaponIcon;

	private WeaponEnum weaponEnum;

	private int weaponRarity;

	private string weaponRefine;

	private int weaponLevel;

	private WeaponData weaponData;

	private bool isSelected;

	private bool isLock;

	public bool IsEmpty
	{
		get
		{
			return isEmpty;
		}
		set
		{
			Set(ref isEmpty, value, "IsEmpty");
		}
	}

	public string WeaponIcon
	{
		get
		{
			return weaponIcon;
		}
		set
		{
			Set(ref weaponIcon, value, "WeaponIcon");
		}
	}

	public WeaponEnum WeaponEnum
	{
		get
		{
			return weaponEnum;
		}
		set
		{
			Set(ref weaponEnum, value, "WeaponEnum");
		}
	}

	public int WeaponRarity
	{
		get
		{
			return weaponRarity;
		}
		set
		{
			Set(ref weaponRarity, value, "WeaponRarity");
		}
	}

	public string WeaponRefine
	{
		get
		{
			return weaponRefine;
		}
		set
		{
			Set(ref weaponRefine, value, "WeaponRefine");
		}
	}

	public int WeaponLevel
	{
		get
		{
			return weaponLevel;
		}
		set
		{
			Set(ref weaponLevel, value, "WeaponLevel");
		}
	}

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

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		set
		{
			Set(ref isLock, value, "IsLock");
		}
	}

	public WeaponData WeaponData => weaponData;

	public WeaponMaterialItemData(OptionBase parent, WeaponData weaponData = null)
	{
		base.parent = parent;
		RefreshData(weaponData);
	}

	public void SetEmpty()
	{
		IsEmpty = true;
		WeaponIcon = "empty";
		WeaponEnum = WeaponEnum.Sword;
	}

	public void RefreshData(WeaponData weaponData)
	{
		this.weaponData = weaponData;
		if (weaponData == null)
		{
			SetEmpty();
			return;
		}
		IsEmpty = false;
		WeaponIcon = weaponData.Icon;
		WeaponEnum = weaponData.WeaponEnum;
		WeaponRarity = weaponData.Rarity;
		WeaponRefine = ((weaponData.WeaponRefine == 5) ? $"<color=#FF0000>{weaponData.WeaponRefine}</color>" : $"{weaponData.WeaponRefine}");
		WeaponLevel = weaponData.Level;
		IsLock = weaponData.IsLock;
	}

	public void OnClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "OnClick"));
	}
}
