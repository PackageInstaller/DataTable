using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using UnityEngine;

public class FileTools
{
	public static List<string> filelist = new List<string>();

	public static string ReadFileText(string path, bool isUTF8 = false)
	{
		if (!File.Exists(path))
		{
			return "";
		}
		string text = "";
		if (isUTF8)
		{
			return File.ReadAllText(path, Encoding.UTF8);
		}
		return File.ReadAllText(path, Encoding.Default);
	}

	public static void CheckDirection(string path)
	{
		if (!Directory.Exists(path))
		{
			Directory.CreateDirectory(path);
		}
	}

	public static bool IsDirectoryExists(string path)
	{
		if (Directory.Exists(path))
		{
			return true;
		}
		return false;
	}

	public static bool IsFileExists(string path)
	{
		if (File.Exists(path))
		{
			return true;
		}
		return false;
	}

	public static List<string> GetSubFolders(string path)
	{
		if (!IsDirectoryExists(path))
		{
			return null;
		}
		DirectoryInfo[] directories = new DirectoryInfo(path).GetDirectories();
		List<string> list = new List<string>();
		if (directories.Length != 0)
		{
			for (int i = 0; i < directories.Length; i++)
			{
				list.Add(ChangePathFormat(directories[i].FullName));
			}
		}
		return list;
	}

	public static string ChangePathFormat(string path)
	{
		return path.Replace('\\', '/');
	}

	public static List<string> GetFilesNameList(string path, string exName)
	{
		List<string> list = new List<string>();
		FileInfo[] files = new DirectoryInfo(path).GetFiles();
		foreach (FileInfo fileInfo in files)
		{
			if (GetExName(fileInfo.FullName) == exName)
			{
				list.Add(fileInfo.Name);
			}
		}
		return list;
	}

	public static List<string> GetAllFilesExcept(string path, string exName)
	{
		List<string> list = new List<string>();
		DirectoryInfo directoryInfo = new DirectoryInfo(path);
		FileInfo[] files = directoryInfo.GetFiles();
		for (int i = 0; i < files.Length; i++)
		{
			if (!(GetExName(files[i].FullName) == exName))
			{
				list.Add(ChangePathFormat(files[i].FullName));
			}
		}
		DirectoryInfo[] directories = directoryInfo.GetDirectories();
		if (directories.Length != 0)
		{
			for (int j = 0; j < directories.Length; j++)
			{
				List<string> allFilesExcept = GetAllFilesExcept(directories[j].FullName, exName);
				if (allFilesExcept.Count > 0)
				{
					for (int k = 0; k < allFilesExcept.Count; k++)
					{
						list.Add(ChangePathFormat(allFilesExcept[k]));
					}
				}
			}
		}
		return list;
	}

	public static List<string> GetAllFilesExceptList(string path, List<string> exName)
	{
		List<string> list = new List<string>();
		DirectoryInfo directoryInfo = new DirectoryInfo(path);
		FileInfo[] files = directoryInfo.GetFiles();
		for (int i = 0; i < files.Length; i++)
		{
			string exName2 = GetExName(files[i].FullName);
			if (exName.IndexOf(exName2) < 0)
			{
				list.Add(StringTools.ChangePathFormat(files[i].FullName));
			}
		}
		DirectoryInfo[] directories = directoryInfo.GetDirectories();
		if (directories.Length != 0)
		{
			for (int j = 0; j < directories.Length; j++)
			{
				List<string> allFilesExceptList = GetAllFilesExceptList(directories[j].FullName, exName);
				if (allFilesExceptList.Count > 0)
				{
					for (int k = 0; k < allFilesExceptList.Count; k++)
					{
						list.Add(StringTools.ChangePathFormat(allFilesExceptList[k]));
					}
				}
			}
		}
		return list;
	}

	public static string GetExName(string str)
	{
		string regexStr = "(?<=\\\\[^\\\\]+.)[^\\\\.]+$|(?<=/[^/]+.)[^/.]+$";
		return StringTools.GetFirstMatch(str, regexStr);
	}

	public static string RemoveExName(string str)
	{
		return str.Substring(0, str.LastIndexOf("."));
	}

	public static string GetFileSize(string sFileFullName)
	{
		double num = new FileInfo(sFileFullName).Length;
		string[] array = new string[4] { "B", "KB", "MB", "GB" };
		int num2 = 0;
		while (num >= 1024.0 && num2 + 1 < array.Length)
		{
			num2++;
			num /= 1024.0;
		}
		return $"{num:0.##} {array[num2]}";
	}

	public static string GetParentPath(string path)
	{
		return Directory.GetParent(path).FullName;
	}

	public static long GetHttpLength(string url)
	{
		long result = 0L;
		try
		{
			HttpWebRequest obj = (HttpWebRequest)WebRequest.CreateDefault(new Uri(url));
			obj.Method = "HEAD";
			obj.Timeout = 5000;
			HttpWebResponse httpWebResponse = (HttpWebResponse)obj.GetResponse();
			if (httpWebResponse.StatusCode == HttpStatusCode.OK)
			{
				result = httpWebResponse.ContentLength;
			}
			httpWebResponse.Close();
			return result;
		}
		catch (WebException ex)
		{
			Debug.Log(ex.ToString());
			return 0L;
		}
	}

	public static void FolderDelete(string delFolderPath)
	{
		if (delFolderPath[delFolderPath.Length - 1] != Path.DirectorySeparatorChar)
		{
			string text = delFolderPath;
			char directorySeparatorChar = Path.DirectorySeparatorChar;
			delFolderPath = text + directorySeparatorChar;
		}
		string[] fileSystemEntries = Directory.GetFileSystemEntries(delFolderPath);
		foreach (string text2 in fileSystemEntries)
		{
			if (File.Exists(text2))
			{
				FileInfo fileInfo = new FileInfo(text2);
				if (fileInfo.Attributes.ToString().IndexOf("ReadOnly") != -1)
				{
					fileInfo.Attributes = FileAttributes.Normal;
				}
				File.Delete(text2);
			}
			else
			{
				FolderDelete(text2);
			}
		}
		Directory.Delete(delFolderPath);
	}

	public static void FolderCopy(string srcFolderPath, string destFolderPath)
	{
		if (destFolderPath[destFolderPath.Length - 1] != Path.DirectorySeparatorChar)
		{
			string text = destFolderPath;
			char directorySeparatorChar = Path.DirectorySeparatorChar;
			destFolderPath = text + directorySeparatorChar;
		}
		if (!Directory.Exists(destFolderPath))
		{
			Directory.CreateDirectory(destFolderPath);
		}
		string[] fileSystemEntries = Directory.GetFileSystemEntries(srcFolderPath);
		foreach (string text2 in fileSystemEntries)
		{
			if (Directory.Exists(text2))
			{
				FolderCopy(text2, destFolderPath + Path.GetFileName(text2));
				continue;
			}
			FileInfo fileInfo = new FileInfo(text2);
			if (!fileInfo.Name.EndsWith(".meta"))
			{
				if (fileInfo.Attributes.ToString().IndexOf("ReadOnly") != -1)
				{
					fileInfo.Attributes = FileAttributes.Normal;
				}
				try
				{
					File.Copy(text2, destFolderPath + Path.GetFileName(text2), overwrite: true);
				}
				catch (Exception message)
				{
					Debug.Log(message);
				}
			}
		}
	}

	public static void FolderMove(string srcFolderPath, string destFolderPath)
	{
		if (destFolderPath[destFolderPath.Length - 1] != Path.DirectorySeparatorChar)
		{
			string text = destFolderPath;
			char directorySeparatorChar = Path.DirectorySeparatorChar;
			destFolderPath = text + directorySeparatorChar;
		}
		if (!Directory.Exists(destFolderPath))
		{
			Directory.CreateDirectory(destFolderPath);
		}
		string[] fileSystemEntries = Directory.GetFileSystemEntries(srcFolderPath);
		foreach (string text2 in fileSystemEntries)
		{
			if (Directory.Exists(text2))
			{
				FolderMove(text2, destFolderPath + Path.GetFileName(text2));
			}
			else
			{
				File.Move(text2, destFolderPath + Path.GetFileName(text2));
			}
		}
		Directory.Delete(srcFolderPath);
	}

	public static List<string> GetAllDirectories(string rootPath)
	{
		string[] directories = Directory.GetDirectories(rootPath);
		for (int i = 0; i < directories.Length; i++)
		{
			GetAllDirectories(directories[i]);
		}
		directories = Directory.GetFiles(rootPath);
		foreach (string text in directories)
		{
			if (!text.EndsWith(".meta"))
			{
				filelist.Add(text);
			}
		}
		return filelist;
	}
}
