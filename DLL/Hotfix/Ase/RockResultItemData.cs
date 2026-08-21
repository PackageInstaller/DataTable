namespace Ase;

public class RockResultItemData : OptionBase
{
	private int type;

	private string title;

	private string exText;

	public int Type => type;

	public string Title => title;

	public string ExText
	{
		get
		{
			return exText;
		}
		private set
		{
			Set(ref exText, value, "ExText");
		}
	}

	public RockResultItemData(OptionBase parent, int type, string title)
	{
		base.parent = parent;
		this.type = type;
		this.title = title;
	}

	public void SetExText(string text)
	{
		ExText = text;
	}
}
