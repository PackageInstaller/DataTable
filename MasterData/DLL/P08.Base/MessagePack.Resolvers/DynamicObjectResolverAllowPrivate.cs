using System;
using System.Reflection;
using MessagePack.Formatters;
using MessagePack.Internal;

namespace MessagePack.Resolvers;

public sealed class DynamicObjectResolverAllowPrivate : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		internal static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			TypeInfo typeInfo = typeof(T).GetTypeInfo();
			if (typeInfo.IsInterface || typeInfo.IsAbstract)
			{
				return;
			}
			if (typeInfo.IsNullable())
			{
				typeInfo = typeInfo.GenericTypeArguments[0].GetTypeInfo();
				object formatterDynamic = Instance.GetFormatterDynamic(typeInfo.AsType());
				if (formatterDynamic != null)
				{
					Formatter = (IMessagePackFormatter<T>)Activator.CreateInstance(typeof(StaticNullableFormatter<>).MakeGenericType(typeInfo.AsType()), formatterDynamic);
				}
			}
			else if (typeInfo.IsAnonymous())
			{
				Formatter = (IMessagePackFormatter<T>)DynamicObjectTypeBuilder.BuildFormatterToDynamicMethod(typeof(T), forceStringKey: true, contractless: true, allowPrivate: false);
			}
			else
			{
				Formatter = (IMessagePackFormatter<T>)DynamicObjectTypeBuilder.BuildFormatterToDynamicMethod(typeof(T), forceStringKey: false, contractless: false, allowPrivate: true);
			}
		}
	}

	public static readonly DynamicObjectResolverAllowPrivate Instance = new DynamicObjectResolverAllowPrivate();

	private DynamicObjectResolverAllowPrivate()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}
}
