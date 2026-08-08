using System;

namespace MessagePack;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Interface, AllowMultiple = false, Inherited = true)]
public class MessagePackFormatterAttribute : Attribute
{
	public Type FormatterType { get; private set; }

	public object[] Arguments { get; private set; }

	public MessagePackFormatterAttribute(Type formatterType)
	{
		FormatterType = formatterType;
	}

	public MessagePackFormatterAttribute(Type formatterType, params object[] arguments)
	{
		FormatterType = formatterType;
		Arguments = arguments;
	}
}
