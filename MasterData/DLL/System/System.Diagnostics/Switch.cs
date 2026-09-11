using System.Collections.Generic;

namespace System.Diagnostics;

public abstract class Switch
{
	private readonly string description;

	private readonly string displayName;

	private volatile string switchValueString = string.Empty;

	private string defaultValue;

	private static List<WeakReference> switches = new List<WeakReference>();

	private static int s_LastCollectionCount;

	protected Switch(string displayName, string description)
		: this(displayName, description, "0")
	{
	}

	protected Switch(string displayName, string description, string defaultSwitchValue)
	{
		if (displayName == null)
		{
			displayName = string.Empty;
		}
		this.displayName = displayName;
		this.description = description;
		lock (switches)
		{
			_pruneCachedSwitches();
			switches.Add(new WeakReference(this));
		}
		defaultValue = defaultSwitchValue;
	}

	private static void _pruneCachedSwitches()
	{
		lock (switches)
		{
			if (s_LastCollectionCount == GC.CollectionCount(2))
			{
				return;
			}
			List<WeakReference> list = new List<WeakReference>(switches.Count);
			for (int i = 0; i < switches.Count; i++)
			{
				if ((Switch)switches[i].Target != null)
				{
					list.Add(switches[i]);
				}
			}
			if (list.Count < switches.Count)
			{
				switches.Clear();
				switches.AddRange(list);
				switches.TrimExcess();
			}
			s_LastCollectionCount = GC.CollectionCount(2);
		}
	}
}
