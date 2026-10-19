using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace Unity.VisualScripting;

public static class EnumUtility
{
	public static bool HasFlag(this Enum value, Enum flag)
	{
		long num = Convert.ToInt64(value);
		long num2 = Convert.ToInt64(flag);
		return (num & num2) == num2;
	}

	public static Dictionary<string, Enum> ValuesByNames(Type enumType, bool obsolete = false)
	{
		Ensure.That("enumType").IsNotNull(enumType);
		IEnumerable<FieldInfo> source = enumType.GetFields(BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
		if (!obsolete)
		{
			source = source.Where((FieldInfo f) => !f.IsDefined(typeof(ObsoleteAttribute), inherit: false));
		}
		return source.ToDictionary((FieldInfo f) => f.Name, (FieldInfo f) => (Enum)f.GetValue(null));
	}

	public static Dictionary<string, T> ValuesByNames<T>(bool obsolete = false)
	{
		IEnumerable<FieldInfo> source = typeof(T).GetFields(BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
		if (!obsolete)
		{
			source = source.Where((FieldInfo f) => !f.IsDefined(typeof(ObsoleteAttribute), inherit: false));
		}
		return source.ToDictionary((FieldInfo f) => f.Name, (FieldInfo f) => (T)f.GetValue(null));
	}
}
