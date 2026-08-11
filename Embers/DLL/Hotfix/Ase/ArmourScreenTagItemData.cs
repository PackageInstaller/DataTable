namespace Ase;

public class ArmourScreenTagItemData : OptionBase
{
	private string _showText;

	private bool _isSelected;

	private int _type;

	private int id;

	private int entryType;

	private int bgType;

	public string ShowText => _showText;

	public int Type => _type;

	public int ID => id;

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

	public int BgType => bgType;

	public int EntryType => entryType;

	public ArmourScreenTagItemData(OptionBase parent, int uid)
	{
		base.parent = parent;
		DRAttributeTotal drAttributeTotal = GameEntry.DataTable.GetDataRow((DRAttributeTotal p) => p.Id == uid);
		if (drAttributeTotal == null)
		{
			return;
		}
		id = drAttributeTotal.Uid;
		_type = drAttributeTotal.Type;
		bgType = ((drAttributeTotal.Type == 2) ? 1 : 4);
		if (_type == 3)
		{
			entryType = drAttributeTotal.EntryType;
			if (entryType == 1)
			{
				bgType = 3;
			}
			DREntry dataRow = GameEntry.DataTable.GetDataRow((DREntry p) => p.EntryId == drAttributeTotal.Uid);
			if (dataRow != null && dataRow.SpecialEntry == 1)
			{
				bgType = 2;
			}
		}
		_showText = drAttributeTotal.Name;
	}

	public void ButtonOnclick()
	{
		parent.ItemOnClick(this);
	}
}
