using System.Collections.Generic;

namespace Ase;

public class FarmSeedItemSort : Comparer<HLSeedItemData>
{
	public override int Compare(HLSeedItemData x, HLSeedItemData y)
	{
		if (y.IsLock.CompareTo(x.IsLock) != 0)
		{
			return x.IsLock.CompareTo(y.IsLock);
		}
		if (y.SeedId.CompareTo(x.SeedId) != 0)
		{
			return x.SeedId.CompareTo(y.SeedId);
		}
		return 0;
	}
}
