namespace Ase;

public class HeroSkinTlItemData2 : OptionBase
{
	private int _groupId;

	private string _tlGroupName;

	private string _prefab;

	private bool _selected;

	public int GroupId
	{
		get
		{
			return _groupId;
		}
		set
		{
			Set(ref _groupId, value, "GroupId");
		}
	}

	public string TlGroupName
	{
		get
		{
			return _tlGroupName;
		}
		set
		{
			Set(ref _tlGroupName, value, "TlGroupName");
		}
	}

	public string Prefab
	{
		get
		{
			return _prefab;
		}
		set
		{
			Set(ref _prefab, value, "Prefab");
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

	public HeroSkinTlItemData2()
	{
	}

	public HeroSkinTlItemData2(OptionBase parent, int id, string name, string prefab)
	{
		base.parent = parent;
		GroupId = id;
		TlGroupName = name;
		Prefab = prefab;
	}

	public void PlayTimeline()
	{
		parent?.ItemOnClick(this);
	}
}
