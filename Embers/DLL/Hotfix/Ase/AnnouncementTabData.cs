namespace Ase;

public class AnnouncementTabData : OptionBase
{
	private bool isSelected;

	private int type;

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public int Type => type;

	public AnnouncementTabData(OptionBase parent, int type)
	{
		base.parent = parent;
		this.type = type;
		isSelected = false;
	}

	public void TabOnClick()
	{
		parent.ItemOnClick(this);
	}
}
