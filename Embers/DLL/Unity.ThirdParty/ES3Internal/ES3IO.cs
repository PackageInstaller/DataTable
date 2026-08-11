using System;
using System.IO;
using UnityEngine;

namespace ES3Internal;

public static class ES3IO
{
	public enum ES3FileMode
	{
		Read,
		Write,
		Append
	}

	internal static readonly string persistentDataPath = Application.persistentDataPath;

	internal static readonly string dataPath = Application.dataPath;

	internal const string backupFileSuffix = ".bac";

	internal const string temporaryFileSuffix = ".tmp";

	public static DateTime GetTimestamp(string filePath)
	{
		if (!FileExists(filePath))
		{
			return new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
		}
		return File.GetLastWriteTime(filePath).ToUniversalTime();
	}

	public static string GetExtension(string path)
	{
		return Path.GetExtension(path);
	}

	public static void DeleteFile(string filePath)
	{
		if (FileExists(filePath))
		{
			File.Delete(filePath);
		}
	}

	public static bool FileExists(string filePath)
	{
		return File.Exists(filePath);
	}

	public static void MoveFile(string sourcePath, string destPath)
	{
		File.Move(sourcePath, destPath);
	}

	public static void CopyFile(string sourcePath, string destPath)
	{
		File.Copy(sourcePath, destPath);
	}

	public static void MoveDirectory(string sourcePath, string destPath)
	{
		Directory.Move(sourcePath, destPath);
	}

	public static void CreateDirectory(string directoryPath)
	{
		Directory.CreateDirectory(directoryPath);
	}

	public static bool DirectoryExists(string directoryPath)
	{
		return Directory.Exists(directoryPath);
	}

	public static string GetDirectoryPath(string path, char seperator = '/')
	{
		char value = (UsesForwardSlash(path) ? '/' : '\\');
		int num = path.LastIndexOf(value);
		if (num == path.Length - 1)
		{
			return path;
		}
		if (num == path.Length - 1)
		{
			num = path.Substring(0, num).LastIndexOf(value);
		}
		if (num == -1)
		{
			ES3Debug.LogError("Path provided is not a directory path as it contains no slashes.");
		}
		return path.Substring(0, num);
	}

	public static bool UsesForwardSlash(string path)
	{
		if (path.Contains("/"))
		{
			return true;
		}
		return false;
	}

	public static string CombinePathAndFilename(string directoryPath, string fileOrDirectoryName)
	{
		if (directoryPath[directoryPath.Length - 1] != '/' && directoryPath[directoryPath.Length - 1] != '\\')
		{
			directoryPath += "/";
		}
		return directoryPath + fileOrDirectoryName;
	}

	public static string[] GetDirectories(string path, bool getFullPaths = true)
	{
		string[] directories = Directory.GetDirectories(path);
		for (int i = 0; i < directories.Length; i++)
		{
			if (!getFullPaths)
			{
				directories[i] = Path.GetFileName(directories[i]);
			}
			directories[i].Replace("\\", "/");
		}
		return directories;
	}

	public static void DeleteDirectory(string directoryPath)
	{
		if (DirectoryExists(directoryPath))
		{
			Directory.Delete(directoryPath, recursive: true);
		}
	}

	public static string[] GetFiles(string path, bool getFullPaths = true)
	{
		string[] files = Directory.GetFiles(GetDirectoryPath(path));
		if (!getFullPaths)
		{
			for (int i = 0; i < files.Length; i++)
			{
				files[i] = Path.GetFileName(files[i]);
			}
		}
		return files;
	}

	public static byte[] ReadAllBytes(string path)
	{
		return File.ReadAllBytes(path);
	}

	public static void WriteAllBytes(string path, byte[] bytes)
	{
		File.WriteAllBytes(path, bytes);
	}

	public static void CommitBackup(ES3Settings settings)
	{
		ES3Debug.Log("Committing backup for " + settings.path + " to storage location " + settings.location);
		string text = settings.FullPath + ".tmp";
		if (settings.location == ES3.Location.File)
		{
			string text2 = settings.FullPath + ".tmp.bak";
			if (FileExists(settings.FullPath))
			{
				DeleteFile(text2);
				CopyFile(settings.FullPath, text2);
				try
				{
					DeleteFile(settings.FullPath);
					MoveFile(text, settings.FullPath);
				}
				catch (Exception ex)
				{
					try
					{
						DeleteFile(settings.FullPath);
					}
					catch
					{
					}
					MoveFile(text2, settings.FullPath);
					throw ex;
				}
				DeleteFile(text2);
			}
			else
			{
				MoveFile(text, settings.FullPath);
			}
		}
		else if (settings.location == ES3.Location.PlayerPrefs)
		{
			PlayerPrefs.SetString(settings.FullPath, PlayerPrefs.GetString(text));
			PlayerPrefs.DeleteKey(text);
			PlayerPrefs.Save();
		}
	}
}
