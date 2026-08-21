namespace Ase;

public class BaseItemData : OptionBase
{
	private object arg;

	private string icon = "";

	private string text;

	public object Arg
	{
		get
		{
			return arg;
		}
		set
		{
			Set(ref arg, value, "Arg");
		}
	}

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

	public string Text
	{
		get
		{
			return text;
		}
		set
		{
			Set(ref text, value, "Text");
		}
	}

	public BaseItemData()
	{
	}

	public BaseItemData(OptionBase parent)
	{
		base.parent = parent;
	}

	public void OnItemClick()
	{
		parent?.ItemOnClick(this);
	}
}
