namespace System.IO.Enumeration;

public ref struct FileSystemEntry
{
	internal unsafe Interop.NtDll.FILE_FULL_DIR_INFORMATION* _info;

	public ReadOnlySpan<char> Directory { get; private set; }

	public ReadOnlySpan<char> RootDirectory { get; private set; }

	public ReadOnlySpan<char> OriginalRootDirectory { get; private set; }

	public unsafe ReadOnlySpan<char> FileName => _info->FileName;

	public unsafe FileAttributes Attributes => _info->FileAttributes;

	public bool IsDirectory => (Attributes & FileAttributes.Directory) != 0;

	internal unsafe static void Initialize(ref FileSystemEntry entry, Interop.NtDll.FILE_FULL_DIR_INFORMATION* info, ReadOnlySpan<char> directory, ReadOnlySpan<char> rootDirectory, ReadOnlySpan<char> originalRootDirectory)
	{
		entry._info = info;
		entry.Directory = directory;
		entry.RootDirectory = rootDirectory;
		entry.OriginalRootDirectory = originalRootDirectory;
	}

	public FileSystemInfo ToFileSystemInfo()
	{
		return FileSystemInfo.Create(Path.Join(Directory, FileName), ref this);
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
