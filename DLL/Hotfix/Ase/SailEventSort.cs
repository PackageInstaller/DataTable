using System.Collections.Generic;

namespace Ase;

public class SailEventSort : Comparer<SailEventItemData>
{
	public override int Compare(SailEventItemData x, SailEventItemData y)
	{
		if (y.State.CompareTo(x.State) != 0)
		{
			return x.State.CompareTo(y.State);
		}
		if (y.Rarity.CompareTo(x.Rarity) != 0)
		{
			return y.Rarity.CompareTo(x.Rarity);
		}
		if (y.Area.CompareTo(x.Area) != 0)
		{
			return x.Area.CompareTo(y.Area);
		}
		if (y.EventId.CompareTo(x.EventId) != 0)
		{
			return y.EventId.CompareTo(x.EventId);
		}
		return 0;
	}
}
