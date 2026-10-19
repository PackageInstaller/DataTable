namespace ACT.Battle;

public struct ConstFloat : IDynamicFloat
{
	public float value;

	public float GetFloat(int id)
	{
		return value;
	}
}
