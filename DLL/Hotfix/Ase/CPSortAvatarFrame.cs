using System.Collections.Generic;

namespace Ase;

public class CPSortAvatarFrame : Comparer<AvatarItemViewModel>
{
	public override int Compare(AvatarItemViewModel x, AvatarItemViewModel y)
	{
		if (y.State.CompareTo(x.State) != 0)
		{
			return -y.State.CompareTo(x.State);
		}
		if (y.IconFrameId.CompareTo(x.IconFrameId) != 0)
		{
			return -y.IconFrameId.CompareTo(x.IconFrameId);
		}
		return 0;
	}
}
