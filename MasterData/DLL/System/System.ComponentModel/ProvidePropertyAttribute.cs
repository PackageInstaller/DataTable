namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = true)]
public sealed class ProvidePropertyAttribute : Attribute
{
	public string PropertyName { get; }

	public string ReceiverTypeName { get; }
}
