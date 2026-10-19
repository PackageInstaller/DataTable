namespace System.Runtime.InteropServices;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Method | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Interface | AttributeTargets.Delegate, Inherited = false)]
public sealed class ComVisibleAttribute : Attribute
{
	internal bool _val;

	public bool Value => _val;

	public ComVisibleAttribute(bool visibility)
	{
		_val = visibility;
	}
}
