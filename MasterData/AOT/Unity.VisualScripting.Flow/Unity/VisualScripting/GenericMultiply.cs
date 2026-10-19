namespace Unity.VisualScripting;

[UnitCategory("Math/Generic")]
[UnitTitle("Multiply")]
public sealed class GenericMultiply : Multiply<object>
{
	public override object Operation(object a, object b)
	{
		return OperatorUtility.Multiply(a, b);
	}
}
