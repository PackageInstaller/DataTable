using System.Collections.Generic;

namespace Ase;

public class BPDataNewSort : Comparer<BPData>
{
	public override int Compare(BPData x, BPData y)
	{
		if (y.IsLock.CompareTo(x.IsLock) != 0)
		{
			return x.IsLock.CompareTo(y.IsLock);
		}
		if (y.Quality.CompareTo(x.Quality) != 0)
		{
			return y.Quality.CompareTo(x.Quality);
		}
		if (y.Type.CompareTo(x.Type) != 0)
		{
			return x.Type.CompareTo(y.Type);
		}
		if (y.Id.CompareTo(x.Id) != 0)
		{
			return x.Id.CompareTo(y.Id);
		}
		return 0;
	}
}
