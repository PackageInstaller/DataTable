using UnityEngine;

namespace Com.ForbiddenByte.OSA.Core.SubComponents;

public abstract class ViewsHolderFinder
{
	protected IOSA Adapter { get; private set; }

	protected BaseParams.NavigationParams NavParams => Adapter.BaseParameters.Navigation;

	public ViewsHolderFinder(IOSA adapter)
	{
		Adapter = adapter;
	}

	public virtual AbstractViewsHolder GetViewsHolderFromSelectedGameObject(GameObject curSelected)
	{
		int num = 0;
		int maxSearchDepthForViewsHolder = NavParams.MaxSearchDepthForViewsHolder;
		Transform transform = curSelected.transform;
		while ((bool)transform && num <= maxSearchDepthForViewsHolder)
		{
			AbstractViewsHolder viewsHolderFromRoot = GetViewsHolderFromRoot(transform as RectTransform);
			if (viewsHolderFromRoot != null)
			{
				return viewsHolderFromRoot;
			}
			transform = transform.parent;
			num++;
		}
		return null;
	}

	protected abstract AbstractViewsHolder GetViewsHolderFromRoot(RectTransform root);
}
