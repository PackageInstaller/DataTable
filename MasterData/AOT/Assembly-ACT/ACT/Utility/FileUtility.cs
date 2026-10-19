using System.IO;
using System.Text;
using System.Threading.Tasks;

namespace ACT.Utility;

public static class FileUtility
{
	public static void DeleteEmptyDirectories(string parentDirectory)
	{
		string[] directories = Directory.GetDirectories(parentDirectory);
		foreach (string text in directories)
		{
			if (Directory.GetFileSystemEntries(text).Length == 0)
			{
				Directory.Delete(text);
			}
			else
			{
				DeleteEmptyDirectories(text);
			}
		}
	}

	public static async Task WriteFileAsync(string filePath, string content)
	{
		using FileStream fileStream = new FileStream(filePath, FileMode.Create, FileAccess.Write, FileShare.None, 4096, useAsync: true);
		byte[] bytes = Encoding.UTF8.GetBytes(content);
		await fileStream.WriteAsync(bytes, 0, bytes.Length);
	}

	public static string FormatFileSize(long bytes, bool useDecimal = false, int decimalPlaces = 1)
	{
		if (bytes < 0)
		{
			return "0 B";
		}
		int num = (useDecimal ? 1000 : 1024);
		string[] array = ((!useDecimal) ? new string[6] { "B", "KB", "MB", "GB", "TB", "PB" } : new string[6] { "B", "KB", "MB", "GB", "TB", "PB" });
		if (bytes == 0L)
		{
			return "0 " + array[0];
		}
		int num2 = 0;
		double num3 = bytes;
		while (num3 >= (double)num && num2 < array.Length - 1)
		{
			num3 /= (double)num;
			num2++;
		}
		string text = $"F{decimalPlaces}";
		return num3.ToString(text) + " " + array[num2];
	}

	public static string FormatFileSize(long bytes)
	{
		return FormatFileSize(bytes, false, 1);
	}

	public static string FormatFileSizeFromKB(double kilobytes, bool useDecimal = false, int decimalPlaces = 1)
	{
		return FormatFileSize((long)(kilobytes * 1024.0), useDecimal, decimalPlaces);
	}
}
