using System;

namespace YooAsset;

internal static class PathUtility
{
	public static string RegularPath(string path)
	{
		return path.Replace('\\', '/').Replace("\\", "/");
	}

	public static string RemoveExtension(string str)
	{
		if (string.IsNullOrEmpty(str))
		{
			return str;
		}
		int num = str.LastIndexOf('.');
		if (num == -1)
		{
			return str;
		}
		return str.Remove(num);
	}

	public static bool HasDoubleSlashes(string url)
	{
		if (url == null)
		{
			throw new ArgumentNullException();
		}
		int num = url.IndexOf("://");
		string text = ((num == -1) ? url : url.Substring(num + 3));
		if (!text.Contains("//"))
		{
			return text.Contains("\\\\");
		}
		return true;
	}

	public static string Combine(string path1, string path2)
	{
		return StringUtility.Format("{0}/{1}", path1, path2);
	}

	public static string Combine(string path1, string path2, string path3)
	{
		return StringUtility.Format("{0}/{1}/{2}", path1, path2, path3);
	}

	public static string Combine(string path1, string path2, string path3, string path4)
	{
		return StringUtility.Format("{0}/{1}/{2}/{3}", path1, path2, path3, path4);
	}
}
