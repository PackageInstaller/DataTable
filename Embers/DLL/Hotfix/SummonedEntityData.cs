using GameFramework;

public class SummonedEntityData : IReference
{
	public bool IsSyncEntityCommand;

	public SummonedEntity Summoned;

	public void Clear()
	{
		IsSyncEntityCommand = false;
		Summoned = null;
	}
}
