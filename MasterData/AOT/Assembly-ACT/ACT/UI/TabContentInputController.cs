using ACT.Battle;
using ACT.UI.Interface;
using ACT.ViewControl;

namespace ACT.UI;

public class TabContentInputController : TabContentInputController<BaseTabContent>
{
}
public abstract class TabContentInputController<T> : SubUIViewInputController<T>, ITabContentInputController, ISubInputController, IInputController, IGameInputBindingHandle where T : BaseUIComponent
{
	protected ViewControlRoot ViewControlRoot { get; set; }

	protected ViewControlLayer ViewControlLayer { get; set; }

	protected override void OnInitView(T view)
	{
		base.OnInitView(view);
		if (!(View == null))
		{
			ViewControlRoot = View.GetComponentInParent<ViewControlRoot>();
			ViewControlLayer = View.GetComponentInChildren<ViewControlLayer>();
		}
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			ViewControlLayer?.ReFocus();
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		FocusViewControlLayer();
	}

	public virtual void OnTabActive(ITabItem tabItem)
	{
		ViewControlLayer?.Focus();
	}

	public virtual void OnTabDeActive(ITabItem tabItem)
	{
		ViewControlLayer?.UnFocus();
	}

	protected void FocusViewControlLayer()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			ViewControlLayer?.ReFocus();
		}
	}
}
