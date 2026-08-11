using System.Collections.Generic;

namespace Ase;

public class HeroItemSortBySail : Comparer<HeroItemViewModel>
{
	public override int Compare(HeroItemViewModel x, HeroItemViewModel y)
	{
		if (y.IsChecked.CompareTo(x.IsChecked) != 0)
		{
			return x.IsChecked.CompareTo(y.IsChecked);
		}
		if (y.MarkValue.CompareTo(x.MarkValue) != 0)
		{
			return y.MarkValue.CompareTo(x.MarkValue);
		}
		if (y.HeroModel.Rarity.CompareTo(x.HeroModel.Rarity) != 0)
		{
			return y.HeroModel.Rarity.CompareTo(x.HeroModel.Rarity);
		}
		if (y.HeroModel.Id.CompareTo(x.HeroModel.Id) != 0)
		{
			return y.HeroModel.Id.CompareTo(x.HeroModel.Id);
		}
		return 0;
	}
}
