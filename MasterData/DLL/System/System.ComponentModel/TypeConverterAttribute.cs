namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.All)]
public sealed class TypeConverterAttribute : Attribute
{
	public static readonly TypeConverterAttribute Default = new TypeConverterAttribute();

	public string ConverterTypeName { get; }

	public TypeConverterAttribute()
	{
		ConverterTypeName = string.Empty;
	}

	public TypeConverterAttribute(Type type)
	{
		ConverterTypeName = type.AssemblyQualifiedName;
	}

	public TypeConverterAttribute(string typeName)
	{
		ConverterTypeName = typeName;
	}

	public override bool Equals(object obj)
	{
		if (obj is TypeConverterAttribute typeConverterAttribute)
		{
			return typeConverterAttribute.ConverterTypeName == ConverterTypeName;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return ConverterTypeName.GetHashCode();
	}
}
