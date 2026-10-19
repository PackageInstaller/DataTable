using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;

namespace ACT.UI;

public class PopupCharacterSkinAcquireViewInputController : BaseUIViewInputController<PopupCharacterSkinAcquireView>
{
	private ContinuousNavigateData _curNavigateState;

	private ViewControlRoot _viewControlRoot;

	protected override void OnActivate()
	{
		base.OnActivate();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		_ = 2;
	}

	[GameInputBindingBool("UI/UISpecial4")]
	private void OnMenuPress(bool isPress)
	{
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnConfirmPress(bool isPress)
	{
		if (!isPress)
		{
			EventSystemHelper.Click(View.BtnClose);
		}
	}

	[GameInputBindingBool("UI/Back")]
	private void OnBackPress(bool isPress)
	{
		if (!isPress)
		{
			View.Close();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	private void OnUISpecial2(bool isPress)
	{
		if (!isPress)
		{
			EventSystemHelper.Click(View.BtnJump);
		}
	}

	private void UpdateGamepadTips()
	{
		View.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction);
	}
}
