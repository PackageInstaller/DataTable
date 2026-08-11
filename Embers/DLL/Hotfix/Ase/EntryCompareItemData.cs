namespace Ase;

public class EntryCompareItemData : OptionBase
{
	private bool _isSelected;

	private EntryChangeData _entryChangeData;

	private EntryChangeEnum _changeEnum;

	private bool _isRock;

	public bool IsRock
	{
		get
		{
			return _isRock;
		}
		set
		{
			Set(ref _isRock, value, "IsRock");
		}
	}

	public bool IsSelected
	{
		get
		{
			return _isSelected;
		}
		set
		{
			Set(ref _isSelected, value, "IsSelected");
		}
	}

	public EntryChangeEnum ChangeEnum
	{
		get
		{
			return _changeEnum;
		}
		set
		{
			Set(ref _changeEnum, value, "ChangeEnum");
		}
	}

	public EntryChangeData EntryChangeData
	{
		get
		{
			return _entryChangeData;
		}
		set
		{
			Set(ref _entryChangeData, value, "EntryChangeData");
		}
	}

	public EntryCompareItemData()
	{
	}

	public EntryCompareItemData(OptionBase parent, EntryChangeData entryChangeData, bool isRock)
	{
		base.parent = parent;
		IsRock = isRock;
		EntryChangeData = entryChangeData;
		ChangeEnum = entryChangeData.ChangeEnum;
	}

	public void OnClick()
	{
		parent?.ItemOnClick(this);
	}
}
