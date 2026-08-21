namespace Ase;

public class MonsterDropItemData : ItemOptionBase
{
	private string nameText;

	public string NameText
	{
		get
		{
			return nameText;
		}
		set
		{
			Set(ref nameText, value, "NameText");
		}
	}

	public MonsterDropItemData()
	{
	}

	public MonsterDropItemData(string name, int limitLevel)
	{
		NameText = name;
	}
}
