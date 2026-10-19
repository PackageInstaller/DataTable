using System.Collections.Generic;

namespace PathFinding2D.Runtime.Debugger;

public class NavigationDebugger
{
	public List<NavigationRecord> Records { get; } = new List<NavigationRecord>();

	public void AddRecord(NavigationRecord record)
	{
		Records.Add(record);
	}

	public void Clear()
	{
		Records.Clear();
	}
}
