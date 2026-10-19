using System.Collections.Generic;
using System.IO.Enumeration;
using System.Runtime.Serialization;
using System.Security.AccessControl;

namespace System.IO;

[Serializable]
public sealed class DirectoryInfo : FileSystemInfo
{
	public DirectoryInfo Parent
	{
		get
		{
			string directoryName = Path.GetDirectoryName(PathInternal.IsRoot(FullPath) ? FullPath : PathInternal.TrimEndingDirectorySeparator(FullPath));
			if (directoryName == null)
			{
				return null;
			}
			return new DirectoryInfo(directoryName, null, null, false);
		}
	}

	public DirectoryInfo Root => new DirectoryInfo(Path.GetPathRoot(FullPath));

	public DirectoryInfo(string path)
	{
		Init(path, Path.GetFullPath(path), null, isNormalized: true);
	}

	internal DirectoryInfo(string originalPath, string fullPath = null, string fileName = null, bool isNormalized = false)
	{
		Init(originalPath, fullPath, fileName, isNormalized);
	}

	private void Init(string originalPath, string fullPath = null, string fileName = null, bool isNormalized = false)
	{
		OriginalPath = originalPath ?? throw new ArgumentNullException("path");
		fullPath = fullPath ?? originalPath;
		fullPath = (isNormalized ? fullPath : Path.GetFullPath(fullPath));
		_name = fileName ?? (PathInternal.IsRoot(fullPath) ? ((ReadOnlySpan<char>)fullPath) : Path.GetFileName(PathInternal.TrimEndingDirectorySeparator((ReadOnlySpan<char>)fullPath))).ToString();
		FullPath = fullPath;
	}

	public DirectoryInfo CreateSubdirectory(string path)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (PathInternal.IsEffectivelyEmpty(path))
		{
			throw new ArgumentException("Path cannot be the empty string or all whitespace.", "path");
		}
		if (Path.IsPathRooted(path))
		{
			throw new ArgumentException("Second path fragment must not be a drive or UNC name.", "path");
		}
		string fullPath = Path.GetFullPath(Path.Combine(FullPath, path));
		ReadOnlySpan<char> span = PathInternal.TrimEndingDirectorySeparator((ReadOnlySpan<char>)fullPath);
		ReadOnlySpan<char> value = PathInternal.TrimEndingDirectorySeparator((ReadOnlySpan<char>)FullPath);
		if (span.StartsWith(value, PathInternal.StringComparison) && (span.Length == value.Length || PathInternal.IsDirectorySeparator(fullPath[value.Length])))
		{
			FileSystem.CreateDirectory(fullPath);
			return new DirectoryInfo(fullPath);
		}
		throw new ArgumentException(SR.Format("The directory specified, '{0}', is not a subdirectory of '{1}'.", path, FullPath), "path");
	}

	public void Create()
	{
		FileSystem.CreateDirectory(FullPath);
		Invalidate();
	}

	public FileInfo[] GetFiles()
	{
		return GetFiles("*", EnumerationOptions.Compatible);
	}

	public FileInfo[] GetFiles(string searchPattern)
	{
		return GetFiles(searchPattern, EnumerationOptions.Compatible);
	}

	public FileInfo[] GetFiles(string searchPattern, SearchOption searchOption)
	{
		return GetFiles(searchPattern, EnumerationOptions.FromSearchOption(searchOption));
	}

	public FileInfo[] GetFiles(string searchPattern, EnumerationOptions enumerationOptions)
	{
		return ((IEnumerable<FileInfo>)InternalEnumerateInfos(FullPath, searchPattern, SearchTarget.Files, enumerationOptions)).ToArray();
	}

	public FileSystemInfo[] GetFileSystemInfos()
	{
		return GetFileSystemInfos("*", EnumerationOptions.Compatible);
	}

	public FileSystemInfo[] GetFileSystemInfos(string searchPattern)
	{
		return GetFileSystemInfos(searchPattern, EnumerationOptions.Compatible);
	}

	public FileSystemInfo[] GetFileSystemInfos(string searchPattern, SearchOption searchOption)
	{
		return GetFileSystemInfos(searchPattern, EnumerationOptions.FromSearchOption(searchOption));
	}

	public FileSystemInfo[] GetFileSystemInfos(string searchPattern, EnumerationOptions enumerationOptions)
	{
		return InternalEnumerateInfos(FullPath, searchPattern, SearchTarget.Both, enumerationOptions).ToArray();
	}

	public DirectoryInfo[] GetDirectories()
	{
		return GetDirectories("*", EnumerationOptions.Compatible);
	}

	public DirectoryInfo[] GetDirectories(string searchPattern)
	{
		return GetDirectories(searchPattern, EnumerationOptions.Compatible);
	}

	public DirectoryInfo[] GetDirectories(string searchPattern, SearchOption searchOption)
	{
		return GetDirectories(searchPattern, EnumerationOptions.FromSearchOption(searchOption));
	}

	public DirectoryInfo[] GetDirectories(string searchPattern, EnumerationOptions enumerationOptions)
	{
		return ((IEnumerable<DirectoryInfo>)InternalEnumerateInfos(FullPath, searchPattern, SearchTarget.Directories, enumerationOptions)).ToArray();
	}

	public IEnumerable<DirectoryInfo> EnumerateDirectories()
	{
		return EnumerateDirectories("*", EnumerationOptions.Compatible);
	}

	public IEnumerable<DirectoryInfo> EnumerateDirectories(string searchPattern)
	{
		return EnumerateDirectories(searchPattern, EnumerationOptions.Compatible);
	}

	public IEnumerable<DirectoryInfo> EnumerateDirectories(string searchPattern, SearchOption searchOption)
	{
		return EnumerateDirectories(searchPattern, EnumerationOptions.FromSearchOption(searchOption));
	}

	public IEnumerable<DirectoryInfo> EnumerateDirectories(string searchPattern, EnumerationOptions enumerationOptions)
	{
		return (IEnumerable<DirectoryInfo>)InternalEnumerateInfos(FullPath, searchPattern, SearchTarget.Directories, enumerationOptions);
	}

	public IEnumerable<FileInfo> EnumerateFiles()
	{
		return EnumerateFiles("*", EnumerationOptions.Compatible);
	}

	public IEnumerable<FileInfo> EnumerateFiles(string searchPattern)
	{
		return EnumerateFiles(searchPattern, EnumerationOptions.Compatible);
	}

	public IEnumerable<FileInfo> EnumerateFiles(string searchPattern, SearchOption searchOption)
	{
		return EnumerateFiles(searchPattern, EnumerationOptions.FromSearchOption(searchOption));
	}

	public IEnumerable<FileInfo> EnumerateFiles(string searchPattern, EnumerationOptions enumerationOptions)
	{
		return (IEnumerable<FileInfo>)InternalEnumerateInfos(FullPath, searchPattern, SearchTarget.Files, enumerationOptions);
	}

	public IEnumerable<FileSystemInfo> EnumerateFileSystemInfos()
	{
		return EnumerateFileSystemInfos("*", EnumerationOptions.Compatible);
	}

	public IEnumerable<FileSystemInfo> EnumerateFileSystemInfos(string searchPattern)
	{
		return EnumerateFileSystemInfos(searchPattern, EnumerationOptions.Compatible);
	}

	public IEnumerable<FileSystemInfo> EnumerateFileSystemInfos(string searchPattern, SearchOption searchOption)
	{
		return EnumerateFileSystemInfos(searchPattern, EnumerationOptions.FromSearchOption(searchOption));
	}

	public IEnumerable<FileSystemInfo> EnumerateFileSystemInfos(string searchPattern, EnumerationOptions enumerationOptions)
	{
		return InternalEnumerateInfos(FullPath, searchPattern, SearchTarget.Both, enumerationOptions);
	}

	internal static IEnumerable<FileSystemInfo> InternalEnumerateInfos(string path, string searchPattern, SearchTarget searchTarget, EnumerationOptions options)
	{
		if (searchPattern == null)
		{
			throw new ArgumentNullException("searchPattern");
		}
		FileSystemEnumerableFactory.NormalizeInputs(ref path, ref searchPattern, options);
		return searchTarget switch
		{
			SearchTarget.Directories => FileSystemEnumerableFactory.DirectoryInfos(path, searchPattern, options), 
			SearchTarget.Files => FileSystemEnumerableFactory.FileInfos(path, searchPattern, options), 
			SearchTarget.Both => FileSystemEnumerableFactory.FileSystemInfos(path, searchPattern, options), 
			_ => throw new ArgumentException("Enum value was out of legal range.", "searchTarget"), 
		};
	}

	public void MoveTo(string destDirName)
	{
		if (destDirName == null)
		{
			throw new ArgumentNullException("destDirName");
		}
		if (destDirName.Length == 0)
		{
			throw new ArgumentException("Empty file name is not legal.", "destDirName");
		}
		string fullPath = Path.GetFullPath(destDirName);
		string text = PathInternal.EnsureTrailingSeparator(fullPath);
		string text2 = PathInternal.EnsureTrailingSeparator(FullPath);
		if (string.Equals(text2, text, PathInternal.StringComparison))
		{
			throw new IOException("Source and destination path must be different.");
		}
		string pathRoot = Path.GetPathRoot(text2);
		string pathRoot2 = Path.GetPathRoot(text);
		if (!string.Equals(pathRoot, pathRoot2, PathInternal.StringComparison))
		{
			throw new IOException("Source and destination path must have identical roots. Move will not work across volumes.");
		}
		if (!Exists && !FileSystem.FileExists(FullPath))
		{
			throw new DirectoryNotFoundException(SR.Format("Could not find a part of the path '{0}'.", FullPath));
		}
		if (FileSystem.DirectoryExists(fullPath))
		{
			throw new IOException(SR.Format("Cannot create '{0}' because a file or directory with the same name already exists.", text));
		}
		FileSystem.MoveDirectory(FullPath, fullPath);
		Init(destDirName, text, null, isNormalized: true);
		Invalidate();
	}

	public override void Delete()
	{
		FileSystem.RemoveDirectory(FullPath, recursive: false);
	}

	public void Delete(bool recursive)
	{
		FileSystem.RemoveDirectory(FullPath, recursive);
	}

	private DirectoryInfo(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}

	public void Create(DirectorySecurity directorySecurity)
	{
		FileSystem.CreateDirectory(FullPath);
	}

	public DirectoryInfo CreateSubdirectory(string path, DirectorySecurity directorySecurity)
	{
		return CreateSubdirectory(path);
	}

	public DirectorySecurity GetAccessControl()
	{
		return Directory.GetAccessControl(FullPath, AccessControlSections.Access | AccessControlSections.Owner | AccessControlSections.Group);
	}

	public DirectorySecurity GetAccessControl(AccessControlSections includeSections)
	{
		return Directory.GetAccessControl(FullPath, includeSections);
	}

	public void SetAccessControl(DirectorySecurity directorySecurity)
	{
		Directory.SetAccessControl(FullPath, directorySecurity);
	}
}
