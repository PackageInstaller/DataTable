namespace Unity.VisualScripting;

[UnitTitle("Modulo")]
[UnitCategory("Math/Generic")]
public sealed class GenericModulo : Modulo<object>
{
	public override object Operation(object a, object b)
	{
		return OperatorUtility.Modulo(a, b);
	}
}
