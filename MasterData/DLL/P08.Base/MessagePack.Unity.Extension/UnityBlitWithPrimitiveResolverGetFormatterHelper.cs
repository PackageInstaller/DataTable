using System;
using System.Collections.Generic;

namespace MessagePack.Unity.Extension;

internal static class UnityBlitWithPrimitiveResolverGetFormatterHelper
{
	private static readonly Dictionary<Type, Type> FormatterMap = new Dictionary<Type, Type>
	{
		{
			typeof(int[]),
			typeof(IntArrayBlitFormatter)
		},
		{
			typeof(float[]),
			typeof(FloatArrayBlitFormatter)
		},
		{
			typeof(double[]),
			typeof(DoubleArrayBlitFormatter)
		}
	};

	internal static object GetFormatter(Type t)
	{
		if (FormatterMap.TryGetValue(t, out var value))
		{
			return Activator.CreateInstance(value);
		}
		return null;
	}
}
