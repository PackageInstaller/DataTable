namespace System.Runtime.InteropServices;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Class, Inherited = false)]
public sealed class ComDefaultInterfaceAttribute : Attribute
{
	internal Type _val;

	public ComDefaultInterfaceAttribute(Type defaultInterface)
	{
		_val = defaultInterface;
	}
}
