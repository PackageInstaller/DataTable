namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.All)]
public sealed class AmbientValueAttribute : Attribute
{
	public object Value { get; }
}
