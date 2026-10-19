namespace Unity.VisualScripting;

[UnitCategory("Math/Generic")]
[UnitTitle("Divide")]
public sealed class GenericDivide : Divide<object>
{
	public override object Operation(object a, object b)
	{
		return OperatorUtility.Divide(a, b);
	}
}
