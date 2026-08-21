using System.Collections.Generic;

namespace Ase;

public class WeaknessComparer : IComparer<WeaknessStateInfo>
{
	public int Compare(WeaknessStateInfo x, WeaknessStateInfo y)
	{
		if (!(x.EndTimer < y.EndTimer))
		{
			return 1;
		}
		return -1;
	}
}
