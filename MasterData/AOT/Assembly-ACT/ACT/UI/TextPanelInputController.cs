using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class TextPanelInputController : BaseUIViewInputController<TextPanel>
{
	private ViewControlRoot m_ViewControlRoot;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnInitView(TextPanel view)
	{
		base.OnInitView(view);
		m_ViewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		RefreshSelection(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!EventSystemHelper.CurrentSelected)
		{
			RefreshSelection();
		}
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Left:
			m_ViewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			m_ViewControlRoot?.SelectRight();
			break;
		}
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

	public void RefreshSelection(bool autoFindSelectable = true)
	{
		ViewControlRoot viewControlRoot = m_ViewControlRoot;
		if ((object)viewControlRoot == null || !viewControlRoot.ReFocus())
		{
			m_ViewControlRoot?.GetComponent<ViewControlLayer>()?.Focus(autoFindSelectable);
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.OnCancelBtn();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}
}
