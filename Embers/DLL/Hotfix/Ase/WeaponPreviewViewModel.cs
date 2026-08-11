using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class WeaponPreviewViewModel : OptionBase
{
	private WeaponData weaponData;

	private List<AttributeItemData> attributeItemData;

	private List<EntryItemData> entryItemData;

	private string type;

	private TabItemNormalData btnOriginLevel;

	private TabItemNormalData btnMaxLevel;

	private InteractionRequest refreshWeaponDataRequest;

	public WeaponData WeaponData => weaponData;

	public string Type => type;

	public List<AttributeItemData> AttributeItemData
	{
		get
		{
			return attributeItemData;
		}
		private set
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
		private set
		{
			Set(ref entryItemData, value, "EntryItemData");
		}
	}

	public InteractionRequest RefreshWeaponDataRequest => refreshWeaponDataRequest;

	public TabItemNormalData BtnOriginLevel => btnOriginLevel;

	public TabItemNormalData BtnMaxLevel => btnMaxLevel;

	public WeaponPreviewViewModel(OptionBase parent, WeaponData weaponData)
	{
		base.parent = parent;
		Init();
		this.weaponData = weaponData;
		SetWeaponInfo();
	}

	public WeaponPreviewViewModel(OptionBase parent, int weaponId)
	{
		base.parent = parent;
		Init();
		weaponData = WeaponData.CreateWeaponData(weaponId);
		SetWeaponInfo();
	}

	private void Init()
	{
		attributeItemData = new List<AttributeItemData>();
		entryItemData = new List<EntryItemData>();
		refreshWeaponDataRequest = new InteractionRequest();
		btnOriginLevel = new TabItemNormalData(this, "empty");
		btnMaxLevel = new TabItemNormalData(this, "empty", 1);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemNormalData tabItemNormalData)
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

	private void SetWeaponInfo()
	{
		type = UiConvert.Equip.WeaponEnum2Name[weaponData.WeaponEnum];
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
