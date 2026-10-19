namespace System.Runtime.InteropServices;

[AttributeUsage(AttributeTargets.Field, Inherited = false)]
[ComVisible(true)]
public sealed class FieldOffsetAttribute : Attribute
{
	internal int _val;

	public FieldOffsetAttribute(int offset)
	{
		_val = offset;
	}
}
