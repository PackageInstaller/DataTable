namespace Ase;

public class ThingBase
{
	private int thingType;

	private int thingId;

	private long thingCount;

	public int ThingType => thingType;

	public int ThingId => thingId;

	public long ThingCount => thingCount;

	public ThingBase(int type, int id, long thingCount)
	{
		thingType = type;
		thingId = id;
		this.thingCount = thingCount;
	}
}
