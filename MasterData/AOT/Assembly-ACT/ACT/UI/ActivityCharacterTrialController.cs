using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;

namespace ACT.UI;

public class ActivityCharacterTrialController : SubUIViewInputController<ActivityCharacterTrial>
{
	public ActivityCharacterTrialControlType ControlType;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnInitView(ActivityCharacterTrial view)
	{
		base.OnInitView(view);
		ControlType = ActivityCharacterTrialControlType.Main;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnInputModeChange(MonoECS.instance.InputMode);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		View.OnInputModeChange(type);
	}

	[GameInputBindingBool("UI/Back")]
	protected void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == ActivityCharacterTrialControlType.Reward)
			{
				View.ChangeControlType(ActivityCharacterTrialControlType.Main);
			}
			else
			{
				View.OnClose();
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			View.OnConfirm();
		}
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void RightStickPress(bool value)
	{
		if (value && ControlType == ActivityCharacterTrialControlType.Main)
		{
			View.TimeAndDesItem.OnClickActivityDetailButtonHandle();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void ButtonWest(bool value)
	{
		if (value && ControlType == ActivityCharacterTrialControlType.Main)
		{
			View.OnClickGotoGachaBtnHandle();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void ButtonNorth(bool value)
	{
		if (value && ControlType == ActivityCharacterTrialControlType.Main)
		{
			View.OnClickGotoTrailBtnHandle();
		}
	}

	[GameInputBindingBool("UI/View")]
	public void Start(bool value)
	{
		if (value && ControlType == ActivityCharacterTrialControlType.Main && View.CharacterOverTagtems.Count > 0)
		{
			EventSystemHelper.Click(View.CharacterOverTagtems[0].BtnClick);
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value && ControlType == ActivityCharacterTrialControlType.Main)
		{
			View.ChangeControlType(ActivityCharacterTrialControlType.Reward);
		}
	}
}
