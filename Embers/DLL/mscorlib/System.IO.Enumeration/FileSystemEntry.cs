namespace System.IO.Enumeration;

public ref struct FileSystemEntry
{
	internal Interop.Sys.DirectoryEntry _directoryEntry;

	private FileStatus _status;

	private Span<char> _pathBuffer;

	private ReadOnlySpan<char> _fullPath;

	private ReadOnlySpan<char> _fileName;

	private unsafe fixed char _fileNameBuffer[256];

	private FileAttributes _initialAttributes;

	private ReadOnlySpan<char> FullPath
	{
		get
		{
			if (_fullPath.Length == 0)
			{
				Path.TryJoin(Directory, FileName, _pathBuffer, out var charsWritten);
				_fullPath = _pathBuffer.Slice(0, charsWritten);
			}
			return _fullPath;
		}
	}

	public unsafe ReadOnlySpan<char> FileName
	{
		get
		{
			if (_directoryEntry.NameLength != 0 && _fileName.Length == 0)
			{
				fixed (char* fileNameBuffer = _fileNameBuffer)
				{
					Span<char> buffer = new Span<char>(fileNameBuffer, 256);
					_fileName = _directoryEntry.GetName(buffer);
				}
			}
			return _fileName;
		}
	}

	public ReadOnlySpan<char> Directory { get; private set; }

	public ReadOnlySpan<char> RootDirectory { get; private set; }

	public ReadOnlySpan<char> OriginalRootDirectory { get; private set; }

	public FileAttributes Attributes => (FileAttributes)((int)_initialAttributes | (_status.IsReadOnly(FullPath, continueOnError: true) ? 1 : 0));

	public bool IsDirectory => _status.InitiallyDirectory;

	internal unsafe static FileAttributes Initialize(ref FileSystemEntry entry, Interop.Sys.DirectoryEntry directoryEntry, ReadOnlySpan<char> directory, ReadOnlySpan<char> rootDirectory, ReadOnlySpan<char> originalRootDirectory, Span<char> pathBuffer)
	{
		entry._directoryEntry = directoryEntry;
		entry.Directory = directory;
		entry.RootDirectory = rootDirectory;
		entry.OriginalRootDirectory = originalRootDirectory;
		entry._pathBuffer = pathBuffer;
		entry._fullPath = ReadOnlySpan<char>.Empty;
		entry._fileName = ReadOnlySpan<char>.Empty;
		bool flag = false;
		bool flag2 = false;
		Interop.Sys.FileStatus output;
		if (directoryEntry.InodeType == Interop.Sys.NodeType.DT_DIR)
		{
			flag = true;
		}
		else if ((directoryEntry.InodeType == Interop.Sys.NodeType.DT_LNK || directoryEntry.InodeType == Interop.Sys.NodeType.DT_UNKNOWN) && (Interop.Sys.Stat(entry.FullPath, out output) >= 0 || Interop.Sys.LStat(entry.FullPath, out output) >= 0))
		{
			flag = (output.Mode & 0xF000) == 16384;
		}
		Interop.Sys.FileStatus output2;
		if (directoryEntry.InodeType == Interop.Sys.NodeType.DT_LNK)
		{
			flag2 = true;
		}
		else if (directoryEntry.InodeType == Interop.Sys.NodeType.DT_UNKNOWN && Interop.Sys.LStat(entry.FullPath, out output2) >= 0)
		{
			flag2 = (output2.Mode & 0xF000) == 40960;
		}
		entry._status = default(FileStatus);
		FileStatus.Initialize(ref entry._status, flag);
		FileAttributes fileAttributes = (FileAttributes)0;
		if (flag2)
		{
			fileAttributes |= FileAttributes.ReparsePoint;
		}
		if (flag)
		{
			fileAttributes |= FileAttributes.Directory;
		}
		if (*directoryEntry.Name == 46)
		{
			fileAttributes |= FileAttributes.Hidden;
		}
		if (fileAttributes == (FileAttributes)0)
		{
			fileAttributes = FileAttributes.Normal;
		}
		entry._initialAttributes = fileAttributes;
		return fileAttributes;
	}

	public FileSystemInfo ToFileSystemInfo()
	{
		return FileSystemInfo.Create(ToFullPath(), new string(FileName), ref _status);
	}

	public string ToFullPath()
	{
		return new string(FullPath);
	}

	public string ToSpecifiedFullPath()
	{
		ReadOnlySpan<char> readOnlySpan = Directory.Slice(RootDirectory.Length);
		if (PathInternal.EndsInDirectorySeparator(OriginalRootDirectory) && PathInternal.StartsWithDirectorySeparator(readOnlySpan))
		{
			readOnlySpan = readOnlySpan.Slice(1);
		}
		return Path.Join(OriginalRootDirectory, readOnlySpan, FileName);
	}
}
