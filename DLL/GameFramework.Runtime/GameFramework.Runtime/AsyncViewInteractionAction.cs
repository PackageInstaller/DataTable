using System;
using System.Threading.Tasks;
using UnityEngine;

namespace GameFramework.Runtime;

public class AsyncViewInteractionAction : AsyncLoadableInteractionActionBase<VisibilityNotification>
{
	private UIView view;

	private bool autoDestroy;

	public UIView View => view;

	public AsyncViewInteractionAction(string viewName, bool autoDestroy = true)
		: this(viewName, null, autoDestroy)
	{
	}

	public AsyncViewInteractionAction(string viewName, IUIViewLocator locator, bool autoDestroy = true)
		: base(viewName, locator)
	{
		this.autoDestroy = autoDestroy;
	}

	public AsyncViewInteractionAction(UIView view, bool autoDestroy = false)
		: base((string)null, (IUIViewLocator)null)
	{
		this.view = view;
		this.autoDestroy = autoDestroy;
	}

	public override Task Action(VisibilityNotification notification)
	{
		if (notification.Visible)
		{
			return Show(notification.ViewModel, notification.WaitDisabled);
		}
		return Hide();
	}

	protected async Task Show(object viewModel, bool waitDisabled)
	{
		try
		{
			if (view == null)
			{
				view = await LoadViewAsync<UIView>();
			}
			if (view == null)
			{
				throw new NotFoundException($"Not found the view named \"{base.ViewName}\".");
			}
			if (autoDestroy)
			{
				view.WaitDisabled().Callbackable().OnCallback(delegate
				{
					view = null;
				});
			}
			if (viewModel != null)
			{
				view.SetDataContext(viewModel);
			}
			view.Visibility = true;
			if (waitDisabled)
			{
				await view.WaitDisabled();
			}
		}
		catch (Exception ex)
		{
			Exception e = ex;
			if (autoDestroy)
			{
				Destroy();
			}
			throw e;
		}
	}

	protected Task Hide()
	{
		if (view != null)
		{
			view.Visibility = false;
			if (autoDestroy)
			{
				Destroy();
			}
		}
		return Task.CompletedTask;
	}

	private void Destroy()
	{
		if (!(view == null))
		{
			GameObject owner = view.Owner;
			if (owner != null)
			{
				UnityEngine.Object.Destroy(owner);
			}
			view = null;
		}
	}
}
