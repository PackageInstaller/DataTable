using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;

namespace UnityEngine.ResourceManagement.Util;

public static class ResourceManagerConfig
{
	public static bool ExtractKeyAndSubKey(object keyObj, out string mainKey, out string subKey)
	{
		if (keyObj is string text)
		{
			int num = text.IndexOf('[');
			if (num > 0)
			{
				int num2 = text.LastIndexOf(']');
				if (num2 > num)
				{
					mainKey = text.Substring(0, num);
					subKey = text.Substring(num + 1, num2 - (num + 1));
					return true;
				}
			}
		}
		mainKey = null;
		subKey = null;
		return false;
	}

	public static bool IsPathRemote(string path)
	{
		return path?.StartsWith("http", StringComparison.Ordinal) ?? false;
	}

	public static string StripQueryParameters(string path)
	{
		if (path != null)
		{
			int num = path.IndexOf('?');
			if (num >= 0)
			{
				return path.Substring(0, num);
			}
		}
		return path;
	}

	public static bool ShouldPathUseWebRequest(string path)
	{
		if (PlatformCanLoadLocallyFromUrlPath() && File.Exists(path))
		{
			return false;
		}
		return path?.Contains("://") ?? false;
	}

	private static bool PlatformCanLoadLocallyFromUrlPath()
	{
		return new List<RuntimePlatform> { RuntimePlatform.Android }.Contains(Application.platform);
	}

	public static Array CreateArrayResult(Type type, Object[] allAssets)
	{
		Type elementType = type.GetElementType();
		if (elementType == null)
		{
			return null;
		}
		int num = 0;
		Object[] array = allAssets;
		foreach (Object obj in array)
		{
			if (elementType.IsAssignableFrom(obj.GetType()))
			{
				num++;
			}
		}
		Array array2 = Array.CreateInstance(elementType, num);
		int num2 = 0;
		array = allAssets;
		foreach (Object obj2 in array)
		{
			if (elementType.IsAssignableFrom(obj2.GetType()))
			{
				array2.SetValue(obj2, num2++);
			}
		}
		return array2;
	}

	public static TObject CreateArrayResult<TObject>(Object[] allAssets) where TObject : class
	{
		return CreateArrayResult(typeof(TObject), allAssets) as TObject;
	}

	public static IList CreateListResult(Type type, Object[] allAssets)
	{
		Type[] genericArguments = type.GetGenericArguments();
		IList list = Activator.CreateInstance(typeof(List<>).MakeGenericType(genericArguments)) as IList;
		Type type2 = genericArguments[0];
		if (list == null)
		{
			return null;
		}
		foreach (Object obj in allAssets)
		{
			if (type2.IsAssignableFrom(obj.GetType()))
			{
				list.Add(obj);
			}
		}
		return list;
	}

	public static TObject CreateListResult<TObject>(Object[] allAssets)
	{
		return (TObject)CreateListResult(typeof(TObject), allAssets);
	}

	public static bool IsInstance<T1, T2>()
	{
		Type typeFromHandle = typeof(T1);
		return typeof(T2).IsAssignableFrom(typeFromHandle);
	}
}
