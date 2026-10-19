using System.IO;

namespace Sirenix.Serialization.Utilities;

internal static class PathUtilities
{
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
}
