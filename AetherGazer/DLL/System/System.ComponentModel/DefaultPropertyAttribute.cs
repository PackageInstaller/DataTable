namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.Class)]
public sealed class DefaultPropertyAttribute : Attribute
{
	public static readonly DefaultPropertyAttribute Default = new DefaultPropertyAttribute(null);

	public string Name { get; }

	public DefaultPropertyAttribute(string name)
	{
		Name = name;
	}

	public override bool Equals(object obj)
	{
		if (obj is DefaultPropertyAttribute defaultPropertyAttribute)
		{
			return defaultPropertyAttribute.Name == Name;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}
}
