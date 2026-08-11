namespace Ase;

public class RankTabItemData : ItemOptionBase
{
	private int _copyId;

	private string _copyName;

	private bool _selected;

	public int CopyId => _copyId;

	public string CopyName
	{
		get
		{
			return _copyName;
		}
		set
		{
			Set(ref _copyName, value, "CopyName");
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

	public RankTabItemData()
	{
	}

	public RankTabItemData(OptionBase parent, DRCopy drCopy)
	{
		base.parent = parent;
		_copyId = drCopy.Id;
		CopyName = drCopy.Name;
	}

	public void OnItemClick()
	{
		parent?.ItemOnClick(this);
	}
}
