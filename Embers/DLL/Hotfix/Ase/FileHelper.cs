using System;
using System.Collections.Generic;
using System.IO;

namespace Ase;

public static class FileHelper
{
	public static List<string> GetAllFiles(string dir, string searchPattern = "*")
	{
		List<string> list = new List<string>();
		GetAllFiles(list, dir, searchPattern);
		return list;
	}

	public static void GetAllFiles(List<string> files, string dir, string searchPattern = "*")
	{
		string[] files2 = Directory.GetFiles(dir);
		foreach (string item in files2)
		{
			files.Add(item);
		}
		files2 = Directory.GetDirectories(dir);
		foreach (string dir2 in files2)
		{
			GetAllFiles(files, dir2, searchPattern);
		}
	}

	public static void CleanDirectory(string dir)
	{
		if (Directory.Exists(dir))
		{
			string[] directories = Directory.GetDirectories(dir);
			for (int i = 0; i < directories.Length; i++)
			{
				Directory.Delete(directories[i], recursive: true);
			}
			directories = Directory.GetFiles(dir);
			for (int i = 0; i < directories.Length; i++)
			{
				File.Delete(directories[i]);
			}
		}
	}

	public static void CopyDirectory(string srcDir, string tgtDir)
	{
		DirectoryInfo directoryInfo = new DirectoryInfo(srcDir);
		DirectoryInfo directoryInfo2 = new DirectoryInfo(tgtDir);
		if (directoryInfo2.FullName.StartsWith(directoryInfo.FullName, StringComparison.CurrentCultureIgnoreCase))
		{
			throw new Exception("父目录不能拷贝到子目录！");
		}
		if (directoryInfo.Exists)
		{
			if (!directoryInfo2.Exists)
			{
				directoryInfo2.Create();
			}
			FileInfo[] files = directoryInfo.GetFiles();
			for (int i = 0; i < files.Length; i++)
			{
				File.Copy(files[i].FullName, Path.Combine(directoryInfo2.FullName, files[i].Name), overwrite: true);
			}
			DirectoryInfo[] directories = directoryInfo.GetDirectories();
			for (int j = 0; j < directories.Length; j++)
			{
				CopyDirectory(directories[j].FullName, Path.Combine(directoryInfo2.FullName, directories[j].Name));
			}
		}
	}

	public static void ReplaceExtensionName(string srcDir, string extensionName, string newExtensionName)
	{
		if (!Directory.Exists(srcDir))
		{
			return;
		}
		string[] files = Directory.GetFiles(srcDir);
		foreach (string text in files)
		{
			if (text.EndsWith(extensionName))
			{
				File.Move(text, text.Substring(0, text.IndexOf(extensionName)) + newExtensionName);
				File.Delete(text);
			}
		}
		files = Directory.GetDirectories(srcDir);
		for (int i = 0; i < files.Length; i++)
		{
			ReplaceExtensionName(files[i], extensionName, newExtensionName);
		}
	}
}
