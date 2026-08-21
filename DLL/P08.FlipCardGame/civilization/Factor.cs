namespace civilization;

public class Factor
{
	public int id;

	public int type;

	public TechType gainType;

	public int[] params_num;

	public Factor(int id, int type, int gainType, int[] params_num)
	{
		this.id = id;
		this.type = type;
		this.gainType = (TechType)gainType;
		this.params_num = params_num;
	}
}
