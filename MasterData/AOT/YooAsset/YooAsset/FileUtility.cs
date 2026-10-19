using System.IO;
using System.Text;

namespace YooAsset;

internal static class FileUtility
{
	public static string ReadAllText(string filePath)
	{
		if (!File.Exists(filePath))
		{
			return null;
		}
		return File.ReadAllText(filePath, Encoding.UTF8);
	}

	public static byte[] ReadAllBytes(string filePath)
	{
		if (!File.Exists(filePath))
		{
			return null;
		}
		return File.ReadAllBytes(filePath);
	}

	public static void WriteAllText(string filePath, string content)
	{
		CreateFileDirectory(filePath);
		byte[] bytes = Encoding.UTF8.GetBytes(content);
		File.WriteAllBytes(filePath, bytes);
	}

	public static void WriteAllBytes(string filePath, byte[] data)
	{
		CreateFileDirectory(filePath);
		File.WriteAllBytes(filePath, data);
	}

	public static void CreateFileDirectory(string filePath)
	{
		CreateDirectory(Path.GetDirectoryName(filePath));
	}

	public static void CreateDirectory(string directory)
	{
		if (!Directory.Exists(directory))
		{
			Directory.CreateDirectory(directory);
		}
	}

	public static long GetFileSize(string filePath)
	{
		return new FileInfo(filePath).Length;
	}
}
