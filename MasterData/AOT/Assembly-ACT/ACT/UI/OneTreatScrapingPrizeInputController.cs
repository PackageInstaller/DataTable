using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class OneTreatScrapingPrizeInputController : BaseUIViewInputController<OneTreatScrapingPrizeView>
{
	private const float ActivateInputBlockSeconds = 0.35f;

	private float _ignoreInputUntilUnscaled;

	private bool _confirmPressedAfterActivate;

	private ContinuousNavigateData _curNavigateData;

	public OneTreatScrapingPrizeControllerType ControllerType { get; private set; }

	public void SetControllerType(OneTreatScrapingPrizeControllerType controllerType)
	{
		if (ControllerType != controllerType)
		{
			ControllerType = controllerType;
			_curNavigateData?.Reset();
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		ResetActivateInputState();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		ResetActivateInputState();
		_curNavigateData?.Reset();
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControllerType == OneTreatScrapingPrizeControllerType.MultiRewardSelection)
			{
				View.ChangeToGamePadInputState(OneTreatScrapingPrizeControllerType.MultiRewardResult);
			}
			else
			{
				View.HandleBack();
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.HandleGamepadNavigate);
	}

	[GameInputBindingBool("UI/Start")]
	public void Skip(bool value)
	{
		if (value && !IsActivateInputBlocked())
		{
			View.HandleSkip();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void DrawAgain(bool value)
	{
		if (!value)
		{
			View.HandleDrawAgain();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (CanHandleReleaseInput(value, ref _confirmPressedAfterActivate))
		{
			View.HandleConfirm();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void SelectItemCell(bool value)
	{
		if (!value)
		{
			View.HandleSelectItemCell();
		}
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void OpenTicketDetail(bool value)
	{
		if (!value)
		{
			View.OpenTicketDetailByInput();
		}
	}

	private void ResetActivateInputState()
	{
		_ignoreInputUntilUnscaled = Time.unscaledTime + 0.35f;
		_confirmPressedAfterActivate = false;
	}

	private bool IsActivateInputBlocked()
	{
		return Time.unscaledTime < _ignoreInputUntilUnscaled;
	}

	private bool CanHandleReleaseInput(bool value, ref bool pressedAfterActivate)
	{
		if (value)
		{
			pressedAfterActivate = !IsActivateInputBlocked();
			return false;
		}
		if (IsActivateInputBlocked() || !pressedAfterActivate)
		{
			pressedAfterActivate = false;
			return false;
		}
		pressedAfterActivate = false;
		return true;
	}
}
