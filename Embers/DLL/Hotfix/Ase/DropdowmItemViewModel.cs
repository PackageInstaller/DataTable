namespace Ase;

public class DropdowmItemViewModel : ItemOptionBase
{
	private bool isOn;

	private int index;

	private string desc;

	public int Index
	{
		get
		{
			return index;
		}
		private set
		{
			Set(ref index, value, "Index");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public bool IsOn
	{
		get
		{
			return isOn;
		}
		private set
		{
			Set(ref isOn, value, "IsOn");
		}
	}

	public override void ItemOnClick(object obj)
	{
	}

	public DropdowmItemViewModel()
	{
	}

	public DropdowmItemViewModel(OptionBase parent, int index, string desc, bool isOn = false)
	{
		base.parent = parent;
		this.index = index;
		this.desc = desc;
		this.isOn = isOn;
	}

	public void OnClick(bool val)
	{
		if (val)
		{
			parent.ItemOnClick(this);
		}
	}

	public void SetIsOn(bool val)
	{
		IsOn = val;
	}
}
