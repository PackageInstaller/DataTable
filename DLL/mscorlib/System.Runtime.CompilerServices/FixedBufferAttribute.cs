namespace System.Runtime.CompilerServices;

[AttributeUsage(AttributeTargets.Field, Inherited = false)]
public sealed class FixedBufferAttribute : Attribute
{
	public Type ElementType { get; }

	public int Length { get; }

	public FixedBufferAttribute(Type elementType, int length)
	{
		ElementType = elementType;
		Length = length;
	}
}
