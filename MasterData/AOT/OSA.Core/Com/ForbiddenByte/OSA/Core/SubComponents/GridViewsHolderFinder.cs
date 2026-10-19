using Com.ForbiddenByte.OSA.CustomAdapters.GridView;
using UnityEngine;

namespace Com.ForbiddenByte.OSA.Core.SubComponents;

public class GridViewsHolderFinder<TParams, TCellViewsHolder> : ViewsHolderFinder where TParams : GridParams where TCellViewsHolder : CellViewsHolder, new()
{
	private readonly GridAdapter<TParams, TCellViewsHolder> _GridAdapter;

	protected GridAdapter<TParams, TCellViewsHolder> GridAdapter => _GridAdapter;

	public GridViewsHolderFinder(GridAdapter<TParams, TCellViewsHolder> gridAdapter)
		: base(gridAdapter)
	{
		_GridAdapter = gridAdapter;
	}

	protected override AbstractViewsHolder GetViewsHolderFromRoot(RectTransform root)
	{
		return _GridAdapter.GetCellViewsHolderIfVisible(root);
	}
}
