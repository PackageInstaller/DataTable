using System.Collections.Generic;
using System.IO.Enumeration;
using System.Security.AccessControl;

namespace System.IO;

public static class Directory
{
	public static DirectoryInfo GetParent(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Path cannot be the empty string or all whitespace.", "path");
		}
		string directoryName = Path.GetDirectoryName(Path.GetFullPath(path));
		if (directoryName == null)
		{
			return null;
		}
		return new DirectoryInfo(directoryName);
	}

	public static DirectoryInfo CreateDirectory(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Path cannot be the empty string or all whitespace.", "path");
		}
		string fullPath = Path.GetFullPath(path);
		FileSystem.CreateDirectory(fullPath);
		return new DirectoryInfo(fullPath, null, null, false);
	}

	public static bool Exists(string path)
	{
		try
		{
			if (path == null)
			{
				return false;
			}
			if (path.Length == 0)
			{
				return false;
			}
			return FileSystem.DirectoryExists(Path.GetFullPath(path));
		}
		catch (ArgumentException)
		{
		}
		catch (IOException)
		{
		}
		catch (UnauthorizedAccessException)
		{
		}
		return false;
	}

	public static void SetCreationTime(string path, DateTime creationTime)
	{
		FileSystem.SetCreationTime(Path.GetFullPath(path), creationTime, asDirectory: true);
	}

	public static void SetCreationTimeUtc(string path, DateTime creationTimeUtc)
	{
		FileSystem.SetCreationTime(Path.GetFullPath(path), File.GetUtcDateTimeOffset(creationTimeUtc), asDirectory: true);
	}

	public static DateTime GetCreationTime(string path)
	{
		return File.GetCreationTime(path);
	}

	public static DateTime GetCreationTimeUtc(string path)
	{
		return File.GetCreationTimeUtc(path);
	}

	public static void SetLastWriteTime(string path, DateTime lastWriteTime)
	{
		FileSystem.SetLastWriteTime(Path.GetFullPath(path), lastWriteTime, asDirectory: true);
	}

	public static void SetLastWriteTimeUtc(string path, DateTime lastWriteTimeUtc)
	{
		FileSystem.SetLastWriteTime(Path.GetFullPath(path), File.GetUtcDateTimeOffset(lastWriteTimeUtc), asDirectory: true);
	}

	public static DateTime GetLastWriteTime(string path)
	{
		return File.GetLastWriteTime(path);
	}

	public static DateTime GetLastWriteTimeUtc(string path)
	{
		return File.GetLastWriteTimeUtc(path);
	}

	public static void SetLastAccessTime(string path, DateTime lastAccessTime)
	{
		FileSystem.SetLastAccessTime(Path.GetFullPath(path), lastAccessTime, asDirectory: true);
	}

	public static void SetLastAccessTimeUtc(string path, DateTime lastAccessTimeUtc)
	{
		FileSystem.SetLastAccessTime(Path.GetFullPath(path), File.GetUtcDateTimeOffset(lastAccessTimeUtc), asDirectory: true);
	}

	public static DateTime GetLastAccessTime(string path)
	{
		return File.GetLastAccessTime(path);
	}

	public static DateTime GetLastAccessTimeUtc(string path)
	{
		return File.GetLastAccessTimeUtc(path);
	}

	public static string[] GetFiles(string path)
	{
		return GetFiles(path, "*", EnumerationOptions.Compatible);
	}

	public static string[] GetFiles(string path, string searchPattern)
	{
		return GetFiles(path, searchPattern, EnumerationOptions.Compatible);
	}

	public static string[] GetFiles(string path, string searchPattern, SearchOption searchOption)
	{
		return GetFiles(path, searchPattern, EnumerationOptions.FromSearchOption(searchOption));
	}

	public static string[] GetFiles(string path, string searchPattern, EnumerationOptions enumerationOptions)
	{
		return InternalEnumeratePaths(path, searchPattern, SearchTarget.Files, enumerationOptions).ToArray();
	}

	public static string[] GetDirectories(string path)
	{
		return GetDirectories(path, "*", EnumerationOptions.Compatible);
	}

	public static string[] GetDirectories(string path, string searchPattern)
	{
		return GetDirectories(path, searchPattern, EnumerationOptions.Compatible);
	}

	public static string[] GetDirectories(string path, string searchPattern, SearchOption searchOption)
	{
		return GetDirectories(path, searchPattern, EnumerationOptions.FromSearchOption(searchOption));
	}

	public static string[] GetDirectories(string path, string searchPattern, EnumerationOptions enumerationOptions)
	{
		return InternalEnumeratePaths(path, searchPattern, SearchTarget.Directories, enumerationOptions).ToArray();
	}

	public static string[] GetFileSystemEntries(string path)
	{
		return GetFileSystemEntries(path, "*", EnumerationOptions.Compatible);
	}

	public static string[] GetFileSystemEntries(string path, string searchPattern)
	{
		return GetFileSystemEntries(path, searchPattern, EnumerationOptions.Compatible);
	}

	public static string[] GetFileSystemEntries(string path, string searchPattern, SearchOption searchOption)
	{
		return GetFileSystemEntries(path, searchPattern, EnumerationOptions.FromSearchOption(searchOption));
	}

	public static string[] GetFileSystemEntries(string path, string searchPattern, EnumerationOptions enumerationOptions)
	{
		return InternalEnumeratePaths(path, searchPattern, SearchTarget.Both, enumerationOptions).ToArray();
	}

	internal static IEnumerable<string> InternalEnumeratePaths(string path, string searchPattern, SearchTarget searchTarget, EnumerationOptions options)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (searchPattern == null)
		{
			throw new ArgumentNullException("searchPattern");
		}
		FileSystemEnumerableFactory.NormalizeInputs(ref path, ref searchPattern, options);
		return searchTarget switch
		{
			SearchTarget.Files => FileSystemEnumerableFactory.UserFiles(path, searchPattern, options), 
			SearchTarget.Directories => FileSystemEnumerableFactory.UserDirectories(path, searchPattern, options), 
			SearchTarget.Both => FileSystemEnumerableFactory.UserEntries(path, searchPattern, options), 
			_ => throw new ArgumentOutOfRangeException("searchTarget"), 
		};
	}

	public static IEnumerable<string> EnumerateDirectories(string path)
	{
		return EnumerateDirectories(path, "*", EnumerationOptions.Compatible);
	}

	public static IEnumerable<string> EnumerateDirectories(string path, string searchPattern)
	{
		return EnumerateDirectories(path, searchPattern, EnumerationOptions.Compatible);
	}

	public static IEnumerable<string> EnumerateDirectories(string path, string searchPattern, SearchOption searchOption)
	{
		return EnumerateDirectories(path, searchPattern, EnumerationOptions.FromSearchOption(searchOption));
	}

	public static IEnumerable<string> EnumerateDirectories(string path, string searchPattern, EnumerationOptions enumerationOptions)
	{
		return InternalEnumeratePaths(path, searchPattern, SearchTarget.Directories, enumerationOptions);
	}

	public static IEnumerable<string> EnumerateFiles(string path)
	{
		return EnumerateFiles(path, "*", EnumerationOptions.Compatible);
	}

	public static IEnumerable<string> EnumerateFiles(string path, string searchPattern)
	{
		return EnumerateFiles(path, searchPattern, EnumerationOptions.Compatible);
	}

	public static IEnumerable<string> EnumerateFiles(string path, string searchPattern, SearchOption searchOption)
	{
		return EnumerateFiles(path, searchPattern, EnumerationOptions.FromSearchOption(searchOption));
	}

	public static IEnumerable<string> EnumerateFiles(string path, string searchPattern, EnumerationOptions enumerationOptions)
	{
		return InternalEnumeratePaths(path, searchPattern, SearchTarget.Files, enumerationOptions);
	}

	public static IEnumerable<string> EnumerateFileSystemEntries(string path)
	{
		return EnumerateFileSystemEntries(path, "*", EnumerationOptions.Compatible);
	}

	public static IEnumerable<string> EnumerateFileSystemEntries(string path, string searchPattern)
	{
		return EnumerateFileSystemEntries(path, searchPattern, EnumerationOptions.Compatible);
	}

	public static IEnumerable<string> EnumerateFileSystemEntries(string path, string searchPattern, SearchOption searchOption)
	{
		return EnumerateFileSystemEntries(path, searchPattern, EnumerationOptions.FromSearchOption(searchOption));
	}

	public static IEnumerable<string> EnumerateFileSystemEntries(string path, string searchPattern, EnumerationOptions enumerationOptions)
	{
		return InternalEnumeratePaths(path, searchPattern, SearchTarget.Both, enumerationOptions);
	}

	public static string GetDirectoryRoot(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		string fullPath = Path.GetFullPath(path);
		return fullPath.Substring(0, PathInternal.GetRootLength(fullPath));
	}

	internal static string InternalGetDirectoryRoot(string path)
	{
		return path?.Substring(0, PathInternal.GetRootLength(path));
	}

	public static string GetCurrentDirectory()
	{
		return Environment.CurrentDirectory;
	}

	public static void SetCurrentDirectory(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (path.Length == 0)
		{
			throw new ArgumentException("Path cannot be the empty string or all whitespace.", "path");
		}
		Environment.CurrentDirectory = Path.GetFullPath(path);
	}

	public static void Move(string sourceDirName, string destDirName)
	{
		if (sourceDirName == null)
		{
			throw new ArgumentNullException("sourceDirName");
		}
		if (sourceDirName.Length == 0)
		{
			throw new ArgumentException("Empty file name is not legal.", "sourceDirName");
		}
		if (destDirName == null)
		{
			throw new ArgumentNullException("destDirName");
		}
		if (destDirName.Length == 0)
		{
			throw new ArgumentException("Empty file name is not legal.", "destDirName");
		}
		string fullPath = Path.GetFullPath(sourceDirName);
		string text = PathInternal.EnsureTrailingSeparator(fullPath);
		string fullPath2 = Path.GetFullPath(destDirName);
		string text2 = PathInternal.EnsureTrailingSeparator(fullPath2);
		StringComparison stringComparison = PathInternal.StringComparison;
		if (string.Equals(text, text2, stringComparison))
		{
			throw new IOException("Source and destination path must be different.");
		}
		string pathRoot = Path.GetPathRoot(text);
		string pathRoot2 = Path.GetPathRoot(text2);
		if (!string.Equals(pathRoot, pathRoot2, stringComparison))
		{
			throw new IOException("Source and destination path must have identical roots. Move will not work across volumes.");
		}
		if (!FileSystem.DirectoryExists(fullPath) && !FileSystem.FileExists(fullPath))
		{
			throw new DirectoryNotFoundException(SR.Format("Could not find a part of the path '{0}'.", fullPath));
		}
		if (FileSystem.DirectoryExists(fullPath2))
		{
			throw new IOException(SR.Format("Cannot create '{0}' because a file or directory with the same name already exists.", fullPath2));
		}
		FileSystem.MoveDirectory(fullPath, fullPath2);
	}

	public static void Delete(string path)
	{
		FileSystem.RemoveDirectory(Path.GetFullPath(path), recursive: false);
	}

	public static void Delete(string path, bool recursive)
	{
		FileSystem.RemoveDirectory(Path.GetFullPath(path), recursive);
	}

	public static string[] GetLogicalDrives()
	{
		return FileSystem.GetLogicalDrives();
	}

	public static DirectoryInfo CreateDirectory(string path, DirectorySecurity directorySecurity)
	{
		return CreateDirectory(path);
	}

	public static DirectorySecurity GetAccessControl(string path, AccessControlSections includeSections)
	{
		return new DirectorySecurity(path, includeSections);
	}

	public static DirectorySecurity GetAccessControl(string path)
	{
		return GetAccessControl(path, AccessControlSections.Access | AccessControlSections.Owner | AccessControlSections.Group);
	}

	public static void SetAccessControl(string path, DirectorySecurity directorySecurity)
	{
		if (directorySecurity == null)
		{
			throw new ArgumentNullException("directorySecurity");
		}
		string fullPath = Path.GetFullPath(path);
		directorySecurity.PersistModifications(fullPath);
	}

	internal static string InsecureGetCurrentDirectory()
	{
		string currentDirectory = MonoIO.GetCurrentDirectory(out var error);
		if (error != MonoIOError.ERROR_SUCCESS)
		{
			throw MonoIO.GetException(error);
		}
		return currentDirectory;
	}

	internal static void InsecureSetCurrentDirectory(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (path.Trim().Length == 0)
		{
			throw new ArgumentException("path string must not be an empty string or whitespace string");
		}
		if (!Exists(path))
		{
			throw new DirectoryNotFoundException("Directory \"" + path + "\" not found.");
		}
		MonoIO.SetCurrentDirectory(path, out var error);
		if (error != MonoIOError.ERROR_SUCCESS)
		{
			throw MonoIO.GetException(path, error);
		}
	}
}
