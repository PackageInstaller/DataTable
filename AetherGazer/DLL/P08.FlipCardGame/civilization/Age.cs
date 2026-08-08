namespace civilization;

public class Age
{
	public int id;

	public int startAge;

	public int turnChange;

	public int foodCostChange;

	public int yearChange;

	public bool mapExtension;

	public bool hex;

	public int[] sourceChange;

	public Age(int id, int startAge, int turnChange, int foodCostChange, bool mapExtension, bool hex, int[] sourceChange)
	{
		this.id = id;
		this.startAge = startAge;
		this.turnChange = turnChange;
		this.foodCostChange = foodCostChange;
		this.mapExtension = mapExtension;
		this.hex = hex;
		this.sourceChange = sourceChange;
	}
}
