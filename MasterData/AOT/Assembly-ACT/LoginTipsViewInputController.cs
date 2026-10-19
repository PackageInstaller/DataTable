using ACT.Battle;
using ACT.UI;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

public class LoginTipsViewInputController : BaseUIViewInputController<LoginTipsView>
{
	private GameObject curSelectItem;

	private ViewControlRoot m_ViewControlRoot;

	protected override void OnInitView(LoginTipsView view)
	{
		base.OnInitView(view);
		curSelectItem = null;
		m_ViewControlRoot = view?.GetComponentInChildren<ViewControlRoot>();
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.OnCancelBtn();
		}
	}

	protected override void OnEscPressed(bool value)
	{
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Submit(bool value)
	{
		if (!value)
		{
			if ((bool)EventSystemHelper.CurrentSelected)
			{
				EventSystemHelper.ClickCurrent();
			}
			else
			{
				RefreshSelection();
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(value != Vector2.zero))
		{
			return;
		}
		if ((bool)EventSystemHelper.CurrentSelected)
		{
			AxisEventData axisEventData = new AxisEventData(EventSystemHelper.Shared);
			axisEventData.Reset();
			axisEventData.moveVector = value;
			axisEventData.moveDir = DetermineMoveDirection(value.x, value.y, 0.6f);
			if (axisEventData.moveDir != MoveDirection.None)
			{
				ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, axisEventData, ExecuteEvents.moveHandler);
			}
		}
		else
		{
			RefreshSelection();
		}
	}

	protected static MoveDirection DetermineMoveDirection(float x, float y, float deadZone)
	{
		if (new Vector2(x, y).sqrMagnitude < deadZone * deadZone)
		{
			return MoveDirection.None;
		}
		if (Mathf.Abs(x) > Mathf.Abs(y))
		{
			if (!(x > 0f))
			{
				return MoveDirection.Left;
			}
			return MoveDirection.Right;
		}
		if (!(y > 0f))
		{
			return MoveDirection.Down;
		}
		return MoveDirection.Up;
	}

	protected void RefreshSelection()
	{
		if (!m_ViewControlRoot.ReFocus())
		{
			m_ViewControlRoot.GetComponent<ViewControlLayer>().Focus();
		}
	}

	private void CommonSelect()
	{
		if ((bool)EventSystemHelper.CurrentSelected && curSelectItem != EventSystemHelper.CurrentSelected)
		{
			EventSystemHelper.ClickCurrent();
			curSelectItem = EventSystemHelper.CurrentSelected;
		}
	}
}
