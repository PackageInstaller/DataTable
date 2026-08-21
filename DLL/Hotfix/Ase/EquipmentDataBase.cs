using System.Collections.Generic;

namespace Ase;

public class EquipmentDataBase : PropDataBase
{
	private int rarity;

	private int lvInit;

	private int level;

	private int maxLevel;

	private int exp;

	private int maxExp;

	private int provideExp;

	protected bool isOwn;

	private bool isLock;

	private EquipmentEnum equipmentEnum;

	private List<EquipAttribute> equipAttributeList;

	private List<EntryData> entryDataList;

	public int Rarity
	{
		get
		{
			return rarity;
		}
		set
		{
			Set(ref rarity, value, "Rarity");
		}
	}

	public int LvInit
	{
		get
		{
			return lvInit;
		}
		set
		{
			Set(ref lvInit, value, "LvInit");
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

	public bool IsOwn => isOwn;

	public int Level
	{
		get
		{
			return level;
		}
		set
		{
			Set(ref level, value, "Level");
			SetLevel();
		}
	}

	public int MaxLevel
	{
		get
		{
			return maxLevel;
		}
		set
		{
			Set(ref maxLevel, value, "MaxLevel");
		}
	}

	public int Exp
	{
		get
		{
			return exp;
		}
		set
		{
			Set(ref exp, value, "Exp");
		}
	}

	public int MaxExp
	{
		get
		{
			return maxExp;
		}
		set
		{
			Set(ref maxExp, value, "MaxExp");
		}
	}

	public EquipmentEnum EquipmentEnum
	{
		get
		{
			return equipmentEnum;
		}
		set
		{
			Set(ref equipmentEnum, value, "EquipmentEnum");
		}
	}

	public List<EquipAttribute> EquipAttributeList
	{
		get
		{
			return equipAttributeList;
		}
		set
		{
			Set(ref equipAttributeList, value, "EquipAttributeList");
		}
	}

	public List<EntryData> EntryDataList
	{
		get
		{
			return entryDataList;
		}
		set
		{
			Set(ref entryDataList, value, "EntryDataList");
		}
	}

	public EquipmentDataBase(EquipmentEnum equipmentEnum)
	{
		this.equipmentEnum = equipmentEnum;
		Init();
	}

	public EquipmentDataBase(DRWeapon drWeapon)
		: base(drWeapon)
	{
		equipmentEnum = EquipmentEnum.Weapon;
		Init();
	}

	public EquipmentDataBase(DREquipment drEquipment)
		: base(drEquipment)
	{
		equipmentEnum = EquipmentEnum.Armour;
		Init();
	}

	public EquipmentDataBase(DRSuitbox drSuitbox)
		: base(drSuitbox)
	{
		equipmentEnum = EquipmentEnum.SuitBox;
		Init();
	}

	private void Init()
	{
		equipAttributeList = new List<EquipAttribute>();
		entryDataList = new List<EntryData>();
	}

	public void PbEquipAttributeConvert(List<AttributeBase> attributeBases)
	{
		EquipAttributeList.Clear();
		List<EquipAttribute> list = new List<EquipAttribute>();
		for (int i = 0; i < attributeBases.Count; i++)
		{
			DRAffix dataRow = GameEntry.DataTable.GetDataTable<DRAffix>().GetDataRow(attributeBases[i].Id);
			if (i == 0)
			{
				if (dataRow != null)
				{
					EquipAttributeList.Add(new EquipAttribute(dataRow, attributeBases[i].Value / 10000f));
				}
			}
			else if (dataRow != null)
			{
				list.Add(new EquipAttribute(dataRow, attributeBases[i].Value / 10000f));
			}
		}
		list.Sort((EquipAttribute a, EquipAttribute b) => a.Id.CompareTo(b.Id));
		EquipAttributeList.AddRange(list);
	}

	public void PbEquipEntryConvert(List<EntryBase> entryBases)
	{
		EntryDataList.Clear();
		foreach (EntryBase entryBasis in entryBases)
		{
			EntryData entryData = new EntryData(entryBasis.Id, entryBasis.Level);
			entryData.IsFixed = true;
			if (entryData.DrEntry != null)
			{
				EntryDataList.Add(entryData);
			}
		}
	}

	protected virtual void SetLevel()
	{
	}

	public void UpdateProperty()
	{
		numericalProperty.Clear();
		foreach (EquipAttribute equipAttribute in EquipAttributeList)
		{
			numericalProperty.AddProperty(equipAttribute.AffixKey, equipAttribute.BaseValue);
		}
	}

	public int GetOwnerId()
	{
		return Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetEquipmentOwnerById(base.Uid);
	}

	public override bool CanSell()
	{
		if (GetOwnerId() <= 0)
		{
			return !IsLock;
		}
		return false;
	}

	public override bool CanDecompose()
	{
		if (GetOwnerId() <= 0)
		{
			return !IsLock;
		}
		return false;
	}
}
