using System.Collections.Generic;

namespace Ase;

public class WeaponSuccessViewModel : OptionBase
{
	private WeaponData _weaponData;

	private int _oldLevel;

	private List<AttributeUpgradeItemData> _attributeUpgradeItemDataList;

	private List<EntryUpgradeItemData> _entryUpgradeItemDataList;

	public WeaponUpMode WeaponUpMode;

	public WeaponData WeaponData => _weaponData;

	public int OldLevel => _oldLevel;

	public List<AttributeUpgradeItemData> AttributeUpgradeItemDataList => _attributeUpgradeItemDataList;

	public List<EntryUpgradeItemData> EntryUpgradeItemDataList => _entryUpgradeItemDataList;

	public WeaponSuccessViewModel()
	{
	}

	public WeaponSuccessViewModel(WeaponData weaponData, WeaponUpMode weaponUpMode, int oldLevel = 1)
	{
		_weaponData = weaponData;
		WeaponUpMode = weaponUpMode;
		_oldLevel = oldLevel;
		_attributeUpgradeItemDataList = new List<AttributeUpgradeItemData>();
		_entryUpgradeItemDataList = new List<EntryUpgradeItemData>();
		if (WeaponUpMode == WeaponUpMode.UpStar)
		{
			LoadStar();
		}
		else if (WeaponUpMode == WeaponUpMode.Upgrade)
		{
			LoadLevel();
		}
	}

	private void LoadLevel()
	{
		int num = WeaponData.Level - _oldLevel;
		DRWeapon dataRow = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(WeaponData.Id);
		for (int i = 0; i < WeaponData.EquipAttributeList.Count; i++)
		{
			float value = WeaponData.EquipAttributeList[i].BaseValue - (float)num * (float)dataRow.AttributeGrow[i][WeaponData.Star] / 10000f;
			_attributeUpgradeItemDataList.Add(new AttributeUpgradeItemData(WeaponData.EquipAttributeList[i], value, WeaponData.EquipAttributeList[i].BaseValue));
		}
	}

	private void LoadStar()
	{
		DRWeapon dataRow = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(WeaponData.Id);
		for (int i = 0; i < WeaponData.EquipAttributeList.Count; i++)
		{
			float value = WeaponData.EquipAttributeList[i].BaseValue - (float)dataRow.AddAttack[i][WeaponData.Star] / 10000f;
			_attributeUpgradeItemDataList.Add(new AttributeUpgradeItemData(WeaponData.EquipAttributeList[i], value, WeaponData.EquipAttributeList[i].BaseValue));
		}
		for (int j = 0; j < WeaponData.EntryDataList.Count; j++)
		{
			float value2 = WeaponData.EntryDataList[j].DrEntry.Level - dataRow.EntryLevUp[j];
			_entryUpgradeItemDataList.Add(new EntryUpgradeItemData(WeaponData.EntryDataList[j], value2, WeaponData.EntryDataList[j].DrEntry.Level));
		}
	}
}
