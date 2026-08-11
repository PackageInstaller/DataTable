using System.Collections.Generic;

namespace Ase;

public class CopyType2Sort : Comparer<CopyTypeItemViewModel>
{
	public override int Compare(CopyTypeItemViewModel x, CopyTypeItemViewModel y)
	{
		if (y.Data.CopyTypeId.CompareTo(x.Data.CopyTypeId) != 0)
		{
			return x.Data.CopyTypeId.CompareTo(y.Data.CopyTypeId);
		}
		return 0;
	}
}
