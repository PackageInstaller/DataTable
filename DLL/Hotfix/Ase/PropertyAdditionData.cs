namespace Ase;

public class PropertyAdditionData
{
	public string propertyKey;

	public PropertyType propertyType;

	public ChangeType operation;

	public NumericalValueType valueType;

	public float value;

	public bool ignoreMax;

	public static PropertyAdditionData Create(string propertyKey, float value)
	{
		return new PropertyAdditionData
		{
			propertyKey = propertyKey,
			value = value,
			propertyType = PropertyType.Cur,
			operation = ChangeType.Add,
			valueType = NumericalValueType.FixedValue,
			ignoreMax = false
		};
	}
}
