using System;
using MessagePack.Formatters;

namespace MessagePack.Internal;

internal static class NativeDateTimeResolverGetFormatterHelper
{
	internal static object GetFormatter(Type t)
	{
		if (t == typeof(DateTime))
		{
			return NativeDateTimeFormatter.Instance;
		}
		if (t == typeof(DateTime?))
		{
			return new StaticNullableFormatter<DateTime>(NativeDateTimeFormatter.Instance);
		}
		if (t == typeof(DateTime[]))
		{
			return NativeDateTimeArrayFormatter.Instance;
		}
		return null;
	}
}
