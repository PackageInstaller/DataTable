using System;
using Unity.VisualScripting;

[Serializable]
[Inspectable]
public class IDefinedEventType
{
	[Inspectable]
	public Type type;

	public IDefinedEventType()
	{
	}

	public IDefinedEventType(Type type)
	{
		this.type = type;
	}

	public static implicit operator IDefinedEventType(Type type)
	{
		return new IDefinedEventType(type);
	}
}
