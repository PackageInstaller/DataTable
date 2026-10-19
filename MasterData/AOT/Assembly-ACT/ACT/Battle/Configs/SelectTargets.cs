using System;
using System.Collections.Generic;

namespace ACT.Battle.Configs;

[Serializable]
public class SelectTargets
{
	public enum FilterType
	{
		Nearest,
		Farthest
	}

	public FilterType filterType;

	public int count;

	public static int Ascendent(FindTargetResult x, FindTargetResult y)
	{
		return x.sqrDis.CompareTo(y.sqrDis);
	}

	public static int Decendent(FindTargetResult x, FindTargetResult y)
	{
		return y.sqrDis.CompareTo(x.sqrDis);
	}

	public void Filter(List<FindTargetResult> results)
	{
		Filter(results, filterType, count);
	}

	public static void Filter(List<FindTargetResult> results, FilterType filterType, int count)
	{
		switch (filterType)
		{
		case FilterType.Nearest:
			results.Sort(Ascendent);
			break;
		case FilterType.Farthest:
			results.Sort(Decendent);
			break;
		}
		if (results.Count > count)
		{
			results.RemoveRange(count, results.Count - count);
		}
	}
}
