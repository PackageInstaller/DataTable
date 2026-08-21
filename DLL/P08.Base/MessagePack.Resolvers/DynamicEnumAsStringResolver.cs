using System;
using System.Reflection;
using MessagePack.Formatters;
using MessagePack.Internal;

namespace MessagePack.Resolvers;

public sealed class DynamicEnumAsStringResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			TypeInfo typeInfo = typeof(T).GetTypeInfo();
			if (typeInfo.IsNullable())
			{
				typeInfo = typeInfo.GenericTypeArguments[0].GetTypeInfo();
				if (typeInfo.IsEnum)
				{
					object formatterDynamic = Instance.GetFormatterDynamic(typeInfo.AsType());
					if (formatterDynamic != null)
					{
						Formatter = (IMessagePackFormatter<T>)Activator.CreateInstance(typeof(StaticNullableFormatter<>).MakeGenericType(typeInfo.AsType()), formatterDynamic);
					}
				}
			}
			else if (typeInfo.IsEnum)
			{
				Formatter = new EnumAsStringFormatter<T>();
			}
		}
	}

	public static readonly DynamicEnumAsStringResolver Instance;

	public static readonly MessagePackSerializerOptions Options;

	static DynamicEnumAsStringResolver()
	{
		Instance = new DynamicEnumAsStringResolver();
		Options = new MessagePackSerializerOptions(Instance);
	}

	private DynamicEnumAsStringResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}
}
