namespace System.Runtime.Serialization;

public readonly struct SerializationEntry
{
	private readonly string _name;

	private readonly object _value;

	private readonly Type _type;

	public object Value => _value;

	public string Name => _name;

	public Type ObjectType => _type;

	internal SerializationEntry(string entryName, object entryValue, Type entryType)
	{
		_name = entryName;
		_value = entryValue;
		_type = entryType;
	}
}
