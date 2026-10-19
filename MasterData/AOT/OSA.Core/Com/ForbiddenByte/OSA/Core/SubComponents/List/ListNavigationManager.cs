namespace Com.ForbiddenByte.OSA.Core.SubComponents.List;

public class ListNavigationManager<TParams, TItemViewsHolder> : NavigationManager<TParams, TItemViewsHolder> where TParams : BaseParams where TItemViewsHolder : BaseItemViewsHolder
{
	public ListNavigationManager(OSA<TParams, TItemViewsHolder> adapter)
		: base(adapter)
	{
	}

	protected override ViewsHolderFinder CreateViewsHolderFinder()
	{
		return new ListViewsHolderFinder(Adapter);
	}
}
