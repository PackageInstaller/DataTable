using System;
using System.Reflection;
using MessagePack.Formatters;
using MessagePack.Internal;

namespace MessagePack.Resolvers;

public sealed class DynamicObjectResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

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
				TypeInfo typeInfo2;
				try
				{
					typeInfo2 = DynamicObjectTypeBuilder.BuildType(DynamicAssembly.Value, typeof(T), forceStringKey: false, contractless: false);
				}
				catch (InitAccessorInGenericClassNotSupportedException)
				{
					Formatter = (IMessagePackFormatter<T>)DynamicObjectTypeBuilder.BuildFormatterToDynamicMethod(typeof(T), forceStringKey: false, contractless: false, allowPrivate: false);
					return;
				}
				if (!(typeInfo2 == null))
				{
					Formatter = (IMessagePackFormatter<T>)Activator.CreateInstance(typeInfo2.AsType());
				}
			}
		}
	}

	private const string ModuleName = "MessagePack.Resolvers.DynamicObjectResolver";

	public static readonly DynamicObjectResolver Instance;

	public static readonly MessagePackSerializerOptions Options;

	internal static readonly Lazy<DynamicAssembly> DynamicAssembly;

	static DynamicObjectResolver()
	{
		Instance = new DynamicObjectResolver();
		Options = new MessagePackSerializerOptions(Instance);
		DynamicAssembly = new Lazy<DynamicAssembly>(() => new DynamicAssembly("MessagePack.Resolvers.DynamicObjectResolver"));
	}

	private DynamicObjectResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}
}
