using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class LoungeRoomSideInfoSubInputController : SubUIViewInputController<LoungeRoomSideInfoSubView>
{
	private const float NavigateDeadZone = 0.45f;

	private const float NavigateReleaseZone = 0.2f;

	private const float NavigateConsumeInterval = 0.15f;

	private int _lastVerticalDirection;

	private float _nextNavigateConsumeTime;

	private bool IsGamepadInputBlocked
	{
		get
		{
			LoungeRoomSideInfoSubView view = View;
			if ((object)view == null)
			{
				return false;
			}
			return view.Owner?.IsGamepadBlockedByCameraTransition == true;
		}
	}

	protected override void OnActivate()
	{
		_lastVerticalDirection = 0;
		_nextNavigateConsumeTime = 0f;
		View?.Owner?.sideRoomInfo?.SelectFirstRoomGroupForGamepad();
		View?.Owner?.SetGamePadTipsActive(active: true);
	}

	protected override void OnDeactivate()
	{
		_lastVerticalDirection = 0;
		_nextNavigateConsumeTime = 0f;
		base.OnDeactivate();
	}

	[GameInputBindingBool("UI/Back")]
	private void OnBack(bool value)
	{
		if (!value && !(View?.Owner == null) && !IsGamepadInputBlocked)
		{
			View.Owner.HideRoomManagement();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	private void OnNavigate(Vector2 value)
	{
		if (!(View?.Owner?.sideRoomInfo == null) && !IsGamepadInputBlocked && TryConsumeNavigateVertical(value, out var direction))
		{
			View.Owner.sideRoomInfo.MoveGamepadSelection(direction);
			View.Owner.SetGamePadTipsActive(active: true);
		}
	}

	private bool TryConsumeNavigateVertical(Vector2 value, out int direction)
	{
		direction = 0;
		float num = Mathf.Abs(value.x);
		float num2 = Mathf.Max(Mathf.Abs(value.y) - num, 0f);
		if (num2 < 0.2f)
		{
			_lastVerticalDirection = 0;
			return false;
		}
		if (num2 < 0.45f)
		{
			return false;
		}
		int num3 = ((!(value.y > 0f)) ? 1 : (-1));
		if (num3 == _lastVerticalDirection || Time.unscaledTime < _nextNavigateConsumeTime)
		{
			return false;
		}
		_lastVerticalDirection = num3;
		_nextNavigateConsumeTime = Time.unscaledTime + 0.15f;
		direction = num3;
		return true;
	}
}
