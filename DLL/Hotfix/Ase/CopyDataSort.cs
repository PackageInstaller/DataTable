using System.Collections.Generic;

namespace Ase;

public class CopyDataSort : Comparer<CopyData>
{
	public override int Compare(CopyData x, CopyData y)
	{
		if (x.CopyRank.CompareTo(y.CopyRank) != 0)
		{
			return x.CopyRank.CompareTo(y.CopyRank);
		}
		return 0;
	}
}
