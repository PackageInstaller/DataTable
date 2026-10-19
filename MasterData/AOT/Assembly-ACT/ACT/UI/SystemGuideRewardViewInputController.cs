using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SystemGuideRewardViewInputController : BaseUIViewInputController<SystemGuideRewardView>
{
	private ViewControlRoot m_ViewControlRoot;

	private GameObject curSelectItem;

	private ContinuousNavigateData _curNavigateData;

	private JourneyTraceSubController subControllerType;

	public JourneyTraceSubController ControllerType
	{
		get
		{
			return subControllerType;
		}
		set
		{
			subControllerType = value;
		}
	}

	public GameObject CurSelectItem => curSelectItem;

	protected override void OnInitView(SystemGuideRewardView view)
	{
		base.OnInitView(view);
		subControllerType = JourneyTraceSubController.main;
		m_ViewControlRoot = view?.GetComponentInChildren<ViewControlRoot>();
		curSelectItem = null;
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value && subControllerType == JourneyTraceSubController.SelectItem)
		{
			View?.ChangeToGamePadInputState(JourneyTraceSubController.main, needReFocusLayer: true);
		}
		else if (!value && subControllerType == JourneyTraceSubController.main)
		{
			View?.Close();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnSelectionNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Right:
			m_ViewControlRoot.SelectRight();
			return;
		case MoveDirection.Left:
			m_ViewControlRoot.SelectLeft();
			return;
		case MoveDirection.Up:
			if (subControllerType == JourneyTraceSubController.main)
			{
				m_ViewControlRoot.SelectUp();
				CommonSelect();
				return;
			}
			break;
		}
		if (dir == MoveDirection.Down && subControllerType == JourneyTraceSubController.main)
		{
			m_ViewControlRoot.SelectDown();
			CommonSelect();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnGamepadSelect(bool value)
	{
		if ((View != null) & value)
		{
			View.HandleGamePadSelectButtonInput(subControllerType);
		}
	}

	[GameInputBindingBool("UI/LeftStackPress")]
	private void OnGamepadChangeToSelectItem(bool value)
	{
		if (((View != null) & value) && subControllerType == JourneyTraceSubController.main)
		{
			View.ChangeToGamePadInputState(JourneyTraceSubController.SelectItem);
		}
	}

	[GameInputBindingBool("LargeMapView/MapItem")]
	private void OnGamepadOneClickReward(bool value)
	{
		if (((View != null) & value) && subControllerType == JourneyTraceSubController.main && View.bookLevelOSA.oneClickRewardButton.interactable)
		{
			View.bookLevelOSA.oneClickRewardButton.OnClick?.Invoke();
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

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		curSelectItem = null;
		_curNavigateData?.Reset();
	}
}
