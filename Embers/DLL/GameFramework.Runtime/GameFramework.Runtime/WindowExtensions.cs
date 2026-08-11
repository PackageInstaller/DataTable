using System;

namespace GameFramework.Runtime;

public static class WindowExtensions
{
	public static IAsyncResult WaitDismissed(this Window window)
	{
		AsyncResult result = new AsyncResult();
		EventHandler handler = null;
		handler = delegate
		{
			window.OnDismissed -= handler;
			result.SetResult();
		};
		window.OnDismissed += handler;
		return result;
	}

	public static IAsyncResult WaitDisabled(this UIView view)
	{
		AsyncResult result = new AsyncResult();
		EventHandler handler = null;
		handler = delegate
		{
			view.OnDisabled -= handler;
			result.SetResult();
		};
		view.OnDisabled += handler;
		return result;
	}
}
