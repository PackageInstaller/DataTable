using System;
using System.Threading.Tasks;

namespace GameFramework.Runtime;

public class AsyncWindowInteractionAction : AsyncLoadableInteractionActionBase<WindowNotification>
{
	private Window window;

	public Window Window => window;

	public AsyncWindowInteractionAction(string viewName)
		: this(viewName, null)
	{
	}

	public AsyncWindowInteractionAction(string viewName, IUIViewLocator locator)
		: base(viewName, locator)
	{
	}

	public override Task Action(WindowNotification notification)
	{
		bool ignoreAnimation = notification.IgnoreAnimation;
		return notification.WindowActionType switch
		{
			WindowActionType.CREATE => Create(notification.ViewModel), 
			WindowActionType.SHOW => Show(notification.ViewModel, notification.WaitDismissed, ignoreAnimation), 
			WindowActionType.HIDE => Hide(ignoreAnimation), 
			WindowActionType.DISMISS => Dismiss(ignoreAnimation), 
			_ => Task.CompletedTask, 
		};
	}

	protected async Task Create(object viewModel)
	{
		try
		{
			window = await LoadWindowAsync<Window>();
			if (window == null)
			{
				throw new NotFoundException($"Not found the window named \"{base.ViewName}\".");
			}
			if (viewModel != null)
			{
				window.SetDataContext(viewModel);
			}
			window.Create();
		}
		catch (Exception ex)
		{
			Exception e = ex;
			window = null;
			throw e;
		}
	}

	protected async Task Show(object viewModel, bool waitDismissed, bool ignoreAnimation = false)
	{
		try
		{
			if (window == null)
			{
				await Create(viewModel);
			}
			window.WaitDismissed().Callbackable().OnCallback(delegate
			{
				window = null;
			});
			await window.Show(ignoreAnimation);
			if (waitDismissed)
			{
				await window.WaitDismissed();
			}
		}
		catch (Exception ex)
		{
			if (window != null)
			{
				await window.Dismiss(ignoreAnimation);
			}
			window = null;
			throw ex;
		}
	}

	protected async Task Hide(bool ignoreAnimation = false)
	{
		if (window != null)
		{
			await window.Hide(ignoreAnimation);
		}
	}

	protected async Task Dismiss(bool ignoreAnimation = false)
	{
		if (window != null)
		{
			await window.Dismiss(ignoreAnimation);
		}
	}
}
