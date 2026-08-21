namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.Class)]
public sealed class DefaultEventAttribute : Attribute
{
	public static readonly DefaultEventAttribute Default = new DefaultEventAttribute(null);

	public string Name { get; }

	public DefaultEventAttribute(string name)
	{
		Name = name;
	}

	public override bool Equals(object obj)
	{
		if (obj is DefaultEventAttribute defaultEventAttribute)
		{
			return defaultEventAttribute.Name == Name;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}
}
