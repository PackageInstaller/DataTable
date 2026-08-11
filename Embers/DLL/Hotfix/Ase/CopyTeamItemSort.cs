using System.Collections.Generic;

namespace Ase;

public class CopyTeamItemSort : Comparer<CopyTeamItemViewModel>
{
	public override int Compare(CopyTeamItemViewModel x, CopyTeamItemViewModel y)
	{
		if (y.Pos.CompareTo(x.Pos) != 0)
		{
			return y.Pos.CompareTo(x.Pos);
		}
		return 0;
	}
}
