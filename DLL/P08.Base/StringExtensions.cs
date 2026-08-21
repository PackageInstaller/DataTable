using System;
using System.IO;
using UnityEngine;

public static class StringExtensions
{
	public static bool AlmostEquals(this float value1, float value2, float precision = 1E-07f)
	{
		return Math.Abs(value1 - value2) <= precision;
	}

	public static bool AlmostZero(this float value, float precision = 1E-07f)
	{
		return Math.Abs(value) <= precision;
	}

	public static string FormatWith(this string text, object arg0)
	{
		return string.Format(text, arg0);
	}

	public static string FormatWith(this string text, params object[] args)
	{
		return string.Format(text, args);
	}

	public static string FormatWith(this string text, IFormatProvider provider, params object[] args)
	{
		return string.Format(provider, text, args);
	}

	public static string FormatWith(this string text, object arg0, object arg1)
	{
		return string.Format(text, arg0, arg1);
	}

	public static string FormatWith(this string text, object arg0, object arg1, object arg2)
	{
		return string.Format(text, arg0, arg1, arg2);
	}

	public static bool IsEmpty(this Rect rect)
	{
		if (rect.x.AlmostZero() && rect.y.AlmostZero() && rect.height.AlmostZero())
		{
			return rect.width.AlmostZero();
		}
		return false;
	}

	public static bool IsNotNullOrEmpty(this string input)
	{
		return !string.IsNullOrEmpty(input);
	}

	public static string NormalizePath(this string path)
	{
		if (string.IsNullOrEmpty(path))
		{
			return string.Empty;
		}
		try
		{
			path = Path.GetFullPath(new Uri(path).LocalPath);
		}
		catch (UriFormatException)
		{
			Debug.LogError($"Invalid system path: \"{path}\"");
			return string.Empty;
		}
		return path.TrimEnd(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
	}

	public static string RelativeAssetPath(this string path)
	{
		return path.Replace('\\', '/').Replace(Application.dataPath, "Assets");
	}

	public static string RelativeProjectPath(this string path)
	{
		int length = Application.dataPath.LastIndexOf("/Assets", StringComparison.Ordinal);
		string text = Application.dataPath.Substring(0, length);
		text = text.Substring(0, text.LastIndexOf("/", StringComparison.Ordinal) + 1);
		return path.Replace('\\', '/').Replace(text, string.Empty);
	}

	public static string ReplaceFirst(this string value, string oldValue, string newValue, StringComparison comparison = StringComparison.Ordinal)
	{
		int num = value.IndexOf(oldValue, comparison);
		if (num != -1)
		{
			return value.Remove(num, oldValue.Length).Insert(num, newValue);
		}
		return value;
	}

	public static string ReplaceLast(this string value, string oldValue, string newValue, StringComparison comparison = StringComparison.Ordinal)
	{
		int num = value.LastIndexOf(oldValue, comparison);
		if (num != -1)
		{
			return value.Remove(num, oldValue.Length).Insert(num, newValue);
		}
		return value;
	}

	public static bool? ToBoolean(this string value)
	{
		if (string.Compare("T", value, StringComparison.OrdinalIgnoreCase) == 0)
		{
			return true;
		}
		if (string.Compare("F", value, StringComparison.OrdinalIgnoreCase) == 0)
		{
			return false;
		}
		if (bool.TryParse(value, out var result))
		{
			return result;
		}
		return null;
	}

	public static T ToEnum<T>(this string value) where T : struct, IConvertible
	{
		return value.ToEnum<T>(ignoreCase: false);
	}

	public static T ToEnum<T>(this string value, bool ignoreCase) where T : struct, IConvertible
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		value = value.Trim();
		if (value.Length == 0)
		{
			throw new ArgumentNullException("value", "Must specify valid information for parsing in the string.");
		}
		Type typeFromHandle = typeof(T);
		if (!typeFromHandle.IsEnum)
		{
			throw new ArgumentException("T must be an enumerated type.");
		}
		return (T)Enum.Parse(typeFromHandle, value, ignoreCase);
	}

	public static string ValueOrDefault(this string value, string defaultvalue)
	{
		return value ?? defaultvalue;
	}

	public static string ValueOrEmpty(this string value)
	{
		return value.ValueOrDefault(string.Empty);
	}
}
