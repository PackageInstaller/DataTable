namespace Ase;

public class ArmourCustomOptionItemData : ItemOptionBase
{
	private ArmourCustomMode _mode;

	private ArmourCustomType _type;

	private int _id;

	private bool _selected;

	private string _entryIcon = "";

	private string _attrIcon = "";

	private string _text;

	public ArmourCustomMode Mode
	{
		get
		{
			return _mode;
		}
		set
		{
			Set(ref _mode, value, "Mode");
		}
	}

	public ArmourCustomType Type
	{
		get
		{
			return _type;
		}
		set
		{
			Set(ref _type, value, "Type");
		}
	}

	public int Id
	{
		get
		{
			return _id;
		}
		set
		{
			Set(ref _id, value, "Id");
		}
	}

	public bool Selected
	{
		get
		{
			return _selected;
		}
		set
		{
			Set(ref _selected, value, "Selected");
		}
	}

	public string EntryIcon
	{
		get
		{
			return _entryIcon;
		}
		set
		{
			Set(ref _entryIcon, value, "EntryIcon");
		}
	}

	public string AttrIcon
	{
		get
		{
			return _attrIcon;
		}
		set
		{
			Set(ref _attrIcon, value, "AttrIcon");
		}
	}

	public string Text
	{
		get
		{
			return _text;
		}
		set
		{
			Set(ref _text, value, "Text");
		}
	}

	public ArmourCustomOptionItemData()
	{
	}

	public ArmourCustomOptionItemData(OptionBase parent, ArmourCustomMode mode, ArmourCustomType type, int id)
	{
		base.parent = parent;
		Mode = mode;
		Refresh(type, id);
	}

	private void Refresh(ArmourCustomType type, int id)
	{
		Type = type;
		Id = id;
		switch (type)
		{
		case ArmourCustomType.MainEntry:
		{
			DREquipment dataRow2 = GameEntry.DataTable.GetDataRow<DREquipment>(id);
			if (dataRow2 != null)
			{
				Refresh(dataRow2);
			}
			break;
		}
		case ArmourCustomType.MainAttribute:
		{
			DRAffix dataRow3 = GameEntry.DataTable.GetDataRow<DRAffix>(id);
			if (dataRow3 != null)
			{
				Refresh(dataRow3);
			}
			break;
		}
		case ArmourCustomType.SubAttribute:
		{
			DRAffix dataRow = GameEntry.DataTable.GetDataRow<DRAffix>(id);
			if (dataRow != null)
			{
				Refresh(dataRow);
			}
			break;
		}
		}
	}

	private void Refresh(DREquipment config)
	{
		int entryId = ((config.Regular.Count > 0) ? config.Regular[0] : 0);
		if (entryId > 0)
		{
			DRAttributeTotal dataRow = GameEntry.DataTable.GetDataRow((DRAttributeTotal p) => p.Uid == entryId);
			if (dataRow != null)
			{
				EntryIcon = dataRow.EntryIcon;
				Text = dataRow.Name;
			}
		}
	}

	private void Refresh(DRAffix config)
	{
		AttrIcon = $"{config.Icon}";
		Text = config.Desc;
	}

	public void OnItemClick()
	{
		parent?.ItemOnClick(this);
	}
}
