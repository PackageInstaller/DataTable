namespace civilization;

public class TechLevel
{
	public int level;

	public int cost;

	public int[] techList;

	public TechLevel(int level, int cost, int[] techList)
	{
		this.level = level;
		this.cost = cost;
		this.techList = techList;
	}
}
