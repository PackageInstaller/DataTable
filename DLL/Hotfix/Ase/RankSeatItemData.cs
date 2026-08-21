namespace Ase;

public class RankSeatItemData : PlayerItemBaseData
{
	private string heroIcon = "";

	private bool btnEnable;

	private bool empty;

	private bool valid = true;

	private bool isSelf;

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public string HeroIcon
	{
		get
		{
			return heroIcon;
		}
		set
		{
			Set(ref heroIcon, value, "HeroIcon");
		}
	}

	public bool BtnEnable
	{
		get
		{
			return btnEnable;
		}
		set
		{
			Set(ref btnEnable, value, "BtnEnable");
		}
	}

	public bool Empty
	{
		get
		{
			return empty;
		}
		set
		{
			Set(ref empty, value, "Empty");
		}
	}

	public bool Valid
	{
		get
		{
			return valid;
		}
		set
		{
			Set(ref valid, value, "Valid");
		}
	}

	public RankSeatItemData()
	{
	}

	public RankSeatItemData(OptionBase parent)
	{
		base.parent = parent;
		BtnEnable = false;
		Empty = true;
	}

	public RankSeatItemData(OptionBase parent, long uid, string name, int level, int icon, int iconFrame, int title, int state = 0)
		: base(parent, uid, name, level, icon, iconFrame, title, state)
	{
		Empty = false;
		Valid = uid > 0;
		BtnEnable = Valid;
	}

	public void OnItemClick()
	{
		parent?.ItemOnClick(this);
	}
}
