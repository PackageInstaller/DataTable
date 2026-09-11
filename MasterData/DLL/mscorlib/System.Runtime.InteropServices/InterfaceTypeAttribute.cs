namespace System.Runtime.InteropServices;

[AttributeUsage(AttributeTargets.Interface, Inherited = false)]
[ComVisible(true)]
public sealed class InterfaceTypeAttribute : Attribute
{
	internal ComInterfaceType _val;

	public InterfaceTypeAttribute(ComInterfaceType interfaceType)
	{
		_val = interfaceType;
	}
}
