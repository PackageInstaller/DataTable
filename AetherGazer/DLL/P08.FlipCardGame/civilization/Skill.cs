namespace civilization;

public class Skill
{
	public int id;

	public int cost;

	public int cd;

	public string spritePath;

	public Skill(int id, int cost, int cd, string spritePath)
	{
		this.id = id;
		this.cost = cost;
		this.cd = cd;
		this.spritePath = spritePath;
	}

	public Skill Clone()
	{
		return new Skill(id, cost, cd, spritePath);
	}
}
