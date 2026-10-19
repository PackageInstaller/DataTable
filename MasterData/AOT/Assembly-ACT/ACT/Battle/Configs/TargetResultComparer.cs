using System.Collections.Generic;

namespace ACT.Battle.Configs;

public abstract class TargetResultComparer : IComparer<FindTargetResult>
{
	public bool inverse;

	int IComparer<FindTargetResult>.Compare(FindTargetResult x, FindTargetResult y)
	{
		int num = Compare(x, y);
		if (inverse)
		{
			num = -num;
		}
		return num;
	}

	public abstract int Compare(FindTargetResult x, FindTargetResult y);
}
