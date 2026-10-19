using Com.ForbiddenByte.OSA.CustomAdapters.GridView;

namespace Com.ForbiddenByte.OSA.Core.SubComponents;

public class GridNavigationManager<TParams, TCellViewsHolder> : NavigationManager<TParams, CellGroupViewsHolder<TCellViewsHolder>> where TParams : GridParams where TCellViewsHolder : CellViewsHolder, new()
{
	protected GridAdapter<TParams, TCellViewsHolder> GridAdapter => Adapter as GridAdapter<TParams, TCellViewsHolder>;

	public GridNavigationManager(GridAdapter<TParams, TCellViewsHolder> gridAdapter)
		: base((OSA<TParams, CellGroupViewsHolder<TCellViewsHolder>>)gridAdapter)
	{
	}

	protected override ViewsHolderFinder CreateViewsHolderFinder()
	{
		return new GridViewsHolderFinder<TParams, TCellViewsHolder>(GridAdapter);
	}
}
