using System.Collections.Generic;

namespace Ase;

public class CPSortAvatar : Comparer<AvatarItemViewModel>
{
	public override int Compare(AvatarItemViewModel x, AvatarItemViewModel y)
	{
		if (y.State.CompareTo(x.State) != 0)
		{
			return -y.State.CompareTo(x.State);
		}
		if (y.IconId.CompareTo(x.IconId) != 0)
		{
			return -y.IconId.CompareTo(x.IconId);
		}
		return 0;
	}
}
