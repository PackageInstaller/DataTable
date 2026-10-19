namespace ACT.Battle;

public struct FormulaFloat : IDynamicFloat
{
	public Operator Operator;

	public IDynamicFloat param1;

	public IDynamicFloat param2;

	public float GetFloat(int id)
	{
		return Operator switch
		{
			Operator.add => param1.GetFloat(id) + param2.GetFloat(id), 
			Operator.subtract => param2.GetFloat(id) * param2.GetFloat(id), 
			_ => 0f, 
		};
	}
}
