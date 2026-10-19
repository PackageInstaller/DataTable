using ACT.Battle;
using ACT.UI.InputController;
using ACT.UI.WildBossBattle;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class HandBookViewInputController : BaseUIViewInputController<MonoHandbookView>
{
	private ViewControlRoot m_ViewControlRoot;

	private GameObject curSelectItem;

	private ContinuousNavigateData _curNavigateData;

	private HandBookSubController subControllerType;

	private int _targetIndex;

	private const float PowerExchangeLongPressHoldDelay = 0.3f;

	private const float PowerExchangeLongPressRepeatInterval = 0.15f;

	public HandBookSubController ControllerType
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

	protected override void OnInitView(MonoHandbookView view)
	{
		base.OnInitView(view);
		_targetIndex = 0;
		subControllerType = HandBookSubController.dairyMain;
		m_ViewControlRoot = view?.GetComponentInChildren<ViewControlRoot>();
		curSelectItem = null;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
	}

	[GameInputBindingBool("UI/ShowCoinDetail")]
	public void TriggerClickCostCell(bool value)
	{
		if (!value && View != null)
		{
			View.ClickAddPowerBar();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void TriggerSpecial1(bool value)
	{
		if (!value && View != null && View.ActiveTab.Content is RaidTabView raidTabView && raidTabView.ActiveTab.Content is WildBossBattleTabView wildBossBattleTabView)
		{
			EventSystemHelper.Click(wildBossBattleTabView.leftAddReceiveTimesBtn);
		}
	}

	[GameInputBindingBool("UI/LeftStackPress")]
	public void OnGamepadChangeToCommonSelectItem(bool value)
	{
		if (!value && View != null && subControllerType == HandBookSubController.rewardWindow)
		{
			View.ChangeToGamePadInputState(HandBookSubController.commonSelectItem);
		}
		if (!value && View != null && subControllerType == HandBookSubController.targetGuideMain)
		{
			View.ChangeToGamePadInputState(HandBookSubController.targetGuideSelectItem);
		}
		if (!value && View != null && (subControllerType == HandBookSubController.raidContent || subControllerType == HandBookSubController.raidNoFocusContent))
		{
			View.ChangeToGamePadInputState(HandBookSubController.raidSelectItem);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void SwitchPageDown(bool value)
	{
		if (!value && View != null)
		{
			View.ClickToggle(isAdd: true);
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void SwitchPageUp(bool value)
	{
		if (!value && View != null)
		{
			View.ClickToggle();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value && View != null)
		{
			View.HandleGamePadReturnButtonInput(subControllerType);
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnSelectionNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
	}

	[GameInputBindingBool("LargeMapView/Left")]
	public void OnSelectionLeft(bool value)
	{
		if (value && View != null && subControllerType == HandBookSubController.raidContent)
		{
			View.ChangeToGamePadInputState(HandBookSubController.raidMain, needReFocusLayer: true);
		}
		if (!value && View != null && subControllerType == HandBookSubController.characterTeamTutorialContent)
		{
			View.ChangeToGamePadInputState(HandBookSubController.characterTutorialMain, needReFocusLayer: true);
		}
	}

	[GameInputBindingBool("LargeMapView/Right")]
	public void OnSelectionRight(bool value)
	{
		if (value && View != null && subControllerType == HandBookSubController.raidMain)
		{
			View.ChangeToGamePadInputState(HandBookSubController.raidContent);
		}
		if (!value && View != null && subControllerType == HandBookSubController.characterTutorialMain)
		{
			View.ChangeToGamePadInputState(HandBookSubController.characterTeamTutorialContent);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Right:
			m_ViewControlRoot.SelectRight();
			if (subControllerType == HandBookSubController.rewardWindow)
			{
				CommonSelect();
			}
			break;
		case MoveDirection.Left:
			m_ViewControlRoot.SelectLeft();
			if (subControllerType == HandBookSubController.rewardWindow)
			{
				CommonSelect();
			}
			break;
		case MoveDirection.Up:
			m_ViewControlRoot.SelectUp();
			if (subControllerType == HandBookSubController.raidMain || subControllerType == HandBookSubController.raidNoFocusContent || subControllerType == HandBookSubController.characterTutorialMain || subControllerType == HandBookSubController.powerExchangeContent)
			{
				CommonSelect();
			}
			break;
		case MoveDirection.Down:
			m_ViewControlRoot.SelectDown();
			if (subControllerType == HandBookSubController.raidMain || subControllerType == HandBookSubController.raidNoFocusContent || subControllerType == HandBookSubController.characterTutorialMain || subControllerType == HandBookSubController.powerExchangeContent)
			{
				CommonSelect();
			}
			break;
		}
	}

	[GameInputBindingBool("UI/View")]
	private void OnGamepadView(bool value)
	{
		if (View != null && !value && subControllerType == HandBookSubController.targetGuideMain)
		{
			View.ChangeToGamePadInputState(HandBookSubController.targetGuideRewardItem);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnGamepadConfirm(bool value)
	{
		if (View != null && !value)
		{
			View.HandleGamePadSelectButtonInput(subControllerType);
		}
	}

	[GameInputBindingBool("UI/Start")]
	private void OnGamepadStart(bool value)
	{
		if (View != null && !value && subControllerType == HandBookSubController.raidNoFocusContent && View._raidContent.dataCalibrationView.shopButton.gameObject.activeSelf)
		{
			View._raidContent.dataCalibrationView.shopButton?.OnClick.Invoke();
		}
	}

	[GameInputBindingBool("UI/SearchSubmit")]
	private void OnGamepadChangeToDailySelectItem(bool value)
	{
		if (View != null && !value)
		{
			View.HandleGamePadItemInput(subControllerType);
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	private void OnGamepadRightTrigger(bool value)
	{
		if (!value && subControllerType == HandBookSubController.targetGuideMain)
		{
			_targetIndex = 1;
			HandleGamepadTriggerZoom();
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	private void OnGamepadLeftTrigger(bool value)
	{
		if (!value && subControllerType == HandBookSubController.targetGuideMain)
		{
			_targetIndex = -1;
			HandleGamepadTriggerZoom();
		}
	}

	public void CommonSelect()
	{
		if ((bool)EventSystemHelper.CurrentSelected)
		{
			EventSystemHelper.ClickCurrent();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void OnSelectItemCell(bool value)
	{
		if (value && View != null && subControllerType == HandBookSubController.characterTeamTutorialContent)
		{
			View.ChangeToCharacterTutorialSelectItem();
		}
		if (!value && subControllerType == HandBookSubController.powerExchangeContent)
		{
			View?.ChangeToGamePadInputState(HandBookSubController.powerExchangeItem, needReFocusLayer: true);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	private void OnPowerExchangeMax(bool value)
	{
		if (!value && subControllerType == HandBookSubController.powerExchangeContent)
		{
			View?._powerExchangeTabView?.ClickMaxBtn();
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	private void OnPowerExchangeHelp(bool value)
	{
		if (!value && subControllerType == HandBookSubController.powerExchangeContent)
		{
			View?._powerExchangeTabView?.OpenSystemHelp();
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	private void OnPowerExchangeDecrease(bool value)
	{
		if (value && subControllerType == HandBookSubController.powerExchangeContent)
		{
			PowerExchangeTabView powerExchangeTabView = View?._powerExchangeTabView;
			if (!(powerExchangeTabView == null))
			{
				powerExchangeTabView.ClickMinusBtn();
				Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/SwitchPageLeft", powerExchangeTabView.ClickMinusBtn, 0.3f, -1, 0.15f);
			}
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	private void OnPowerExchangeIncrease(bool value)
	{
		if (value && subControllerType == HandBookSubController.powerExchangeContent)
		{
			PowerExchangeTabView powerExchangeTabView = View?._powerExchangeTabView;
			if (!(powerExchangeTabView == null))
			{
				powerExchangeTabView.ClickAddBtn();
				Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/SwitchPageRight", powerExchangeTabView.ClickAddBtn, 0.3f, -1, 0.15f);
			}
		}
	}

	public void HandleGamepadTriggerZoom()
	{
		if (_targetIndex == -1)
		{
			if (View._targetGuidContent.leftBtn.gameObject.activeSelf)
			{
				View._targetGuidContent.leftBtn.OnClick?.Invoke();
			}
		}
		else if (_targetIndex == 1 && View._targetGuidContent.rightBtn.gameObject.activeSelf)
		{
			View._targetGuidContent.rightBtn.OnClick?.Invoke();
		}
		_targetIndex = 0;
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		curSelectItem = null;
		_targetIndex = 0;
		_curNavigateData?.Reset();
	}
}
