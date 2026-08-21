using System.Collections.Generic;

namespace Ase;

public class CPSortTitle : Comparer<TitleItemViewModel>
{
	public override int Compare(TitleItemViewModel x, TitleItemViewModel y)
	{
		if (y.IsLock.CompareTo(x.IsLock) != 0)
		{
			return x.IsLock.CompareTo(y.IsLock);
		}
		if (y.TitleId.CompareTo(x.TitleId) != 0)
		{
			return y.TitleId.CompareTo(x.TitleId);
		}
		return 0;
	}
}
