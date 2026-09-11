namespace System.IO;

public class FileSystemEventArgs : EventArgs
{
	private readonly WatcherChangeTypes _changeType;

	private readonly string _name;

	private readonly string _fullPath;

	public WatcherChangeTypes ChangeType => _changeType;

	public string FullPath => _fullPath;

	public FileSystemEventArgs(WatcherChangeTypes changeType, string directory, string name)
	{
		_changeType = changeType;
		_name = name;
		_fullPath = Path.GetFullPath(Combine(directory, name));
	}

	internal static string Combine(string directoryPath, string name)
	{
		bool flag = false;
		if (directoryPath.Length > 0)
		{
			char c = directoryPath[directoryPath.Length - 1];
			flag = c == Path.DirectorySeparatorChar || c == Path.AltDirectorySeparatorChar;
		}
		if (!flag)
		{
			return directoryPath + Path.DirectorySeparatorChar + name;
		}
		return directoryPath + name;
	}
}
