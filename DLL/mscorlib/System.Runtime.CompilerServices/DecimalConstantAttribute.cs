namespace System.Runtime.CompilerServices;

[Serializable]
[AttributeUsage(AttributeTargets.Field | AttributeTargets.Parameter, Inherited = false)]
public sealed class DecimalConstantAttribute : Attribute
{
	private decimal _dec;

	public decimal Value => _dec;

	[CLSCompliant(false)]
	public DecimalConstantAttribute(byte scale, byte sign, uint hi, uint mid, uint low)
	{
		_dec = new decimal((int)low, (int)mid, (int)hi, sign != 0, scale);
	}
}
