using UnityEngine;

namespace Ase;

public class EquipExpItemDataNew : OptionBase
{
	private PropData _propData;

	private WeaponData _weaponData;

	private ArmourData _armourData;

	private string _icon;

	private int _rarity;

	private string _showText;

	private int _itemType;

	private bool _isSelected;

	private int _selectedNum;

	private readonly int _provideExp;

	private bool _isLock;

	private readonly int _id;

	private int _level;

	private Color _rankBgColor;

	private string weaponRefine;

	public string ActionName;

	private int type;

	private int refine;

	private int rank;

	private int weaponEnum;

	private long uid;

	public string Icon
	{
		get
		{
			return _icon;
		}
		private set
		{
			Set(ref _icon, value, "Icon");
		}
	}

	public int Rarity
	{
		get
		{
			return _rarity;
		}
		private set
		{
			Set(ref _rarity, value, "Rarity");
		}
	}

	public string ShowText
	{
		get
		{
			return _showText;
		}
		private set
		{
			Set(ref _showText, value, "ShowText");
		}
	}

	public PropData PropData
	{
		get
		{
			return _propData;
		}
		private set
		{
			Set(ref _propData, value, "PropData");
		}
	}

	public WeaponData WeaponData
	{
		get
		{
			return _weaponData;
		}
		private set
		{
			Set(ref _weaponData, value, "WeaponData");
		}
	}

	public ArmourData ArmourData
	{
		get
		{
			return _armourData;
		}
		private set
		{
			Set(ref _armourData, value, "ArmourData");
		}
	}

	public bool IsSelected
	{
		get
		{
			return _isSelected;
		}
		private set
		{
			Set(ref _isSelected, value, "IsSelected");
		}
	}

	public int SelectedNum
	{
		get
		{
			return _selectedNum;
		}
		private set
		{
			Set(ref _selectedNum, value, "SelectedNum");
		}
	}

	public bool IsLock
	{
		get
		{
			return _isLock;
		}
		private set
		{
			Set(ref _isLock, value, "IsLock");
		}
	}

	public int Level
	{
		get
		{
			return _level;
		}
		private set
		{
			Set(ref _level, value, "Level");
		}
	}

	public int Rank
	{
		get
		{
			return rank;
		}
		private set
		{
			Set(ref rank, value, "Rank");
		}
	}

	public int WeaponEnum
	{
		get
		{
			return weaponEnum;
		}
		private set
		{
			Set(ref weaponEnum, value, "WeaponEnum");
		}
	}

	public Color RankBgColor
	{
		get
		{
			return _rankBgColor;
		}
		private set
		{
			Set(ref _rankBgColor, value, "RankBgColor");
		}
	}

	public int ItemType
	{
		get
		{
			return _itemType;
		}
		private set
		{
			Set(ref _itemType, value, "ItemType");
		}
	}

	public string WeaponRefine
	{
		get
		{
			return weaponRefine;
		}
		private set
		{
			Set(ref weaponRefine, value, "WeaponRefine");
		}
	}

	public int ProvideExp => _provideExp;

	public int ID => _id;

	public int Type => type;

	public int Refine => refine;

	public long Uid => uid;

	public EquipExpItemDataNew(OptionBase parent, PropData propData)
	{
		base.parent = parent;
		_propData = propData;
		_itemType = 1;
		_icon = propData.Icon;
		_rarity = propData.Quality;
		_provideExp = propData.Ex1;
		IsLock = false;
		_id = propData.Id;
		Level = 0;
		LoadDefault();
		ActionName = "";
		type = 1;
		_weaponData = WeaponData.CreateWeaponData(9211001);
		_armourData = ArmourData.CreateArmourData(93010101);
		uid = 0L;
	}

	public EquipExpItemDataNew(OptionBase parent, WeaponData weaponData)
	{
		base.parent = parent;
		_weaponData = weaponData;
		weaponData.SetWeaponIcon();
		_itemType = 2;
		_icon = _weaponData.Icon;
		_rarity = _weaponData.Rarity;
		_provideExp = WeaponData.GetWeaponDevourExp(weaponData.Rarity, weaponData.Level);
		IsLock = weaponData.IsLock;
		_id = weaponData.Id;
		Level = weaponData.Level;
		LoadDefault();
		ActionName = "";
		type = 2;
		WeaponRefine = ((_weaponData.WeaponRefine == 5) ? $"<color=#ff961d>{_weaponData.WeaponRefine}</color>" : $"{_weaponData.WeaponRefine}");
		refine = _weaponData.WeaponRefine;
		WeaponEnum = (int)WeaponData.WeaponEnum;
		uid = weaponData.Uid;
	}

	public EquipExpItemDataNew(OptionBase parent, ArmourData armourData)
	{
		base.parent = parent;
		_armourData = armourData;
		_itemType = 3;
		_icon = ArmourData.Icon;
		_rarity = ArmourData.Rarity;
		_provideExp = ArmourData.GetArmourProvideExp(armourData.Rarity, armourData.Level, ArmourData.Rank);
		IsLock = ArmourData.IsLock;
		_id = ArmourData.Id;
		Level = ArmourData.Level;
		_rankBgColor = EquipSlotNew.RankBgColor(ArmourData.Rarity);
		LoadDefault();
		ActionName = "";
		type = 3;
		Rank = ArmourData.Rank;
		uid = armourData.Uid;
	}

	public int GetProvideExpLeft()
	{
		if (ItemType == 1)
		{
			return ProvideExp * (PropData.Amount - SelectedNum);
		}
		return ProvideExp * (1 - SelectedNum);
	}

	public void ClearNum()
	{
		IsSelected = false;
		SetShowText(Type);
		SelectedNum = 0;
	}

	public void SetSelected(int num)
	{
		if (num == 0)
		{
			return;
		}
		IsSelected = true;
		if (ItemType == 1)
		{
			if (SelectedNum + num > PropData.Amount)
			{
				SelectedNum = PropData.Amount;
			}
			else
			{
				SelectedNum += num;
			}
			ShowText = (PropData.Amount - SelectedNum).ToString();
		}
		else if (SelectedNum != 1)
		{
			SelectedNum = num;
		}
	}

	public int GetNum()
	{
		if (ItemType != 1)
		{
			return 1;
		}
		return PropData.Amount - SelectedNum;
	}

	private void LoadDefault()
	{
		_isSelected = false;
		SetShowText(_itemType);
		SelectedNum = 0;
		WeaponRefine = "1";
	}

	public void BtnOnclick()
	{
		parent?.ItemOnClick(this);
	}

	public void SetOnClick()
	{
		if (IsLock)
		{
			return;
		}
		if (ItemType == 1)
		{
			IsSelected = true;
			if (PropData.Amount > SelectedNum)
			{
				SelectedNum++;
				ShowText = (PropData.Amount - SelectedNum).ToString();
				ActionName = "PropAdd";
			}
		}
		else if (IsSelected)
		{
			IsSelected = false;
			SelectedNum = 0;
			ActionName = "EquipRemove";
		}
		else
		{
			IsSelected = true;
			SelectedNum = 1;
			ActionName = "EquipAdd";
		}
	}

	public void ChangeLock()
	{
		IsLock = !IsLock;
	}

	public void BtnReduce()
	{
		if (ItemType == 1)
		{
			SelectedNum--;
			if (SelectedNum == 0)
			{
				IsSelected = false;
			}
			ShowText = (PropData.Amount - SelectedNum).ToString();
			ActionName = "PropRemove";
			parent.ItemOnClick(this);
		}
	}

	private void SetShowText(int type)
	{
		switch (type)
		{
		case 1:
			ShowText = PropData.Amount.ToString();
			break;
		case 2:
			ShowText = $"Lv.{WeaponData.Level}";
			break;
		case 3:
			ShowText = "+" + ArmourData.Level;
			break;
		}
	}
}
