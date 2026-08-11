using System.Collections.Generic;

namespace Ase;

public class GuidancePriorityCompare : IComparer<GuidanceManager.GuidanceGroup>
{
	public int Compare(GuidanceManager.GuidanceGroup x, GuidanceManager.GuidanceGroup y)
	{
		return y.Priority.CompareTo(x.Priority);
	}
}
