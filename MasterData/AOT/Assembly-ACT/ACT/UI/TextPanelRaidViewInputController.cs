using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class TextPanelRaidViewInputController : BaseUIViewInputController<TextPanelRaidView>
{
	private ViewControlRoot m_ViewControlRoot;

	private ViewControlLayer m_ViewControlLayer;

	protected override void OnInitView(TextPanelRaidView view)
	{
		base.OnInitView(view);
		m_ViewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
		RefreshSelection();
	}

	private void RefreshSelection()
	{
		if (!m_ViewControlRoot.ReFocus())
		{
			m_ViewControlLayer = m_ViewControlRoot.GetComponentInChildren<ViewControlLayer>();
			m_ViewControlLayer.Focus();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(value != Vector2.zero))
		{
			return;
		}
		if ((bool)EventSystemHelper.CurrentSelected && EventSystemHelper.CurrentSelected == m_ViewControlLayer.LastSelect.gameObject)
		{
			AxisEventData axisEventData = new AxisEventData(EventSystemHelper.Shared);
			axisEventData.Reset();
			axisEventData.moveVector = value;
			axisEventData.moveDir = ContinuousNavigateUtility.DetermineMoveDirection(value.x, value.y, 0.6f);
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

	[GameInputBindingBool("UI/Confirm")]
	public void Submit(bool value)
	{
		if (!value)
		{
			if ((bool)EventSystemHelper.CurrentSelected && EventSystemHelper.CurrentSelected == m_ViewControlLayer.LastSelect.gameObject)
			{
				EventSystemHelper.ClickCurrent();
			}
			else
			{
				RefreshSelection();
			}
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.Close();
		}
	}
}
