using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;

namespace ACT.UI;

public class CommonWorldSuccessViewInputController : BaseUIViewInputController<CommonWorldSuccessView>
{
	private CommonWorldSuccessViewType _controlType;

	private ContinuousNavigateData _curNavigateData;

	public CommonWorldSuccessViewType ControlType
	{
		get
		{
			return _controlType;
		}
		set
		{
			_controlType = value;
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (_controlType == CommonWorldSuccessViewType.Reward)
			{
				View.ChangeControlType(CommonWorldSuccessViewType.Main);
			}
			else if (View.ExitRaid.gameObject.activeSelf)
			{
				EventSystemHelper.Click(View.ExitRaid);
			}
			else if (View.ReturnHomePage.gameObject.activeSelf)
			{
				EventSystemHelper.Click(View.ReturnHomePage);
			}
		}
	}

	protected override void OnEscPressed(bool value)
	{
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnControllerActivate();
		View.SetPowerBarPromptActive(active: true);
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

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value && ControlType == CommonWorldSuccessViewType.Main && View._rewardCanvasGroup.gameObject.activeSelf && View._rewardCanvasGroup.alpha >= 1f)
		{
			View.ChangeControlType(CommonWorldSuccessViewType.Reward);
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
			EventSystemHelper.Click(View.ReChallenge);
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void Special1(bool value)
	{
		if (!value)
		{
			EventSystemHelper.Click(View.NextLevel);
		}
	}
}
