namespace GameFramework.Runtime;

public class VisibilityNotification
{
	public bool Visible { get; private set; }

	public object ViewModel { get; private set; }

	public bool WaitDisabled { get; private set; }

	public static VisibilityNotification CreateShowNotification(bool waitDisabled = false)
	{
		return new VisibilityNotification(visible: true, null, waitDisabled);
	}

	public static VisibilityNotification CreateShowNotification(object viewModel, bool waitDisabled = false)
	{
		return new VisibilityNotification(visible: true, viewModel, waitDisabled);
	}

	public static VisibilityNotification CreateHideNotification()
	{
		return new VisibilityNotification(visible: false);
	}

	public VisibilityNotification(bool visible)
		: this(visible, null)
	{
	}

	public VisibilityNotification(bool visible, object viewModel)
		: this(visible, viewModel, waitDisabled: false)
	{
	}

	public VisibilityNotification(bool visible, object viewModel, bool waitDisabled)
	{
		Visible = visible;
		ViewModel = viewModel;
		WaitDisabled = waitDisabled;
	}
}
