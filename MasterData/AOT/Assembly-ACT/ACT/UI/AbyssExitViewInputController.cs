using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;

namespace ACT.UI;

public class AbyssExitViewInputController : BaseUIViewInputController<MonoAbyssExitView>
{
	private ContinuousNavigateData _curNavigateData;

	protected override void OnEscPressed(bool value)
	{
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.Close();
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		_curNavigateData?.Reset();
		View.OnInputControllerDeviceChange(MonoECS.instance.InputMode);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		View.OnInputControllerDeviceChange(type);
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value && !(EventSystemHelper.CurrentSelected == null))
		{
			EventSystemHelper.ClickCurrent();
		}
	}
}
