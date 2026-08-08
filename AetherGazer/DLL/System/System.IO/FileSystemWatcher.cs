using System.ComponentModel;
using System.Threading.Tasks;

namespace System.IO;

[IODescription("")]
[DefaultEvent("Changed")]
public class FileSystemWatcher : Component, ISupportInitialize
{
	private enum EventType
	{
		FileSystemEvent,
		ErrorEvent,
		RenameEvent
	}

	private bool inited;

	private bool start_requested;

	private bool enableRaisingEvents;

	private string filter;

	private bool includeSubdirectories;

	private int internalBufferSize;

	private NotifyFilters notifyFilter;

	private string path;

	private string fullpath;

	private ISynchronizeInvoke synchronizingObject;

	private WaitForChangedResult lastData;

	private bool waiting;

	private SearchPattern2 pattern;

	private bool disposed;

	private string mangledFilter;

	private IFileWatcher watcher;

	private object watcher_handle;

	private static object lockobj = new object();

	internal bool Waiting
	{
		get
		{
			return waiting;
		}
		set
		{
			waiting = value;
		}
	}

	internal string MangledFilter
	{
		get
		{
			if (filter != "*.*")
			{
				return filter;
			}
			if (mangledFilter != null)
			{
				return mangledFilter;
			}
			return "*.*";
		}
	}

	internal SearchPattern2 Pattern
	{
		get
		{
			if (pattern == null)
			{
				pattern = new SearchPattern2(MangledFilter);
			}
			return pattern;
		}
	}

	internal string FullPath
	{
		get
		{
			if (fullpath == null)
			{
				if (path == null || path == "")
				{
					fullpath = Environment.CurrentDirectory;
				}
				else
				{
					fullpath = System.IO.Path.GetFullPath(path);
				}
			}
			return fullpath;
		}
	}

	[DefaultValue(false)]
	[IODescription("Flag to indicate if this instance is active")]
	public bool EnableRaisingEvents
	{
		set
		{
			if (disposed)
			{
				throw new ObjectDisposedException(GetType().Name);
			}
			start_requested = true;
			if (inited && value != enableRaisingEvents)
			{
				enableRaisingEvents = value;
				if (value)
				{
					Start();
					return;
				}
				Stop();
				start_requested = false;
			}
		}
	}

	[IODescription("File name filter pattern")]
	[DefaultValue("*.*")]
	[SettingsBindable(true)]
	[TypeConverter("System.Diagnostics.Design.StringValueConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
	public string Filter
	{
		get
		{
			return filter;
		}
		set
		{
			if (value == null || value == "")
			{
				value = "*";
			}
			if (!string.Equals(filter, value, PathInternal.StringComparison))
			{
				filter = ((value == "*.*") ? "*" : value);
				pattern = null;
				mangledFilter = null;
			}
		}
	}

	[IODescription("Flag to indicate we want to watch subdirectories")]
	[DefaultValue(false)]
	public bool IncludeSubdirectories => includeSubdirectories;

	[DefaultValue(NotifyFilters.DirectoryName | NotifyFilters.FileName | NotifyFilters.LastWrite)]
	[IODescription("Flag to indicate which change event we want to monitor")]
	public NotifyFilters NotifyFilter
	{
		set
		{
			if (notifyFilter != value)
			{
				notifyFilter = value;
				if (enableRaisingEvents)
				{
					Stop();
					Start();
				}
			}
		}
	}

	[SettingsBindable(true)]
	[DefaultValue("")]
	[TypeConverter("System.Diagnostics.Design.StringValueConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
	[Editor("System.Diagnostics.Design.FSWPathEditor, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "System.Drawing.Design.UITypeEditor, System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
	[IODescription("The directory to monitor")]
	public string Path
	{
		get
		{
			return path;
		}
		set
		{
			if (disposed)
			{
				throw new ObjectDisposedException(GetType().Name);
			}
			value = ((value == null) ? string.Empty : value);
			if (!string.Equals(path, value, PathInternal.StringComparison))
			{
				bool flag = false;
				Exception ex = null;
				try
				{
					flag = Directory.Exists(value);
				}
				catch (Exception ex2)
				{
					ex = ex2;
				}
				if (ex != null)
				{
					throw new ArgumentException(global::SR.Format("The directory name {0} is invalid.", value), "Path");
				}
				if (!flag)
				{
					throw new ArgumentException(global::SR.Format("The directory name '{0}' does not exist.", value), "Path");
				}
				path = value;
				fullpath = null;
				if (enableRaisingEvents)
				{
					Stop();
					Start();
				}
			}
		}
	}

	[Browsable(false)]
	public override ISite Site
	{
		get
		{
			return base.Site;
		}
		set
		{
			base.Site = value;
			if (Site != null && Site.DesignMode)
			{
				EnableRaisingEvents = true;
			}
		}
	}

	[IODescription("Occurs when a file/directory change matches the filter")]
	public event FileSystemEventHandler Changed;

	[IODescription("Occurs when a file/directory creation matches the filter")]
	public event FileSystemEventHandler Created;

	[IODescription("Occurs when a file/directory deletion matches the filter")]
	public event FileSystemEventHandler Deleted;

	[Browsable(false)]
	public event ErrorEventHandler Error;

	[IODescription("Occurs when a file/directory rename matches the filter")]
	public event RenamedEventHandler Renamed;

	public FileSystemWatcher()
	{
		notifyFilter = NotifyFilters.DirectoryName | NotifyFilters.FileName | NotifyFilters.LastWrite;
		enableRaisingEvents = false;
		filter = "*";
		includeSubdirectories = false;
		internalBufferSize = 8192;
		path = "";
		InitWatcher();
	}

	private void InitWatcher()
	{
		lock (lockobj)
		{
			if (watcher_handle != null)
			{
				return;
			}
			string environmentVariable = Environment.GetEnvironmentVariable("MONO_MANAGED_WATCHER");
			bool flag = false;
			if (0 == 0 || !flag)
			{
				if (string.Compare(environmentVariable, "disabled", ignoreCase: true) == 0)
				{
					NullFileWatcher.GetInstance(out watcher);
				}
				else
				{
					DefaultWatcher.GetInstance(out watcher);
					watcher_handle = this;
				}
			}
			inited = true;
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (!disposed)
		{
			try
			{
				watcher?.StopDispatching(watcher_handle);
				watcher?.Dispose(watcher_handle);
			}
			catch (Exception)
			{
			}
			watcher_handle = null;
			watcher = null;
			disposed = true;
			base.Dispose(disposing);
			GC.SuppressFinalize(this);
		}
	}

	~FileSystemWatcher()
	{
		if (!disposed)
		{
			Dispose(disposing: false);
		}
	}

	public void EndInit()
	{
		inited = true;
		if (start_requested)
		{
			EnableRaisingEvents = true;
		}
	}

	private void RaiseEvent(Delegate ev, EventArgs arg, EventType evtype)
	{
		if (disposed || (object)ev == null)
		{
			return;
		}
		if (synchronizingObject == null)
		{
			Delegate[] invocationList = ev.GetInvocationList();
			foreach (Delegate obj in invocationList)
			{
				switch (evtype)
				{
				case EventType.RenameEvent:
					((RenamedEventHandler)obj)(this, (RenamedEventArgs)arg);
					break;
				case EventType.ErrorEvent:
					((ErrorEventHandler)obj)(this, (ErrorEventArgs)arg);
					break;
				case EventType.FileSystemEvent:
					((FileSystemEventHandler)obj)(this, (FileSystemEventArgs)arg);
					break;
				}
			}
		}
		else
		{
			synchronizingObject.BeginInvoke(ev, new object[2] { this, arg });
		}
	}

	protected void OnChanged(FileSystemEventArgs e)
	{
		RaiseEvent(Changed, e, EventType.FileSystemEvent);
	}

	protected void OnCreated(FileSystemEventArgs e)
	{
		RaiseEvent(Created, e, EventType.FileSystemEvent);
	}

	protected void OnDeleted(FileSystemEventArgs e)
	{
		RaiseEvent(Deleted, e, EventType.FileSystemEvent);
	}

	protected void OnRenamed(RenamedEventArgs e)
	{
		RaiseEvent(Renamed, e, EventType.RenameEvent);
	}

	internal void DispatchEvents(FileAction act, string filename, ref RenamedEventArgs renamed)
	{
		if (disposed)
		{
			return;
		}
		if (waiting)
		{
			lastData = default(WaitForChangedResult);
		}
		switch (act)
		{
		case FileAction.Added:
			lastData.Name = filename;
			lastData.ChangeType = WatcherChangeTypes.Created;
			Task.Run(delegate
			{
				OnCreated(new FileSystemEventArgs(WatcherChangeTypes.Created, path, filename));
			});
			break;
		case FileAction.Removed:
			lastData.Name = filename;
			lastData.ChangeType = WatcherChangeTypes.Deleted;
			Task.Run(delegate
			{
				OnDeleted(new FileSystemEventArgs(WatcherChangeTypes.Deleted, path, filename));
			});
			break;
		case FileAction.Modified:
			lastData.Name = filename;
			lastData.ChangeType = WatcherChangeTypes.Changed;
			Task.Run(delegate
			{
				OnChanged(new FileSystemEventArgs(WatcherChangeTypes.Changed, path, filename));
			});
			break;
		case FileAction.RenamedOldName:
			if (renamed != null)
			{
				OnRenamed(renamed);
			}
			lastData.OldName = filename;
			lastData.ChangeType = WatcherChangeTypes.Renamed;
			renamed = new RenamedEventArgs(WatcherChangeTypes.Renamed, path, filename, "");
			break;
		case FileAction.RenamedNewName:
		{
			lastData.Name = filename;
			lastData.ChangeType = WatcherChangeTypes.Renamed;
			if (renamed == null)
			{
				renamed = new RenamedEventArgs(WatcherChangeTypes.Renamed, path, "", filename);
			}
			RenamedEventArgs renamed_ref = renamed;
			Task.Run(delegate
			{
				OnRenamed(renamed_ref);
			});
			renamed = null;
			break;
		}
		}
	}

	private void Start()
	{
		if (!disposed && watcher_handle != null)
		{
			watcher?.StartDispatching(watcher_handle);
		}
	}

	private void Stop()
	{
		if (!disposed && watcher_handle != null)
		{
			watcher?.StopDispatching(watcher_handle);
		}
	}
}
