using System.Collections.Generic;

namespace Ase;

public class BattleRewardItemSort : Comparer<KnapsackItemViewModel>
{
	public override int Compare(KnapsackItemViewModel x, KnapsackItemViewModel y)
	{
		if (y.ExValue.CompareTo(x.ExValue) != 0)
		{
			return y.ExValue.CompareTo(x.ExValue);
		}
		if (y.Quality.CompareTo(x.Quality) != 0)
		{
			return y.Quality.CompareTo(x.Quality);
		}
		if (y.PropDataBase.PropTypeEnum.CompareTo(x.PropDataBase.PropTypeEnum) != 0)
		{
			return y.PropDataBase.PropTypeEnum.CompareTo(x.PropDataBase.PropTypeEnum);
		}
		if (y.PropDataBase.Id.CompareTo(x.PropDataBase.Id) != 0)
		{
			return y.PropDataBase.Id.CompareTo(x.PropDataBase.Id);
		}
		return 0;
	}
}
