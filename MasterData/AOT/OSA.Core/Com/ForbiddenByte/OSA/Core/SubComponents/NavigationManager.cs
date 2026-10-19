namespace Com.ForbiddenByte.OSA.Core.SubComponents;

public abstract class NavigationManager<TParams, TItemViewsHolder> : BaseNavigationManager where TParams : BaseParams where TItemViewsHolder : BaseItemViewsHolder
{
	protected new OSA<TParams, TItemViewsHolder> Adapter => base.Adapter as OSA<TParams, TItemViewsHolder>;

	public NavigationManager(OSA<TParams, TItemViewsHolder> adapter)
		: base(adapter)
	{
	}
}
