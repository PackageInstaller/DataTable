namespace Ase;

internal class AchievementGetPropViewModel : OptionBase
{
	private string icon;

	private string title;

	private int rarity;

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

	public string Title
	{
		get
		{
			return title;
		}
		set
		{
			Set(ref title, value, "Title");
		}
	}

	public int Rarity
	{
		get
		{
			return rarity;
		}
		set
		{
			Set(ref rarity, value, "Rarity");
		}
	}

	public AchievementGetPropViewModel(string icon, string title, int rarity)
	{
		this.icon = icon;
		this.title = title;
		this.rarity = rarity;
	}
}
