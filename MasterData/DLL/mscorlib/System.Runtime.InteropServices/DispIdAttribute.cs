namespace System.Runtime.InteropServices;

[AttributeUsage(AttributeTargets.Method | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Event, Inherited = false)]
[ComVisible(true)]
public sealed class DispIdAttribute : Attribute
{
	internal int _val;

	public DispIdAttribute(int dispId)
	{
		_val = dispId;
	}
}
