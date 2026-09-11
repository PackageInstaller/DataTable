using System;
using System.Linq;
using MessagePack.Formatters;

namespace MessagePack.Resolvers;

public sealed class AttributeFormatterResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			MessagePackFormatterAttribute messagePackFormatterAttribute = (MessagePackFormatterAttribute)typeof(T).GetCustomAttributes(typeof(MessagePackFormatterAttribute), inherit: true).FirstOrDefault();
			if (messagePackFormatterAttribute != null)
			{
				Type type = messagePackFormatterAttribute.FormatterType;
				if (type.IsGenericType && !type.IsConstructedGenericType)
				{
					type = type.MakeGenericType(typeof(T).GetGenericArguments());
				}
				if (messagePackFormatterAttribute.Arguments == null)
				{
					Formatter = (IMessagePackFormatter<T>)Activator.CreateInstance(type);
				}
				else
				{
					Formatter = (IMessagePackFormatter<T>)Activator.CreateInstance(type, messagePackFormatterAttribute.Arguments);
				}
			}
		}
	}

	public static readonly AttributeFormatterResolver Instance = new AttributeFormatterResolver();

	private AttributeFormatterResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}
}
