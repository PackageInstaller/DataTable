using System;
using MessagePack.Formatters;

namespace MessagePack.Resolvers;

public sealed class NativeDecimalResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			Formatter = (IMessagePackFormatter<T>)GetFormatterHelper(typeof(T));
		}
	}

	public static readonly NativeDecimalResolver Instance = new NativeDecimalResolver();

	private NativeDecimalResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}

	private static object GetFormatterHelper(Type t)
	{
		if (t == typeof(decimal))
		{
			return NativeDecimalFormatter.Instance;
		}
		if (t == typeof(decimal?))
		{
			return new StaticNullableFormatter<decimal>(NativeDecimalFormatter.Instance);
		}
		return null;
	}
}
