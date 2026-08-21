namespace Ase;

public class TabItemViewModel : SelectItemViewModel
{
	protected int id;

	protected string icon;

	protected string name;

	public string Icon
	{
		get
		{
			return icon;
		}
		set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public int ID => id;

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public TabItemViewModel()
	{
	}

	public TabItemViewModel(OptionBase parent)
		: base(parent)
	{
	}

	public TabItemViewModel(OptionBase parent, DREmoticonType emoticonType)
		: base(parent)
	{
		icon = emoticonType.Icon;
		name = emoticonType.Name;
		id = emoticonType.Id;
	}
}
