using System.Collections.Generic;

namespace Ase;

public class HeroSortByLevelByCheck : Comparer<HeroItemViewModel>
{
	public override int Compare(HeroItemViewModel x, HeroItemViewModel y)
	{
		if (y.SeatLockTag.CompareTo(x.SeatLockTag) != 0)
		{
			return y.SeatLockTag.CompareTo(x.SeatLockTag);
		}
		if (y.HeroTryTag.CompareTo(x.HeroTryTag) != 0)
		{
			return y.HeroTryTag.CompareTo(x.HeroTryTag);
		}
		if (y.SeatId.CompareTo(x.SeatId) != 0)
		{
			return y.SeatId.CompareTo(x.SeatId);
		}
		if (y.checkVal.CompareTo(x.checkVal) != 0)
		{
			return y.checkVal.CompareTo(x.checkVal);
		}
		if (y.HeroModel.Level.CompareTo(x.HeroModel.Level) != 0)
		{
			return y.HeroModel.Level.CompareTo(x.HeroModel.Level);
		}
		if (y.HeroModel.Rarity.CompareTo(x.HeroModel.Rarity) != 0)
		{
			return y.HeroModel.Rarity.CompareTo(x.HeroModel.Rarity);
		}
		if (y.HeroModel.Attribute.CompareTo(x.HeroModel.Attribute) != 0)
		{
			return x.HeroModel.Attribute.CompareTo(y.HeroModel.Attribute);
		}
		if (y.HeroModel.Id.CompareTo(x.HeroModel.Id) != 0)
		{
			return y.HeroModel.Id.CompareTo(x.HeroModel.Id);
		}
		return 0;
	}
}
