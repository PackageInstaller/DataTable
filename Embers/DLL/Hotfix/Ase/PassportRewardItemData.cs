namespace Ase;

public class PassportRewardItemData : OptionBase
{
	private int indexId;

	private int id;

	private int type;

	private string icon;

	private int rarity;

	private int count;

	private bool redPoint;

	private bool isLock;

	private bool isReceived;

	private bool isImportant;

	private bool isEmpty;

	private int grade;

	public bool IsReceived
	{
		get
		{
			return isReceived;
		}
		set
		{
			Set(ref isReceived, value, "IsReceived");
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

	public bool RedPoint
	{
		get
		{
			return redPoint;
		}
		set
		{
			Set(ref redPoint, value, "RedPoint");
		}
	}

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

	public int ID => id;

	public int Type => type;

	public string Icon => icon;

	public int Rarity => rarity;

	public int Count => count;

	public bool IsImportant => isImportant;

	public int IndexId => indexId;

	public PassportRewardItemData(OptionBase parent, bool isImportant, int grade)
	{
		base.parent = parent;
		icon = "empty";
		rarity = 1;
		IsEmpty = true;
		this.isImportant = isImportant;
		this.grade = grade;
		indexId = 0;
	}

	public void SetItem(int id, int type, int count, int indexId = 0)
	{
		this.indexId = indexId;
		this.id = id;
		this.type = type;
		this.count = count;
		switch (type)
		{
		case 2:
		{
			DREquipment dataRow4 = GameEntry.DataTable.GetDataRow<DREquipment>(id);
			if (dataRow4 != null)
			{
				icon = dataRow4.Icon;
				rarity = dataRow4.Rarity;
				IsEmpty = false;
			}
			break;
		}
		case 5:
		{
			DRWeapon dataRow2 = GameEntry.DataTable.GetDataRow<DRWeapon>(id);
			if (dataRow2 != null)
			{
				icon = dataRow2.Icon;
				rarity = dataRow2.Rarity;
				IsEmpty = false;
			}
			break;
		}
		case 12:
		{
			DRHeadDecorate dataRow3 = GameEntry.DataTable.GetDataRow<DRHeadDecorate>(id);
			if (dataRow3 != null)
			{
				icon = dataRow3.Icon;
				rarity = dataRow3.Quality;
				IsEmpty = false;
			}
			break;
		}
		default:
		{
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(id);
			if (dataRow != null)
			{
				icon = dataRow.Icon;
				rarity = dataRow.Quality;
				IsEmpty = false;
			}
			break;
		}
		}
	}

	public void OnClick()
	{
		if (!IsEmpty)
		{
			if (IsLock || IsReceived)
			{
				parent?.ItemOnClick(new OptionArg(this, "OpenProp"));
			}
			else if (RedPoint)
			{
				parent?.ItemOnClick(new OptionArg(this, "ReceiveReward"));
			}
		}
	}
}
