using System.Collections.Generic;

namespace System.IO;

internal class DefaultWatcherData
{
	public FileSystemWatcher FSW;

	public string Directory;

	public string FileMask;

	public bool IncludeSubdirs;

	public bool Enabled;

	public bool NoWildcards;

	public DateTime DisabledTime;

	public object FilesLock = new object();

	public Dictionary<string, FileData> Files;
}
