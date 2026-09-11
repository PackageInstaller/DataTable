using System;

namespace ParadoxNotion.Serialization.FullSerializer.Internal;

public static class fsTypeCache
{
	public static Type GetType(string name)
	{
		return GetType(name, fallbackNoNamespace: false, null);
	}

	public static Type GetType(string name, Type fallbackAssignable)
	{
		return GetType(name, fallbackNoNamespace: true, fallbackAssignable);
	}

	private static Type GetType(string name, bool fallbackNoNamespace, Type fallbackAssignable)
	{
		return ReflectionTools.GetType(name, fallbackNoNamespace, fallbackAssignable);
	}
}
