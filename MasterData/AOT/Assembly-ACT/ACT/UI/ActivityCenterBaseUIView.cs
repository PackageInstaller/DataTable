using ACT.Battle;

namespace ACT.UI;

public abstract class ActivityCenterBaseUIView<T> : SubUIView<T>, IActivityCenterSubUIView, ISubUIView, IBaseUIComponent where T : class, ISubInputController, new()
{
	public ActivityCenterView ActivityCenterView { get; set; }

	protected override void OnFocusOut()
	{
		base.OnFocusOut();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputDeviceChange);
		UnInit();
	}

	protected virtual void UnInit()
	{
	}

	protected override void OnFocusIn()
	{
		base.OnFocusIn();
		MonoECS.instance.onInputModeChange.AddListener(OnInputDeviceChange);
		Init();
	}

	protected virtual void Init()
	{
	}

	public virtual void OnPopStack()
	{
	}

	public virtual void OnPushStack()
	{
	}
}
