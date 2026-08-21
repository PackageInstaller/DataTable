using GameFramework;

public class UnitDataInt : IUnitData, IReference
{
	public int Value;

	public void Clear()
	{
		Value = 0;
	}

	public static UnitDataInt Create(int value)
	{
		UnitDataInt unitDataInt = ReferencePool.Acquire<UnitDataInt>();
		unitDataInt.Value = value;
		return unitDataInt;
	}
}
