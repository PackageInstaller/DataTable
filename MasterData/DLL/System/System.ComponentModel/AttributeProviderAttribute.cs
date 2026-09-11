namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.Property)]
public class AttributeProviderAttribute : Attribute
{
	public string TypeName { get; }

	public string PropertyName { get; }
}
