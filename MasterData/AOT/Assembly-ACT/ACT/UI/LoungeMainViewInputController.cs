using ACT.Battle;
using ACT.ViewControl;
using UnityEngine;

namespace ACT.UI;

public class LoungeMainViewInputController : BaseUIViewInputController<LoungeMainView>
{
	private const float NavigateDeadZone = 0.45f;

	private const float NavigateReleaseZone = 0.2f;

	private ViewControlRoot m_ViewControlRoot;

	private ViewControlLayer m_ViewControlLayer;

	private int _lastHorizontalDirection;

	private float _nextNavigateConsumeTime;

	private bool IsSubViewInputOccupied
	{
		get
		{
			if (View != null)
			{
				return View.IsSubViewInputOccupied;
			}
			return false;
		}
	}

	private bool IsGamepadInputBlocked
	{
		get
		{
			if (View != null)
			{
				if (!View.IsGamepadBlockedByCameraTransition && !View.IsAllUiHidden())
				{
					return View.IsRestoringHiddenUiThisFrame();
				}
				return true;
			}
			return false;
		}
	}

	protected override void OnInitView(LoungeMainView view)
	{
		base.OnInitView(view);
		m_ViewControlRoot = view?.GetComponentInChildren<ViewControlRoot>();
		m_ViewControlLayer = view?.GetComponentInChildren<ViewControlLayer>();
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value && !(View == null) && !IsSubViewInputOccupied && !IsGamepadInputBlocked)
		{
			if (View.sideRoomInfo != null && View.sideRoomInfo.IsSidePanelVisible)
			{
				View.HideRoomManagement();
			}
			else
			{
				View.BackToMainWorld();
			}
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnGamepadConfirm(bool value)
	{
		if (!(View == null) && !View.ShouldConsumeGamepadConfirm(value) && value && !IsSubViewInputOccupied && !IsGamepadInputBlocked)
		{
			View.ConfirmGamepadHudSelection();
		}
	}

	[GameInputBindingBool("UI/Start")]
	private void OnGamepadMenu(bool value)
	{
		if (value && View != null && !IsSubViewInputOccupied && !IsGamepadInputBlocked)
		{
			View.ToggleRoomManagementByGamepad();
		}
	}

	[GameInputBindingBool("UI/View")]
	private void OnGamepadView(bool value)
	{
		if (value && View != null && !IsSubViewInputOccupied && !IsGamepadInputBlocked)
		{
			View.TryShowTreasureViewByGamepad();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	private void OnGamepadY(bool value)
	{
		if (value && View != null && !IsSubViewInputOccupied && !IsGamepadInputBlocked)
		{
			View.TryShowCharacterListByGamepad();
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	private void OnGamepadLeftTrigger(bool value)
	{
		if (value && View != null && !IsSubViewInputOccupied && !IsGamepadInputBlocked)
		{
			View.TryLastCameraPosByGamepad();
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	private void OnGamepadRightTrigger(bool value)
	{
		if (value && View != null && !IsSubViewInputOccupied && !IsGamepadInputBlocked)
		{
			View.TryNextCameraPosByGamepad();
		}
	}

	[GameInputBindingBool("UI/PressAnyKey")]
	private void OnPressAnyKey(bool value)
	{
		if (value && !(View == null))
		{
			View.TryHandlePressAnyKeyByGamepad();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	private void OnGamepadNavigate(Vector2 value)
	{
		if (!IsSubViewInputOccupied && !IsGamepadInputBlocked && TryConsumeNavigateHorizontal(value, out var direction))
		{
			View?.NavigateGamepadHud(direction);
		}
	}

	private bool TryConsumeNavigateHorizontal(Vector2 value, out int direction)
	{
		direction = 0;
		float num = Mathf.Abs(value.x);
		float num2 = Mathf.Abs(value.y);
		float num3 = Mathf.Max(num - num2, 0f);
		if (num3 < 0.2f)
		{
			_lastHorizontalDirection = 0;
			return false;
		}
		if (num3 < 0.45f)
		{
			return false;
		}
		int num4 = ((value.x > 0f) ? 1 : (-1));
		if (num4 == _lastHorizontalDirection || Time.unscaledTime < _nextNavigateConsumeTime)
		{
			return false;
		}
		_lastHorizontalDirection = num4;
		_nextNavigateConsumeTime = Time.unscaledTime + 0.15f;
		direction = num4;
		return true;
	}

	protected override void OnDeactivate()
	{
		View?.ForceReleaseGamepadConfirmConsume();
		base.OnDeactivate();
		_lastHorizontalDirection = 0;
		_nextNavigateConsumeTime = 0f;
	}
}
