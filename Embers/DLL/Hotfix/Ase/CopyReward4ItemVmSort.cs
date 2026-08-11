using System.Collections.Generic;

namespace Ase;

public class CopyReward4ItemVmSort : Comparer<CopyReward4ItemViewModel>
{
	public override int Compare(CopyReward4ItemViewModel x, CopyReward4ItemViewModel y)
	{
		if (x.State.CompareTo(y.State) != 0)
		{
			return x.State.CompareTo(y.State);
		}
		if (x.CopyZoneType.CompareTo(y.CopyZoneType) != 0)
		{
			return x.CopyZoneType.CompareTo(y.CopyZoneType);
		}
		if (x.Count.CompareTo(y.Count) != 0)
		{
			return x.Count.CompareTo(y.Count);
		}
		return 0;
	}
}
