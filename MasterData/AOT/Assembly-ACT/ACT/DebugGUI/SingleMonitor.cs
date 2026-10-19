namespace ACT.DebugGUI;

public abstract class SingleMonitor : DebugMonitor
{
	protected SingleWindow sigwnd => DebugWindowManager.instance.singleWindow;

	public static T Init<T>() where T : SingleMonitor, new()
	{
		if (DebugWindowManager.instance == null)
		{
			return null;
		}
		T val = new T();
		if (val.OnInit())
		{
			return val;
		}
		return null;
	}
}
