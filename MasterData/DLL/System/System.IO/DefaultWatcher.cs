using System.Collections;
using System.Collections.Generic;
using System.Threading;

namespace System.IO;

internal class DefaultWatcher : IFileWatcher
{
	private static DefaultWatcher instance;

	private static Thread thread;

	private static Hashtable watches;

	private static string[] NoStringsArray = new string[0];

	private DefaultWatcher()
	{
	}

	public static bool GetInstance(out IFileWatcher watcher)
	{
		if (instance != null)
		{
			watcher = instance;
			return true;
		}
		instance = new DefaultWatcher();
		watcher = instance;
		return true;
	}

	public void StartDispatching(object handle)
	{
		FileSystemWatcher fileSystemWatcher = handle as FileSystemWatcher;
		lock (this)
		{
			if (watches == null)
			{
				watches = new Hashtable();
			}
			if (thread == null)
			{
				thread = new Thread(Monitor);
				thread.IsBackground = true;
				thread.Start();
			}
		}
		lock (watches)
		{
			DefaultWatcherData defaultWatcherData = (DefaultWatcherData)watches[fileSystemWatcher];
			if (defaultWatcherData == null)
			{
				defaultWatcherData = new DefaultWatcherData();
				defaultWatcherData.Files = new Dictionary<string, FileData>();
				watches[fileSystemWatcher] = defaultWatcherData;
			}
			defaultWatcherData.FSW = fileSystemWatcher;
			defaultWatcherData.Directory = fileSystemWatcher.FullPath;
			defaultWatcherData.NoWildcards = !fileSystemWatcher.Pattern.HasWildcard;
			if (defaultWatcherData.NoWildcards)
			{
				defaultWatcherData.FileMask = Path.Combine(defaultWatcherData.Directory, fileSystemWatcher.MangledFilter);
			}
			else
			{
				defaultWatcherData.FileMask = fileSystemWatcher.MangledFilter;
			}
			defaultWatcherData.IncludeSubdirs = fileSystemWatcher.IncludeSubdirectories;
			defaultWatcherData.Enabled = true;
			defaultWatcherData.DisabledTime = DateTime.MaxValue;
			UpdateDataAndDispatch(defaultWatcherData, dispatch: false);
		}
	}

	public void StopDispatching(object handle)
	{
		FileSystemWatcher key = handle as FileSystemWatcher;
		lock (this)
		{
			if (watches == null)
			{
				return;
			}
		}
		lock (watches)
		{
			DefaultWatcherData defaultWatcherData = (DefaultWatcherData)watches[key];
			if (defaultWatcherData != null)
			{
				lock (defaultWatcherData.FilesLock)
				{
					defaultWatcherData.Enabled = false;
					defaultWatcherData.DisabledTime = DateTime.UtcNow;
					return;
				}
			}
		}
	}

	public void Dispose(object handle)
	{
	}

	private void Monitor()
	{
		int num = 0;
		while (true)
		{
			Thread.Sleep(750);
			Hashtable hashtable;
			lock (watches)
			{
				if (watches.Count == 0)
				{
					if (++num == 20)
					{
						break;
					}
					continue;
				}
				hashtable = (Hashtable)watches.Clone();
			}
			if (hashtable.Count == 0)
			{
				continue;
			}
			num = 0;
			foreach (DefaultWatcherData value in hashtable.Values)
			{
				if (UpdateDataAndDispatch(value, dispatch: true))
				{
					lock (watches)
					{
						watches.Remove(value.FSW);
					}
				}
			}
		}
		lock (this)
		{
			thread = null;
		}
	}

	private bool UpdateDataAndDispatch(DefaultWatcherData data, bool dispatch)
	{
		if (!data.Enabled)
		{
			if (data.DisabledTime != DateTime.MaxValue)
			{
				return (DateTime.UtcNow - data.DisabledTime).TotalSeconds > 5.0;
			}
			return false;
		}
		DoFiles(data, data.Directory, dispatch);
		return false;
	}

	private static void DispatchEvents(FileSystemWatcher fsw, FileAction action, string filename)
	{
		RenamedEventArgs renamed = null;
		lock (fsw)
		{
			fsw.DispatchEvents(action, filename, ref renamed);
			if (fsw.Waiting)
			{
				fsw.Waiting = false;
				System.Threading.Monitor.PulseAll(fsw);
			}
		}
	}

	private void DoFiles(DefaultWatcherData data, string directory, bool dispatch)
	{
		bool flag = Directory.Exists(directory);
		if (flag && data.IncludeSubdirs)
		{
			string[] directories = Directory.GetDirectories(directory);
			foreach (string directory2 in directories)
			{
				DoFiles(data, directory2, dispatch);
			}
		}
		string[] array = null;
		array = ((!flag) ? NoStringsArray : ((!data.NoWildcards) ? Directory.GetFileSystemEntries(directory, data.FileMask) : ((!File.Exists(data.FileMask) && !Directory.Exists(data.FileMask)) ? NoStringsArray : new string[1] { data.FileMask })));
		lock (data.FilesLock)
		{
			if (data.Enabled)
			{
				IterateAndModifyFilesData(data, directory, dispatch, array);
			}
		}
	}

	private void IterateAndModifyFilesData(DefaultWatcherData data, string directory, bool dispatch, string[] files)
	{
		foreach (KeyValuePair<string, FileData> file in data.Files)
		{
			FileData value = file.Value;
			if (value.Directory == directory)
			{
				value.NotExists = true;
			}
		}
		foreach (string text in files)
		{
			if (!data.Files.TryGetValue(text, out var value2))
			{
				try
				{
					data.Files.Add(text, CreateFileData(directory, text));
				}
				catch
				{
					data.Files.Remove(text);
					continue;
				}
				if (dispatch)
				{
					DispatchEvents(data.FSW, FileAction.Added, Path.GetRelativePath(data.Directory, text));
				}
			}
			else if (value2.Directory == directory)
			{
				value2.NotExists = false;
			}
		}
		if (!dispatch)
		{
			return;
		}
		List<string> list = null;
		foreach (KeyValuePair<string, FileData> file2 in data.Files)
		{
			string key = file2.Key;
			if (file2.Value.NotExists)
			{
				if (list == null)
				{
					list = new List<string>();
				}
				list.Add(key);
				DispatchEvents(data.FSW, FileAction.Removed, Path.GetRelativePath(data.Directory, key));
			}
		}
		if (list != null)
		{
			foreach (string item in list)
			{
				data.Files.Remove(item);
			}
			list = null;
		}
		foreach (KeyValuePair<string, FileData> file3 in data.Files)
		{
			string key2 = file3.Key;
			FileData value3 = file3.Value;
			DateTime creationTime;
			DateTime lastWriteTime;
			try
			{
				creationTime = File.GetCreationTime(key2);
				lastWriteTime = File.GetLastWriteTime(key2);
			}
			catch
			{
				if (list == null)
				{
					list = new List<string>();
				}
				list.Add(key2);
				DispatchEvents(data.FSW, FileAction.Removed, Path.GetRelativePath(data.Directory, key2));
				continue;
			}
			if (creationTime != value3.CreationTime || lastWriteTime != value3.LastWriteTime)
			{
				value3.CreationTime = creationTime;
				value3.LastWriteTime = lastWriteTime;
				DispatchEvents(data.FSW, FileAction.Modified, Path.GetRelativePath(data.Directory, key2));
			}
		}
		if (list == null)
		{
			return;
		}
		foreach (string item2 in list)
		{
			data.Files.Remove(item2);
		}
	}

	private static FileData CreateFileData(string directory, string filename)
	{
		FileData fileData = new FileData();
		string path = Path.Combine(directory, filename);
		fileData.Directory = directory;
		fileData.Attributes = File.GetAttributes(path);
		fileData.CreationTime = File.GetCreationTime(path);
		fileData.LastWriteTime = File.GetLastWriteTime(path);
		return fileData;
	}
}
