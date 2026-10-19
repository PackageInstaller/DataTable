using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class MonoJourneyTracesViewInputController : BaseUIViewInputController<MonoJourneyTracesView>
{
	private JourneyTraceSubController subControllerType;

	private ViewControlRoot m_ViewControlRoot;

	private GameObject curSelectItem;

	private ContinuousNavigateData _curNavigateData;

	private Vector2 dir;

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

	protected override void OnInitView(MonoJourneyTracesView view)
	{
		base.OnInitView(view);
		dir = Vector2.zero;
		subControllerType = JourneyTraceSubController.main;
		m_ViewControlRoot = view?.GetComponentInChildren<ViewControlRoot>();
		curSelectItem = null;
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.HandleGamePadReturnButtonInput(subControllerType);
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnSelectionNavigate(Vector2 value)
	{
		if (subControllerType != JourneyTraceSubController.main)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	private void OnGamepadRightTrigger(bool value)
	{
		if (value && IsWorldLevelTaskGroupSelected())
		{
			View?.worldLevelPage?.TrySelectNextWorldLevel();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/RightTrigger", TrySelectNextWorldLevel, 0.4f, -1);
		}
		else if (value && subControllerType == JourneyTraceSubController.SystemGuide)
		{
			dir = Vector2.right;
			HandleGamepadTriggerZoomButton();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/RightTrigger", HandleGamepadTriggerZoomButton, 0.4f, -1, 0.5f, null, EndGamepadTriggerZoomButton);
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	private void OnGamepadLeftTrigger(bool value)
	{
		if (value && IsWorldLevelTaskGroupSelected())
		{
			View?.worldLevelPage?.TrySelectPreviousWorldLevel();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/LeftTrigger", TrySelectPreviousWorldLevel, 0.4f, -1);
		}
		else if (value && subControllerType == JourneyTraceSubController.SystemGuide)
		{
			dir = Vector2.left;
			HandleGamepadTriggerZoomButton();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/LeftTrigger", HandleGamepadTriggerZoomButton, 0.4f, -1, 0.5f, null, EndGamepadTriggerZoomButton);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		if (subControllerType == JourneyTraceSubController.SelectWorldLevelTaskGroup)
		{
			View?.worldLevelPage.MoveWorldLevelTaskSelection(dir);
			return;
		}
		switch (dir)
		{
		case MoveDirection.Right:
			m_ViewControlRoot.SelectRight();
			break;
		case MoveDirection.Left:
			m_ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Up:
			m_ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			m_ViewControlRoot.SelectDown();
			break;
		}
		if (subControllerType == JourneyTraceSubController.main)
		{
			CommonSelect();
		}
	}

	private void ExecuteNavigateButton(MoveDirection dir)
	{
		ChapterItemPrefabsOSA chapterItemPrefabsOSA = View.systemGuideTabView.bookViewMultiplePrefabsOSA.chapterItemPrefabsOSA;
		if (!(chapterItemPrefabsOSA == null))
		{
			switch (dir)
			{
			case MoveDirection.Right:
				chapterItemPrefabsOSA.nextChapter?.OnClick.Invoke();
				break;
			case MoveDirection.Left:
				chapterItemPrefabsOSA.lastChapter?.OnClick.Invoke();
				break;
			}
		}
	}

	[GameInputBindingBool("LargeMapView/Select")]
	private void OnGamepadSelect(bool value)
	{
		if ((View != null) & value)
		{
			View.HandleGamePadSelectButtonInput(subControllerType);
		}
	}

	[GameInputBindingBool("LargeMapView/ChangeToSelectItem")]
	private void OnGamepadChangeToSelectItem(bool value)
	{
		if (((View != null) & value) && IsWorldLevelTaskGroupSelected())
		{
			View.ChangeToGamePadInputState(JourneyTraceSubController.SelectItem);
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	private void OnGamepadOpenRule(bool value)
	{
		if (((View != null) & value) && IsWorldLevelTaskGroupSelected() && View.worldLevelPage._btn_tips.gameObject.activeInHierarchy)
		{
			View.worldLevelPage._btn_tips.onClick?.Invoke();
		}
	}

	[GameInputBindingBool("UI/RightSwitchRole")]
	private void OnGamepadOpenSystemGuide(bool value)
	{
		if (((View != null) & value) && (IsWorldLevelTaskGroupSelected() || subControllerType == JourneyTraceSubController.SystemGuide))
		{
			View.toggleGroup.SetToggleOn(1);
		}
	}

	[GameInputBindingBool("UI/LeftSwitchRole")]
	private void OnGamepadOpenJourneyTrace(bool value)
	{
		if (((View != null) & value) && (IsWorldLevelTaskGroupSelected() || subControllerType == JourneyTraceSubController.SystemGuide))
		{
			View.toggleGroup.SetToggleOn(0);
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

	[GameInputBindingBool("UI/Confirm")]
	public void ButtonSouth(bool value)
	{
		if (!value && subControllerType == JourneyTraceSubController.SelectWorldLevelTaskGroup)
		{
			View?.worldLevelPage.TryClickSelectedWorldLevelTaskGoto();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	private void OnGamepadBreakWorldLevel(bool value)
	{
		if (!value && (subControllerType == JourneyTraceSubController.main || subControllerType == JourneyTraceSubController.SelectWorldLevelTaskGroup))
		{
			View?.worldLevelPage?.TryBreakWorldLevelByGamepad();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		if (subControllerType == JourneyTraceSubController.main)
		{
			MonoJourneyTracesView view = View;
			if ((object)view != null && view.CurTabID == 0 && View.TryFocusWorldLevelTaskGroupForGamepad(needReFocusLayer: true))
			{
				return;
			}
		}
		View?.ChangeToGamePadInputState(subControllerType, needReFocusLayer: true);
	}

	private void TrySelectPreviousWorldLevel()
	{
		if (IsWorldLevelTaskGroupSelected())
		{
			View?.worldLevelPage?.TrySelectPreviousWorldLevel();
		}
	}

	private void TrySelectNextWorldLevel()
	{
		if (IsWorldLevelTaskGroupSelected())
		{
			View?.worldLevelPage?.TrySelectNextWorldLevel();
		}
	}

	private bool IsWorldLevelTaskGroupSelected()
	{
		if (subControllerType != JourneyTraceSubController.main)
		{
			return subControllerType == JourneyTraceSubController.SelectWorldLevelTaskGroup;
		}
		return true;
	}

	private void HandleGamepadTriggerZoomButton()
	{
		ContinuousNavigateUtility.StartContinuousNavigate(dir, ref _curNavigateData, ExecuteNavigateButton);
	}

	private void EndGamepadTriggerZoomButton()
	{
		dir = Vector2.zero;
		ContinuousNavigateUtility.StartContinuousNavigate(Vector2.zero, ref _curNavigateData, ExecuteNavigateButton);
	}
}
