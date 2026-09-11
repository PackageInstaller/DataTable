namespace System.Runtime.CompilerServices;

[Serializable]
[AttributeUsage(AttributeTargets.Field | AttributeTargets.Parameter, Inherited = false)]
public sealed class DateTimeConstantAttribute : CustomConstantAttribute
{
	private DateTime _date;

	public override object Value => _date;
}
