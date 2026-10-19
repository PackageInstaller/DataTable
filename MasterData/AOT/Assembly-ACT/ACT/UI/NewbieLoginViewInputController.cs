using ACT.Battle;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class NewbieLoginViewInputController : BaseUIViewInputController<NewbieLoginView>
{
	private ContinuousNavigateData _curNavigateData;

	protected override void OnActivate()
	{
		base.OnActivate();
		View?.OnActivate();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	protected override void OnBackPressed(bool value)
	{
		base.OnBackPressed(value);
		if (!value)
		{
			View?.Close();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection moveDirection)
	{
		switch (moveDirection)
		{
		case MoveDirection.Left:
			View?.Left();
			break;
		case MoveDirection.Right:
			View?.Right();
			break;
		}
	}

	[GameInputBindingBool("UI/LeftStackPress")]
	public void LeftStickPress(bool value)
	{
		if (value)
		{
			View?.LeftStickPress();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void ButtonSouth(bool value)
	{
		if (value)
		{
			View?.ButtonSouth();
		}
	}

	[GameInputBindingBool("LargeMapView/MapTemple")]
	public void ButtonWest(bool value)
	{
		if (value)
		{
			View?.ButtonWest();
		}
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			View?.RightStickPress();
		}
	}
}
