using System;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer;

public static class fsGlobalConfig
{
	public static bool SerializeDefaultValues = false;

	public static bool IsCaseSensitive = false;

	public static Type[] IgnoreSerializeAttributes = new Type[2]
	{
		typeof(NonSerializedAttribute),
		typeof(fsIgnoreAttribute)
	};

	public static Type[] SerializeAttributes = new Type[2]
	{
		typeof(SerializeField),
		typeof(fsSerializeAsAttribute)
	};

	public static string CustomDateTimeFormatString = null;

	public static bool Serialize64BitIntegerAsString = false;

	public static bool SerializeEnumsAsInteger = true;
}
