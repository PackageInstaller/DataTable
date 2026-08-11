namespace Ase;

public class AchievementRewardItemData : OptionBase
{
	private string icon;

	private int rarity;

	private int count;

	private int state;

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

	public int Count
	{
		get
		{
			return count;
		}
		set
		{
			Set(ref count, value, "Count");
		}
	}

	public int State
	{
		get
		{
			return state;
		}
		set
		{
			Set(ref state, value, "State");
		}
	}

	public AchievementRewardItemData(OptionBase parent, string icon, int rarity, int count, int state)
	{
		base.parent = parent;
		this.icon = icon;
		this.rarity = rarity;
		this.count = count;
		this.state = state;
	}

	public void SetState(int state)
	{
		State = state;
	}
}
