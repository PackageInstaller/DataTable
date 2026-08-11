namespace Ase;

public class SpinePlayItemData : OptionBase
{
	private int _spineId;

	private string _spineIcon = "";

	private bool _selected;

	private int _itemIndex;

	private DRSkinTheater _config;

	public int SpineId
	{
		get
		{
			return _spineId;
		}
		set
		{
			Set(ref _spineId, value, "SpineId");
		}
	}

	public string SpineIcon
	{
		get
		{
			return _spineIcon;
		}
		set
		{
			Set(ref _spineIcon, value, "SpineIcon");
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

	public int ItemIndex => _itemIndex;

	public DRSkinTheater Config => _config;

	public SpinePlayItemData()
	{
	}

	public SpinePlayItemData(OptionBase parent, int itemIndex, int skinId)
	{
		base.parent = parent;
		_itemIndex = itemIndex;
		SpineId = skinId;
		_config = GameEntry.DataTable.GetDataRow((DRSkinTheater p) => p.SkinId == skinId);
		if (_config != null)
		{
			SpineIcon = _config.TheaterIcon;
		}
	}
}
