namespace Ase;

public class PackItemData : OptionBase
{
	private string itemName;

	private string itemDesc;

	private int itemType;

	private string itemIcon;

	private int itemRarity;

	private int itemCount;

	private int itemTotal;

	private int itemIndex;

	private int itemId;

	private bool select;

	public bool Select
	{
		get
		{
			return select;
		}
		private set
		{
			Set(ref select, value, "Select");
		}
	}

	public string ItemName => itemName;

	public string ItemDesc => itemDesc;

	public int ItemType => itemType;

	public string ItemIcon => itemIcon;

	public int ItemRarity => itemRarity;

	public int ItemCount => itemCount;

	public int ItemTotal => itemTotal;

	public int ItemIndex => itemIndex;

	public int ItemId => itemId;

	public PackItemData(OptionBase parent, int itemId, int itemType, int itemIndex, int itemCount = 1)
	{
		base.parent = parent;
		this.itemId = itemId;
		this.itemType = itemType;
		this.itemIndex = itemIndex;
		this.itemCount = itemCount;
		if (itemType == 5)
		{
			LoadWeapon();
		}
		else
		{
			LoadProp();
		}
	}

	private void LoadWeapon()
	{
		WeaponData weaponData = WeaponData.CreateWeaponData(itemId);
		itemIcon = weaponData.Icon;
		itemName = weaponData.Name;
		itemDesc = UiConvert.Equip.WeaponEnum2Name[weaponData.WeaponEnum];
	}

	private void LoadProp()
	{
		PropDataBase propDataBase = PropDataBase.CreateByType(1, itemId, itemCount);
		itemIcon = propDataBase.Icon;
		itemName = propDataBase.Name;
		itemDesc = propDataBase.Description;
		itemRarity = propDataBase.Quality;
		itemTotal = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(itemId)?.Amount ?? 0;
	}

	public void SetSelect(bool value)
	{
		Select = value;
	}

	public void OnClick()
	{
		parent?.ItemOnClick(new OptionArg(this, ""));
	}
}
