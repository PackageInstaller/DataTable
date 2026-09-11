using System;
using System.Collections.Generic;
using UnityEngine;

namespace MessagePack.Unity.Extension;

internal static class UnityBlitResolverGetFormatterHelper
{
	private static readonly Dictionary<Type, Type> FormatterMap = new Dictionary<Type, Type>
	{
		{
			typeof(Vector2[]),
			typeof(Vector2ArrayBlitFormatter)
		},
		{
			typeof(Vector3[]),
			typeof(Vector3ArrayBlitFormatter)
		},
		{
			typeof(Vector4[]),
			typeof(Vector4ArrayBlitFormatter)
		},
		{
			typeof(Quaternion[]),
			typeof(QuaternionArrayBlitFormatter)
		},
		{
			typeof(Color[]),
			typeof(ColorArrayBlitFormatter)
		},
		{
			typeof(Bounds[]),
			typeof(BoundsArrayBlitFormatter)
		},
		{
			typeof(Rect[]),
			typeof(RectArrayBlitFormatter)
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
