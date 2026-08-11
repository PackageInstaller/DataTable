using System.Collections.Generic;

namespace Ase;

public class MultiRoomHeroSort : Comparer<HeroModel>
{
	public override int Compare(HeroModel x, HeroModel y)
	{
		if (y.Level.CompareTo(x.Level) != 0)
		{
			return x.Level.CompareTo(y.Level);
		}
		if (y.Rarity.CompareTo(x.Rarity) != 0)
		{
			return x.Rarity.CompareTo(y.Rarity);
		}
		return 0;
	}
}
