using System.Collections.Generic;

namespace Ase;

public class DrawCardOptionalItemData : OptionBase
{
	private int itemId;

	private int itemType;

	private string itemIcon;

	private string itemName;

	private string itemDesc;

	private int itemRarity;

	private int heroDestiny;

	private int heroAttribute;

	private int weaponEnum;

	private string weaponEnumText;

	private bool isSelected;

	private string weaponEffectDesc;

	private List<List<float>> effectValue;

	private List<TabItemNormalData> tagList;

	public int ItemId => itemId;

	public int ItemType => itemType;

	public string ItemIcon
	{
		get
		{
			return itemIcon;
		}
		set
		{
			Set(ref itemIcon, value, "ItemIcon");
		}
	}

	public string ItemName => itemName;

	public string ItemDesc => itemDesc;

	public int ItemRarity => itemRarity;

	public List<TabItemNormalData> TagList => tagList;

	public int HeroDestiny => heroDestiny;

	public int HeroAttribute => heroAttribute;

	public int WeaponEnum
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

	public string WeaponEnumText => weaponEnumText;

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

	public string WeaponEffectDesc => weaponEffectDesc;

	public List<List<float>> EffectValue => effectValue;

	public DrawCardOptionalItemData(OptionBase parent, int itemId, int itemType)
	{
		base.parent = parent;
		this.itemId = itemId;
		this.itemType = itemType;
		tagList = new List<TabItemNormalData>();
		if (ItemType == 4)
		{
			LoadHero();
		}
		else if (ItemType == 5)
		{
			LoadWeapon();
		}
	}

	private void LoadWeapon()
	{
		DRWeapon dataRow = GameEntry.DataTable.GetDataRow<DRWeapon>(itemId);
		if (dataRow == null || dataRow.Tag.Count != dataRow.TagColor.Count)
		{
			Toast.ShowError($"武器:{itemId}的数据错误!");
			return;
		}
		itemIcon = dataRow.Icon;
		itemName = dataRow.Name;
		itemDesc = dataRow.Desc;
		itemRarity = dataRow.Rarity;
		weaponEnum = (int)dataRow.WeaponEnum;
		weaponEnumText = UiConvert.Equip.WeaponEnum2Name[dataRow.WeaponEnum];
		weaponEffectDesc = dataRow.WeaponEffectDesc;
		effectValue = dataRow.EffectValue;
		for (int i = 0; i < dataRow.Tag.Count; i++)
		{
			TabItemNormalData tabItemNormalData = new TabItemNormalData(dataRow.Tag[i]);
			tabItemNormalData.SetColor("#" + dataRow.TagColor[i]);
			tagList.Add(tabItemNormalData);
		}
	}

	private void LoadHero()
	{
		DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(itemId);
		if (dataRow == null || dataRow.Tag.Count != dataRow.TagColor.Count)
		{
			Toast.ShowError($"英雄:{itemId}的数据错误!");
			return;
		}
		itemIcon = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.Card, itemId);
		itemName = dataRow.Name;
		itemDesc = dataRow.Story;
		itemRarity = dataRow.Rarity;
		heroDestiny = dataRow.RawSeat;
		heroAttribute = (int)dataRow.HeroAttributeEnum;
		for (int i = 0; i < dataRow.Tag.Count; i++)
		{
			TabItemNormalData tabItemNormalData = new TabItemNormalData(dataRow.Tag[i]);
			tabItemNormalData.SetColor("#" + dataRow.TagColor[i]);
			tagList.Add(tabItemNormalData);
		}
	}

	public void OnClick()
	{
		parent?.ItemOnClick(this);
	}

	public void OpenPreview()
	{
		parent?.ItemOnClick(new OptionArg(this, "OpenPreview"));
	}
}
