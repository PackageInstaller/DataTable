using System;
using System.IO;
using System.Text;

namespace Sirenix.Utilities;

public static class PathUtilities
{
	public static string GetDirectoryName(string x)
	{
		if (x == null)
		{
			return null;
		}
		return Path.GetDirectoryName(x).Replace("\\", "/");
	}

	public static bool HasSubDirectory(this DirectoryInfo parentDir, DirectoryInfo subDir)
	{
		string text = parentDir.FullName.TrimEnd('\\', '/');
		while (subDir != null)
		{
			if (subDir.FullName.TrimEnd('\\', '/') == text)
			{
				return true;
			}
			subDir = subDir.Parent;
		}
		return false;
	}

	public static DirectoryInfo FindParentDirectoryWithName(this DirectoryInfo dir, string folderName)
	{
		if (dir.Parent == null)
		{
			return null;
		}
		if (string.Equals(dir.Name, folderName, StringComparison.InvariantCultureIgnoreCase))
		{
			return dir;
		}
		return dir.Parent.FindParentDirectoryWithName(folderName);
	}

	public static bool CanMakeRelative(string absoluteParentPath, string absolutePath)
	{
		if (absoluteParentPath == null)
		{
			throw new ArgumentNullException("absoluteParentPath");
		}
		if (absolutePath == null)
		{
			throw new ArgumentNullException("absoluteParentPath");
		}
		absoluteParentPath = absoluteParentPath.Replace('\\', '/').Trim(new char[1] { '/' });
		absolutePath = absolutePath.Replace('\\', '/').Trim(new char[1] { '/' });
		return Path.GetPathRoot(absoluteParentPath).Equals(Path.GetPathRoot(absolutePath), StringComparison.CurrentCultureIgnoreCase);
	}

	public static string MakeRelative(string absoluteParentPath, string absolutePath)
	{
		absoluteParentPath = absoluteParentPath.TrimEnd('\\', '/');
		absolutePath = absolutePath.TrimEnd('\\', '/');
		string[] array = absoluteParentPath.Split('/', '\\');
		string[] array2 = absolutePath.Split('/', '\\');
		int num = -1;
		for (int i = 0; i < array.Length && i < array2.Length && array[i].Equals(array2[i], StringComparison.CurrentCultureIgnoreCase); i++)
		{
			num = i;
		}
		if (num == -1)
		{
			throw new InvalidOperationException("No common directory found.");
		}
		StringBuilder stringBuilder = new StringBuilder();
		if (num + 1 < array.Length)
		{
			for (int j = num + 1; j < array.Length; j++)
			{
				if (stringBuilder.Length > 0)
				{
					stringBuilder.Append('/');
				}
				stringBuilder.Append("..");
			}
		}
		for (int k = num + 1; k < array2.Length; k++)
		{
			if (stringBuilder.Length > 0)
			{
				stringBuilder.Append('/');
			}
			stringBuilder.Append(array2[k]);
		}
		return stringBuilder.ToString();
	}

	public static bool TryMakeRelative(string absoluteParentPath, string absolutePath, out string relativePath)
	{
		if (CanMakeRelative(absoluteParentPath, absolutePath))
		{
			relativePath = MakeRelative(absoluteParentPath, absolutePath);
			return true;
		}
		relativePath = null;
		return false;
	}

	public static string Combine(string a, string b)
	{
		a = a.Replace("\\", "/").TrimEnd(new char[1] { '/' });
		b = b.Replace("\\", "/").TrimStart(new char[1] { '/' });
		return a + "/" + b;
	}
}
