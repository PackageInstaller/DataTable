using System.Collections.Generic;

namespace Ase;

public class HomelandFriendSort : Comparer<HomelandFriendItemViewModel>
{
	public override int Compare(HomelandFriendItemViewModel x, HomelandFriendItemViewModel y)
	{
		if (y.Data.HomelandLevel.CompareTo(x.Data.HomelandLevel) != 0)
		{
			return y.Data.HomelandLevel.CompareTo(x.Data.HomelandLevel);
		}
		if (y.Data.Uid.CompareTo(x.Data.Uid) != 0)
		{
			return y.Data.Uid.CompareTo(x.Data.Uid);
		}
		return 0;
	}
}
