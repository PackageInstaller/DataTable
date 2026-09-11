using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Utilities/PlayerPrefs.h")]
public class PlayerPrefs
{
	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("SetInt")]
	private static extern bool TrySetInt(string key, int value);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("SetFloat")]
	private static extern bool TrySetFloat(string key, float value);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("SetString")]
	private static extern bool TrySetSetString(string key, string value);

	public static void SetInt(string key, int value)
	{
		if (!TrySetInt(key, value))
		{
			throw new PlayerPrefsException("Could not store preference value");
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern int GetInt(string key, int defaultValue);

	public static int GetInt(string key)
	{
		return GetInt(key, 0);
	}

	public static void SetFloat(string key, float value)
	{
		if (!TrySetFloat(key, value))
		{
			throw new PlayerPrefsException("Could not store preference value");
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern float GetFloat(string key, float defaultValue);

	public static float GetFloat(string key)
	{
		return GetFloat(key, 0f);
	}

	public static void SetString(string key, string value)
	{
		if (!TrySetSetString(key, value))
		{
			throw new PlayerPrefsException("Could not store preference value");
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern string GetString(string key, string defaultValue);

	public static string GetString(string key)
	{
		return GetString(key, "");
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool HasKey(string key);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void DeleteKey(string key);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("DeleteAllWithCallback")]
	public static extern void DeleteAll();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("Sync")]
	public static extern void Save();
}
