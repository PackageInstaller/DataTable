namespace System.IO;

internal struct MonoIOStat
{
	public FileAttributes fileAttributes;

	public long Length;

	public long CreationTime;

	public long LastAccessTime;

	public long LastWriteTime;
}
