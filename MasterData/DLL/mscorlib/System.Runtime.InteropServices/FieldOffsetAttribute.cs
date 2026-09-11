namespace System.Runtime.InteropServices;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Field, Inherited = false)]
public sealed class FieldOffsetAttribute : Attribute
{
	internal int _val;

	public FieldOffsetAttribute(int offset)
	{
		_val = offset;
	}
}
