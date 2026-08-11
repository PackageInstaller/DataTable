namespace Ase;

public class ToggleItemViewModel : OptionBase
{
	private int id;

	private int parentId;

	private bool isSelect;

	private bool red;

	private string name;

	private bool isValid = true;

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public bool Red
	{
		get
		{
			return red;
		}
		set
		{
			Set(ref red, value, "Red");
		}
	}

	public int Id => id;

	public int ParentId => parentId;

	public bool IsValid
	{
		get
		{
			return isValid;
		}
		set
		{
			isValid = value;
		}
	}

	public ToggleItemViewModel()
	{
	}

	public ToggleItemViewModel(OptionBase parent, DRGuidanceLevel guidanceLevel, bool isRed)
	{
		base.parent = parent;
		id = guidanceLevel.Id;
		parentId = guidanceLevel.ParentId;
		name = guidanceLevel.Name;
		red = isRed;
	}

	public void OnSelect()
	{
		parent.ItemOnClick(new OptionArg(this, "SelectToggle"));
	}
}
