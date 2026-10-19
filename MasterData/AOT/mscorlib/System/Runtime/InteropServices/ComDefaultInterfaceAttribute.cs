namespace System.Runtime.InteropServices;

[AttributeUsage(AttributeTargets.Class, Inherited = false)]
[ComVisible(true)]
public sealed class ComDefaultInterfaceAttribute : Attribute
{
	internal Type _val;

	public ComDefaultInterfaceAttribute(Type defaultInterface)
	{
		_val = defaultInterface;
	}
}
