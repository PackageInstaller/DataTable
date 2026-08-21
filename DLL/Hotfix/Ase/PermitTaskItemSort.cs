using System.Collections.Generic;

namespace Ase;

public class PermitTaskItemSort : Comparer<PermitTaskItemViewModel>
{
	public override int Compare(PermitTaskItemViewModel x, PermitTaskItemViewModel y)
	{
		if (y.Data.IsComplete.CompareTo(x.Data.IsComplete) != 0)
		{
			return x.Data.IsComplete.CompareTo(y.Data.IsComplete);
		}
		return 0;
	}
}
