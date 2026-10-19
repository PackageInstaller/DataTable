using UnityEngine;
using UnityEngine.EventSystems;

namespace Com.ForbiddenByte.OSA.Core.SubComponents;

public abstract class BaseNavigationManager
{
	private float _DurationOfLastAnimatedBringToView;

	private float _OSATimeOnLastAnimatedBringToView;

	private SelectionWatcher _SelectionWatcher;

	public ViewsHolderFinder ViewsHolderFinder { get; private set; }

	protected IOSA Adapter { get; private set; }

	protected GameObject LastSelectedObject { get; private set; }

	protected BaseParams.NavigationParams NavParams => Adapter.BaseParameters.Navigation;

	public BaseNavigationManager(IOSA adapter)
	{
		Adapter = adapter;
		ViewsHolderFinder = CreateViewsHolderFinder();
		_SelectionWatcher = new SelectionWatcher();
		_SelectionWatcher.NewObjectSelected += SelectionWatcher_NewObjectSelected;
	}

	public virtual void OnUpdate()
	{
		_SelectionWatcher.Enabled = NavParams.Enabled;
		_SelectionWatcher.OnUpdate();
	}

	protected abstract ViewsHolderFinder CreateViewsHolderFinder();

	protected virtual GameObject GetCurrentlySelectedObject()
	{
		if (!EventSystem.current)
		{
			return null;
		}
		return EventSystem.current.currentSelectedGameObject;
	}

	public virtual float GetMaxInputModuleActionsPerSecondToExpect()
	{
		if (!EventSystem.current)
		{
			return 1f;
		}
		if (!EventSystem.current.currentInputModule)
		{
			return 1f;
		}
		StandaloneInputModule standaloneInputModule = EventSystem.current.currentInputModule as StandaloneInputModule;
		if (!standaloneInputModule)
		{
			return 1f;
		}
		return standaloneInputModule.inputActionsPerSecond;
	}

	protected virtual void OnNewObjectSelected(GameObject curSelected)
	{
		AbstractViewsHolder viewsHolderFromSelectedGameObject = ViewsHolderFinder.GetViewsHolderFromSelectedGameObject(curSelected);
		if (viewsHolderFromSelectedGameObject != null)
		{
			AssureItemFullyVisible(viewsHolderFromSelectedGameObject.ItemIndex);
		}
	}

	protected void AssureItemFullyVisible(int itemIndex)
	{
		BaseParams baseParameters = Adapter.BaseParameters;
		float num = baseParameters.DefaultItemSize / 2f;
		if (num < baseParameters.ContentSpacing)
		{
			num = baseParameters.ContentSpacing;
		}
		num += baseParameters.ContentSpacing;
		num += NavParams.AdditionalSpacingTowardsEdge;
		float scrollDuration = NavParams.ScrollDuration;
		scrollDuration = Mathf.Clamp01(scrollDuration);
		float maxInputModuleActionsPerSecondToExpect = GetMaxInputModuleActionsPerSecondToExpect();
		float num2 = 1f / maxInputModuleActionsPerSecondToExpect;
		scrollDuration = Mathf.Clamp(scrollDuration, 0f, num2 - 0.05f);
		float num3;
		if (scrollDuration == 0f || Adapter.DeltaTime > scrollDuration / 2f)
		{
			num3 = 0f;
		}
		else
		{
			float num4 = Adapter.Time - _OSATimeOnLastAnimatedBringToView;
			if (num4 < 0f)
			{
				num4 = 0f;
			}
			num3 = ((!(num4 < _DurationOfLastAnimatedBringToView)) ? scrollDuration : 0f);
		}
		_DurationOfLastAnimatedBringToView = num3;
		if (num3 == 0f)
		{
			_OSATimeOnLastAnimatedBringToView = 0f;
			if (NavParams.Centered)
			{
				Adapter.ScrollTo(itemIndex, 0.5f, 0.5f);
			}
			else
			{
				Adapter.BringToView(itemIndex, num);
			}
		}
		else
		{
			_OSATimeOnLastAnimatedBringToView = Adapter.Time;
			if (NavParams.Centered)
			{
				Adapter.SmoothScrollTo(itemIndex, num3, 0.5f, 0.5f, null, null, overrideCurrentScrollingAnimation: true);
			}
			else
			{
				Adapter.SmoothBringToView(itemIndex, num3, num, null, null, overrideCurrentScrollingAnimation: true);
			}
		}
	}

	private void SelectionWatcher_NewObjectSelected(GameObject lastGO, GameObject newGO)
	{
		OnNewObjectSelected(newGO);
	}
}
