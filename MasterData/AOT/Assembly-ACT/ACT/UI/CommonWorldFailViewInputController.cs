using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;

namespace ACT.UI;

public class CommonWorldFailViewInputController : BaseUIViewInputController<CommonWorldFailView>
{
	private ContinuousNavigateData _curNavigateData;

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			EventSystemHelper.Click(View.ExitRaid);
		}
	}

	protected override void OnEscPressed(bool value)
	{
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.SetPowerBarPromptActive(active: true);
		View.OnControllerActivate();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
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

	[GameInputBindingBool("UI/RightStickPress")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			View.OnRightStickPress();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void Special2(bool value)
	{
		if (!value)
		{
			EventSystemHelper.Click(View.Rechallenge);
		}
	}
}
