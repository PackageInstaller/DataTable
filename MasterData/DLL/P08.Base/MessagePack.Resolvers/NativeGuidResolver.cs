using System;
using MessagePack.Formatters;

namespace MessagePack.Resolvers;

public sealed class NativeGuidResolver : IFormatterResolver
{
	private static class FormatterCache<T>
	{
		public static readonly IMessagePackFormatter<T> Formatter;

		static FormatterCache()
		{
			Formatter = (IMessagePackFormatter<T>)GetFormatterHelper(typeof(T));
		}
	}

	public static readonly NativeGuidResolver Instance = new NativeGuidResolver();

	private NativeGuidResolver()
	{
	}

	public IMessagePackFormatter<T> GetFormatter<T>()
	{
		return FormatterCache<T>.Formatter;
	}

	private static object GetFormatterHelper(Type t)
	{
		if (t == typeof(Guid))
		{
			return NativeGuidFormatter.Instance;
		}
		if (t == typeof(Guid?))
		{
			return new StaticNullableFormatter<Guid>(NativeGuidFormatter.Instance);
		}
		return null;
	}
}
