namespace Ase;

public class GamePropGuideItemData : OptionBase
{
	private int id;

	private string iconPath;

	private int rarity;

	private string propDesc;

	private string propName;

	private int propGuideType;

	private string weaponEnumIconPath;

	private int sortId;

	private bool isNew;

	private bool isSelected;

	private bool isLock;

	public int ID => id;

	public string IconPath => iconPath;

	public int Rarity => rarity;

	public int PropGuideType => propGuideType;

	public string WeaponEnumIconPath => weaponEnumIconPath;

	public string PropDesc => propDesc;

	public string PropName => propName;

	public bool IsLock => isLock;

	public int SortId => sortId;

	public bool IsNew
	{
		get
		{
			return isNew;
		}
		private set
		{
			Set(ref isNew, value, "IsNew");
		}
	}

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		private set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public GamePropGuideItemData(OptionBase parent, int id, int propGuideType, int sortId)
	{
		base.parent = parent;
		this.id = id;
		this.propGuideType = propGuideType;
		this.sortId = sortId;
		isSelected = false;
		if (PropGuideType == 1)
		{
			LoadWeaponData();
		}
		else if (PropGuideType == 2)
		{
			LoadPropData();
		}
	}

	private void LoadWeaponData()
	{
		DRWeapon dataRow = GameEntry.DataTable.GetDataRow<DRWeapon>(ID);
		if (dataRow != null)
		{
			iconPath = dataRow.Icon;
			rarity = dataRow.Rarity;
			weaponEnumIconPath = $"WeaponEnum_{(int)dataRow.WeaponEnum}";
			propDesc = dataRow.Desc;
			propName = dataRow.Name;
		}
		else
		{
			Toast.ShowError($"风物志 武魂Id:{ID} 查找不到数据!");
		}
	}

	private void LoadPropData()
	{
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(ID);
		if (dataRow != null)
		{
			iconPath = dataRow.Icon;
			rarity = dataRow.Quality;
			weaponEnumIconPath = "empty";
			propDesc = dataRow.Function;
			propName = dataRow.Name;
		}
		else
		{
			Toast.ShowError($"风物志 物品Id:{ID} 查找不到数据!");
		}
	}

	public void SetIsNew(bool value)
	{
		if (!IsLock)
		{
			IsNew = value;
		}
	}

	public void SetIsLock(bool value)
	{
		isLock = PropGuideType != 2 && value;
	}

	public void SetSelected(bool value)
	{
		IsSelected = value;
	}

	public void OnClick()
	{
		if (!IsSelected)
		{
			SetRedPoint();
			parent?.ItemOnClick(new OptionArg(this, "OnClick"));
		}
	}

	public void SetRedPoint()
	{
		if (IsNew)
		{
			IsNew = false;
			Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().SaveRedPoint(5, id);
		}
	}
}
