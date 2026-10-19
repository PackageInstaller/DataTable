using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class PopupStateObjectIntroViewController : BaseUIViewInputController<PopupStateObjectIntroView>
{
	private ViewControlRoot m_ViewControlRoot;

	private ContinuousNavigateData _curNavigateData;

	private GameObject curSelectItem;

	protected override void OnInitView(PopupStateObjectIntroView view)
	{
		m_ViewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
		curSelectItem = null;
		base.OnInitView(view);
	}

	protected override void OnBackPressed(bool value)
	{
		if (View != null && !value)
		{
			View.closeBtn.OnClick.Invoke();
		}
	}

	[GameInputBindingBool("UI/Back")]
	private void OnGamepadBack(bool value)
	{
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnSelectionNavigate(Vector2 value)
	{
		if (View != null)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Down:
			m_ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Up:
			m_ViewControlRoot.SelectUp();
			break;
		}
		CommonSelect();
	}

	private void CommonSelect()
	{
		if ((bool)EventSystemHelper.CurrentSelected && curSelectItem != EventSystemHelper.CurrentSelected)
		{
			EventSystemHelper.ClickCurrent();
			curSelectItem = EventSystemHelper.CurrentSelected;
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
	}
}
