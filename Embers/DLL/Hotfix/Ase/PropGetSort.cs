using System.Collections.Generic;

namespace Ase;

public class PropGetSort : Comparer<KnapsackItemViewModel>
{
	public override int Compare(KnapsackItemViewModel x, KnapsackItemViewModel y)
	{
		if (y.Quality.CompareTo(x.Quality) != 0)
		{
			return y.Quality.CompareTo(x.Quality);
		}
		if (y.PropDataBase.Id.CompareTo(x.PropDataBase.Id) != 0)
		{
			return y.PropDataBase.Id.CompareTo(x.PropDataBase.Id);
		}
		return 0;
	}
}
