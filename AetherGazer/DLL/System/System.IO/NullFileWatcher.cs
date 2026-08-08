namespace System.IO;

internal class NullFileWatcher : IFileWatcher
{
	private static IFileWatcher instance;

	public void StartDispatching(object handle)
	{
	}

	public void StopDispatching(object handle)
	{
	}

	public void Dispose(object handle)
	{
	}

	public static bool GetInstance(out IFileWatcher watcher)
	{
		if (instance != null)
		{
			watcher = instance;
			return true;
		}
		instance = (watcher = new NullFileWatcher());
		return true;
	}
}
