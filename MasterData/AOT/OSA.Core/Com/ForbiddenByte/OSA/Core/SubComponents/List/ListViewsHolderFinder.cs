using UnityEngine;

namespace Com.ForbiddenByte.OSA.Core.SubComponents.List;

public class ListViewsHolderFinder : ViewsHolderFinder
{
	public ListViewsHolderFinder(IOSA adapter)
		: base(adapter)
	{
	}

	protected override AbstractViewsHolder GetViewsHolderFromRoot(RectTransform root)
	{
		return Adapter.GetBaseItemViewsHolderIfVisible(root);
	}
}
