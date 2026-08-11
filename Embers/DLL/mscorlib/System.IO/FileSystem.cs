using System.Collections.Generic;

namespace System.IO;

internal static class FileSystem
{
	private static bool CopyDanglingSymlink(string sourceFullPath, string destFullPath)
	{
		if (Interop.Sys.Stat(sourceFullPath, out var output) >= 0 || Interop.Sys.LStat(sourceFullPath, out output) != 0)
		{
			return false;
		}
		if (Interop.Sys.Symlink(Interop.Sys.ReadLink(sourceFullPath) ?? throw Interop.GetExceptionForIoErrno(Interop.Sys.GetLastErrorInfo(), sourceFullPath), destFullPath) == 0)
		{
			return true;
		}
		throw Interop.GetExceptionForIoErrno(Interop.Sys.GetLastErrorInfo(), destFullPath);
	}

	public static void CopyFile(string sourceFullPath, string destFullPath, bool overwrite)
	{
		if (DirectoryExists(destFullPath))
		{
			destFullPath = Path.Combine(destFullPath, Path.GetFileName(sourceFullPath));
		}
		if (CopyDanglingSymlink(sourceFullPath, destFullPath))
		{
			return;
		}
		using FileStream fileStream = new FileStream(sourceFullPath, FileMode.Open, FileAccess.Read, FileShare.Read, 4096, FileOptions.None);
		using FileStream fileStream2 = new FileStream(destFullPath, (!overwrite) ? FileMode.CreateNew : FileMode.Create, FileAccess.ReadWrite, FileShare.None, 4096, FileOptions.None);
		Interop.CheckIo(Interop.Sys.CopyFile(fileStream.SafeFileHandle, fileStream2.SafeFileHandle));
	}

	private static void LinkOrCopyFile(string sourceFullPath, string destFullPath)
	{
		if (CopyDanglingSymlink(sourceFullPath, destFullPath) || Interop.Sys.Link(sourceFullPath, destFullPath) >= 0)
		{
			return;
		}
		Interop.ErrorInfo lastErrorInfo = Interop.Sys.GetLastErrorInfo();
		if (lastErrorInfo.Error == Interop.Error.EXDEV || lastErrorInfo.Error == Interop.Error.EACCES || lastErrorInfo.Error == Interop.Error.EPERM || lastErrorInfo.Error == Interop.Error.ENOTSUP || lastErrorInfo.Error == Interop.Error.EMLINK || lastErrorInfo.Error == Interop.Error.ENOSYS)
		{
			CopyFile(sourceFullPath, destFullPath, overwrite: false);
			return;
		}
		string path = null;
		bool isDirectory = false;
		if (lastErrorInfo.Error == Interop.Error.ENOENT)
		{
			if (!Directory.Exists(Path.GetDirectoryName(destFullPath)))
			{
				path = destFullPath;
				isDirectory = true;
			}
			else
			{
				path = sourceFullPath;
			}
		}
		else if (lastErrorInfo.Error == Interop.Error.EEXIST)
		{
			path = destFullPath;
		}
		throw Interop.GetExceptionForIoErrno(lastErrorInfo, path, isDirectory);
	}

	public static void ReplaceFile(string sourceFullPath, string destFullPath, string destBackupFullPath, bool ignoreMetadataErrors)
	{
		Interop.Sys.FileStatus output;
		if (destBackupFullPath != null)
		{
			if (Interop.Sys.Unlink(destBackupFullPath) != 0)
			{
				Interop.ErrorInfo lastErrorInfo = Interop.Sys.GetLastErrorInfo();
				if (lastErrorInfo.Error != Interop.Error.ENOENT)
				{
					throw Interop.GetExceptionForIoErrno(lastErrorInfo, destBackupFullPath);
				}
			}
			LinkOrCopyFile(destFullPath, destBackupFullPath);
		}
		else if (Interop.Sys.Stat(destFullPath, out output) != 0)
		{
			Interop.ErrorInfo lastErrorInfo2 = Interop.Sys.GetLastErrorInfo();
			if (lastErrorInfo2.Error == Interop.Error.ENOENT)
			{
				throw Interop.GetExceptionForIoErrno(lastErrorInfo2, destBackupFullPath);
			}
		}
		Interop.CheckIo(Interop.Sys.Rename(sourceFullPath, destFullPath));
	}

	public static void MoveFile(string sourceFullPath, string destFullPath)
	{
		if (Interop.Sys.LStat(sourceFullPath, out var output) != 0 || (Interop.Sys.LStat(destFullPath, out var output2) == 0 && (output.Dev != output2.Dev || output.Ino != output2.Ino)) || Interop.Sys.Rename(sourceFullPath, destFullPath) != 0)
		{
			LinkOrCopyFile(sourceFullPath, destFullPath);
			DeleteFile(sourceFullPath);
		}
	}

	public static void DeleteFile(string fullPath)
	{
		if (Interop.Sys.Unlink(fullPath) >= 0)
		{
			return;
		}
		Interop.ErrorInfo errorInfo = Interop.Sys.GetLastErrorInfo();
		switch (errorInfo.Error)
		{
		case Interop.Error.ENOENT:
			return;
		case Interop.Error.EROFS:
		{
			if (!FileExists(PathInternal.TrimEndingDirectorySeparator(fullPath), 32768, out var errorInfo2) && errorInfo2.Error == Interop.Error.ENOENT)
			{
				return;
			}
			break;
		}
		case Interop.Error.EISDIR:
			errorInfo = Interop.Error.EACCES.Info();
			break;
		}
		throw Interop.GetExceptionForIoErrno(errorInfo, fullPath);
	}

	public static void CreateDirectory(string fullPath)
	{
		int num = fullPath.Length;
		if (num >= 2 && PathInternal.EndsInDirectorySeparator(fullPath))
		{
			num--;
		}
		if (num == 2 && PathInternal.IsDirectorySeparator(fullPath[1]))
		{
			throw new IOException(SR.Format("The specified directory '{0}' cannot be created.", fullPath));
		}
		if (DirectoryExists(fullPath))
		{
			return;
		}
		bool flag = false;
		Stack<string> stack = new Stack<string>();
		int rootLength = PathInternal.GetRootLength(fullPath);
		if (num > rootLength)
		{
			int num2 = num - 1;
			while (num2 >= rootLength && !flag)
			{
				string text = fullPath.Substring(0, num2 + 1);
				if (!DirectoryExists(text))
				{
					stack.Push(text);
				}
				else
				{
					flag = true;
				}
				while (num2 > rootLength && !PathInternal.IsDirectorySeparator(fullPath[num2]))
				{
					num2--;
				}
				num2--;
			}
		}
		if (stack.Count == 0 && !flag)
		{
			if (DirectoryExists(Directory.InternalGetDirectoryRoot(fullPath)))
			{
				return;
			}
			throw Interop.GetExceptionForIoErrno(Interop.Error.ENOENT.Info(), fullPath, isDirectory: true);
		}
		int num3 = 0;
		Interop.ErrorInfo errorInfo = default(Interop.ErrorInfo);
		string path = fullPath;
		while (stack.Count > 0)
		{
			string text2 = stack.Pop();
			num3 = Interop.Sys.MkDir(text2, 511);
			if (num3 < 0 && errorInfo.Error == Interop.Error.SUCCESS)
			{
				Interop.ErrorInfo errorInfo2 = Interop.Sys.GetLastErrorInfo();
				if (errorInfo2.Error != Interop.Error.EEXIST)
				{
					errorInfo = errorInfo2;
				}
				else if (FileExists(text2) || (!DirectoryExists(text2, out errorInfo2) && errorInfo2.Error == Interop.Error.EACCES))
				{
					errorInfo = errorInfo2;
					path = text2;
				}
			}
		}
		if (num3 >= 0 || errorInfo.Error == Interop.Error.SUCCESS)
		{
			return;
		}
		throw Interop.GetExceptionForIoErrno(errorInfo, path, isDirectory: true);
	}

	public static void MoveDirectory(string sourceFullPath, string destFullPath)
	{
		if (FileExists(sourceFullPath))
		{
			if (PathInternal.EndsInDirectorySeparator(sourceFullPath))
			{
				throw new IOException(SR.Format("Could not find a part of the path '{0}'.", sourceFullPath));
			}
			destFullPath = PathInternal.TrimEndingDirectorySeparator(destFullPath);
			if (FileExists(destFullPath))
			{
				throw new IOException("Cannot create a file when that file already exists.");
			}
		}
		if (Interop.Sys.Rename(sourceFullPath, destFullPath) < 0)
		{
			Interop.ErrorInfo lastErrorInfo = Interop.Sys.GetLastErrorInfo();
			if (lastErrorInfo.Error == Interop.Error.EACCES)
			{
				throw new IOException(SR.Format("Access to the path '{0}' is denied.", sourceFullPath), lastErrorInfo.RawErrno);
			}
			throw Interop.GetExceptionForIoErrno(lastErrorInfo, sourceFullPath, isDirectory: true);
		}
	}

	public static void RemoveDirectory(string fullPath, bool recursive)
	{
		DirectoryInfo directoryInfo = new DirectoryInfo(fullPath);
		if (!directoryInfo.Exists)
		{
			throw Interop.GetExceptionForIoErrno(Interop.Error.ENOENT.Info(), fullPath, isDirectory: true);
		}
		RemoveDirectoryInternal(directoryInfo, recursive, throwOnTopLevelDirectoryNotFound: true);
	}

	private static void RemoveDirectoryInternal(DirectoryInfo directory, bool recursive, bool throwOnTopLevelDirectoryNotFound)
	{
		Exception ex = null;
		if ((directory.Attributes & FileAttributes.ReparsePoint) != 0)
		{
			DeleteFile(directory.FullName);
			return;
		}
		if (recursive)
		{
			try
			{
				foreach (string item in Directory.EnumerateFileSystemEntries(directory.FullName))
				{
					if (ShouldIgnoreDirectory(Path.GetFileName(item)))
					{
						continue;
					}
					try
					{
						DirectoryInfo directoryInfo = new DirectoryInfo(item);
						if (directoryInfo.Exists)
						{
							RemoveDirectoryInternal(directoryInfo, recursive, throwOnTopLevelDirectoryNotFound: false);
						}
						else
						{
							DeleteFile(item);
						}
					}
					catch (Exception ex2)
					{
						if (ex != null)
						{
							ex = ex2;
						}
					}
				}
			}
			catch (Exception ex3)
			{
				if (ex != null)
				{
					ex = ex3;
				}
			}
			if (ex != null)
			{
				throw ex;
			}
		}
		if (Interop.Sys.RmDir(directory.FullName) >= 0)
		{
			return;
		}
		Interop.ErrorInfo lastErrorInfo = Interop.Sys.GetLastErrorInfo();
		switch (lastErrorInfo.Error)
		{
		case Interop.Error.EACCES:
		case Interop.Error.EISDIR:
		case Interop.Error.EPERM:
		case Interop.Error.EROFS:
			throw new IOException(SR.Format("Access to the path '{0}' is denied.", directory.FullName));
		case Interop.Error.ENOENT:
			if (!throwOnTopLevelDirectoryNotFound)
			{
				return;
			}
			break;
		}
		throw Interop.GetExceptionForIoErrno(lastErrorInfo, directory.FullName, isDirectory: true);
	}

	public static bool DirectoryExists(ReadOnlySpan<char> fullPath)
	{
		Interop.ErrorInfo errorInfo;
		return DirectoryExists(fullPath, out errorInfo);
	}

	private static bool DirectoryExists(ReadOnlySpan<char> fullPath, out Interop.ErrorInfo errorInfo)
	{
		return FileExists(fullPath, 16384, out errorInfo);
	}

	public static bool FileExists(ReadOnlySpan<char> fullPath)
	{
		Interop.ErrorInfo errorInfo;
		return FileExists(PathInternal.TrimEndingDirectorySeparator(fullPath), 32768, out errorInfo);
	}

	private static bool FileExists(ReadOnlySpan<char> fullPath, int fileType, out Interop.ErrorInfo errorInfo)
	{
		errorInfo = default(Interop.ErrorInfo);
		if (Interop.Sys.Stat(fullPath, out var output) < 0 && Interop.Sys.LStat(fullPath, out output) < 0)
		{
			errorInfo = Interop.Sys.GetLastErrorInfo();
			return false;
		}
		return fileType == 16384 == ((output.Mode & 0xF000) == 16384);
	}

	private static bool ShouldIgnoreDirectory(string name)
	{
		if (!(name == "."))
		{
			return name == "..";
		}
		return true;
	}

	public static FileAttributes GetAttributes(string fullPath)
	{
		FileAttributes attributes = new FileInfo(fullPath, null, null, false).Attributes;
		if (attributes == (FileAttributes)(-1))
		{
			FileSystemInfo.ThrowNotFound(fullPath);
		}
		return attributes;
	}

	public static void SetAttributes(string fullPath, FileAttributes attributes)
	{
		new FileInfo(fullPath, null, null, false).Attributes = attributes;
	}

	public static DateTimeOffset GetCreationTime(string fullPath)
	{
		return new FileInfo(fullPath, null, null, false).CreationTime;
	}

	public static void SetCreationTime(string fullPath, DateTimeOffset time, bool asDirectory)
	{
		(asDirectory ? ((FileSystemInfo)new DirectoryInfo(fullPath, null, null, false)) : ((FileSystemInfo)new FileInfo(fullPath, null, null, false))).CreationTimeCore = time;
	}

	public static DateTimeOffset GetLastAccessTime(string fullPath)
	{
		return new FileInfo(fullPath, null, null, false).LastAccessTime;
	}

	public static void SetLastAccessTime(string fullPath, DateTimeOffset time, bool asDirectory)
	{
		(asDirectory ? ((FileSystemInfo)new DirectoryInfo(fullPath, null, null, false)) : ((FileSystemInfo)new FileInfo(fullPath, null, null, false))).LastAccessTimeCore = time;
	}

	public static DateTimeOffset GetLastWriteTime(string fullPath)
	{
		return new FileInfo(fullPath, null, null, false).LastWriteTime;
	}

	public static void SetLastWriteTime(string fullPath, DateTimeOffset time, bool asDirectory)
	{
		(asDirectory ? ((FileSystemInfo)new DirectoryInfo(fullPath, null, null, false)) : ((FileSystemInfo)new FileInfo(fullPath, null, null, false))).LastWriteTimeCore = time;
	}

	public static string[] GetLogicalDrives()
	{
		return DriveInfoInternal.GetLogicalDrives();
	}
}
