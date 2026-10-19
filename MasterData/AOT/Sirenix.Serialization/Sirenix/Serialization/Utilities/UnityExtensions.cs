using System;
using System.Reflection;
using UnityEngine;

namespace Sirenix.Serialization.Utilities;

internal static class UnityExtensions
{
	private static readonly ValueGetter<UnityEngine.Object, IntPtr> UnityObjectCachedPtrFieldGetter;

	static UnityExtensions()
	{
		FieldInfo field = typeof(UnityEngine.Object).GetField("m_CachedPtr", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		if (field != null)
		{
			UnityObjectCachedPtrFieldGetter = EmitUtilities.CreateInstanceFieldGetter<UnityEngine.Object, IntPtr>(field);
		}
	}

	public static bool SafeIsUnityNull(this UnityEngine.Object obj)
	{
		if ((object)obj == null)
		{
			return true;
		}
		if (UnityObjectCachedPtrFieldGetter == null)
		{
			throw new NotSupportedException("Could not find the field 'm_CachedPtr' in the class UnityEngine.Object; cannot perform a special null check.");
		}
		IntPtr intPtr = UnityObjectCachedPtrFieldGetter(ref obj);
		return intPtr == IntPtr.Zero;
	}
}
