namespace GameFramework.Runtime;

public class WindowNotification
{
	public bool IgnoreAnimation { get; private set; }

	public WindowActionType WindowActionType { get; private set; }

	public object ViewModel { get; private set; }

	public bool WaitDismissed { get; private set; }

	public static WindowNotification CreateShowNotification(bool ignoreAnimation = true, bool waitDismissed = false)
	{
		return new WindowNotification(WindowActionType.SHOW, ignoreAnimation, null, waitDismissed);
	}

	public static WindowNotification CreateShowNotification(object viewModel, bool ignoreAnimation = true, bool waitDismissed = false)
	{
		return new WindowNotification(WindowActionType.SHOW, ignoreAnimation, viewModel, waitDismissed);
	}

	public static WindowNotification CreateHideNotification(bool ignoreAnimation = true)
	{
		return new WindowNotification(WindowActionType.HIDE, ignoreAnimation);
	}

	public static WindowNotification CreateDismissNotification(bool ignoreAnimation = true)
	{
		return new WindowNotification(WindowActionType.DISMISS, ignoreAnimation);
	}

	public WindowNotification(WindowActionType windowActionType)
		: this(windowActionType, ignoreAnimation: true, null)
	{
	}

	public WindowNotification(WindowActionType windowActionType, bool ignoreAnimation)
		: this(windowActionType, ignoreAnimation, null)
	{
	}

	public WindowNotification(WindowActionType windowActionType, object viewModel, bool waitDismissed = false)
		: this(windowActionType, ignoreAnimation: true, viewModel, waitDismissed)
	{
	}

	public WindowNotification(WindowActionType windowActionType, bool ignoreAnimation, object viewModel, bool waitDismissed = false)
	{
		IgnoreAnimation = ignoreAnimation;
		WindowActionType = windowActionType;
		ViewModel = viewModel;
		WaitDismissed = waitDismissed;
	}
}
