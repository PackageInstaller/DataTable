using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class PassportShowViewModel : OptionBase
{
	private List<WeaponItemData> weaponItemDataList;

	private WeaponData weaponData;

	private List<AttributeItemData> attributeItemData;

	private List<EntryItemData> entryItemData;

	private string type;

	private TabItemNormalData btnOriginLevel;

	private TabItemNormalData btnMaxLevel;

	private InteractionRequest refreshWeaponDataRequest;

	private InteractionRequest refreshWeaponObjRequest;

	private KnapsackItemViewModel curSelect;

	public WeaponData WeaponData
	{
		get
		{
			return weaponData;
		}
		private set
		{
			Set(ref weaponData, value, "WeaponData");
		}
	}

	public string Type
	{
		get
		{
			return type;
		}
		private set
		{
			Set(ref type, value, "Type");
		}
	}

	public List<AttributeItemData> AttributeItemData
	{
		get
		{
			return attributeItemData;
		}
		set
		{
			Set(ref attributeItemData, value, "AttributeItemData");
		}
	}

	public List<EntryItemData> EntryItemData
	{
		get
		{
			return entryItemData;
		}
		set
		{
			Set(ref entryItemData, value, "EntryItemData");
		}
	}

	public List<WeaponItemData> WeaponItemDataList => weaponItemDataList;

	public InteractionRequest RefreshWeaponDataRequest => refreshWeaponDataRequest;

	public InteractionRequest RefreshWeaponObjRequest => refreshWeaponObjRequest;

	public TabItemNormalData BtnOriginLevel => btnOriginLevel;

	public TabItemNormalData BtnMaxLevel => btnMaxLevel;

	public PassportShowViewModel(OptionBase parent)
	{
		base.parent = parent;
		DRWeaponShow[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRWeaponShow>();
		weaponItemDataList = new List<WeaponItemData>();
		DRWeaponShow[] array = allDataRow;
		for (int i = 0; i < array.Length; i++)
		{
			WeaponData data = WeaponData.CreateWeaponData(array[i].Id);
			WeaponItemData item = new WeaponItemData(this, data);
			weaponItemDataList.Add(item);
		}
		attributeItemData = new List<AttributeItemData>();
		entryItemData = new List<EntryItemData>();
		refreshWeaponDataRequest = new InteractionRequest();
		refreshWeaponObjRequest = new InteractionRequest();
		WeaponOnClick(WeaponItemDataList[0]);
		SetWeaponInfo(WeaponItemDataList[0].Data);
		btnOriginLevel = new TabItemNormalData(this, "empty");
		btnMaxLevel = new TabItemNormalData(this, "empty", 1);
		ItemOnClick(btnOriginLevel);
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			WeaponOnClick(knapsackItemViewModel);
			if (knapsackItemViewModel.PropDataBase is WeaponData weaponInfo)
			{
				SetWeaponInfo(weaponInfo);
			}
			refreshWeaponDataRequest.Raise();
		}
		else if (obj is TabItemNormalData tabItemNormalData)
		{
			btnOriginLevel.IsSelected = tabItemNormalData.ID == btnOriginLevel.ID;
			btnMaxLevel.IsSelected = tabItemNormalData.ID == btnMaxLevel.ID;
			if (btnOriginLevel.IsSelected)
			{
				SetOriginalLevel();
			}
			if (btnMaxLevel.IsSelected)
			{
				SetMaxLevel();
			}
		}
	}

	private void WeaponOnClick(KnapsackItemViewModel knapsackItemViewModel)
	{
		if (!knapsackItemViewModel.IsSelected)
		{
			if (curSelect != null)
			{
				curSelect.IsSelected = false;
			}
			curSelect = knapsackItemViewModel;
			curSelect.IsSelected = true;
		}
	}

	private void SetWeaponInfo(WeaponData weaponData)
	{
		WeaponData = weaponData;
		Type = UiConvert.Equip.WeaponEnum2Name[weaponData.WeaponEnum];
		refreshWeaponObjRequest.Raise();
		RefreshAttribute();
		ItemOnClick(btnOriginLevel);
	}

	private void SetOriginalLevel()
	{
		WeaponData.SetOriginLevel(weaponData);
		RefreshAttribute();
		refreshWeaponDataRequest.Raise();
	}

	private void SetMaxLevel()
	{
		weaponData.SetMaxLevel(weaponData);
		RefreshAttribute();
		refreshWeaponDataRequest.Raise();
	}

	private void RefreshAttribute()
	{
		AttributeItemData.Clear();
		EntryItemData.Clear();
		for (int i = 0; i < WeaponData.EquipAttributeList.Count; i++)
		{
			float baseValue = WeaponData.EquipAttributeList[i].BaseValue;
			AttributeItemData.Add(new AttributeItemData(WeaponData.EquipAttributeList[i], baseValue));
		}
		for (int j = 0; j < WeaponData.EntryDataList.Count; j++)
		{
			EntryItemData.Add(new EntryItemData(this, WeaponData.EntryDataList[j]));
		}
	}
}
