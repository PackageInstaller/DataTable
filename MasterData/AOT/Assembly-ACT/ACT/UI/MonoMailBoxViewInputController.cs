using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class MonoMailBoxViewInputController : BaseUIViewInputController<MonoMailboxView>
{
	private MailSubController subControllerType;

	private ViewControlRoot m_ViewControlRoot;

	private GameObject curSelectItem;

	private ContinuousNavigateData _curNavigateData;

	public MailSubController ControllerType
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

	protected override void OnInitView(MonoMailboxView view)
	{
		base.OnInitView(view);
		subControllerType = MailSubController.main;
		m_ViewControlRoot = view?.GetComponentInChildren<ViewControlRoot>();
		curSelectItem = null;
	}

	protected override void OnBackPressed(bool value)
	{
		if (View != null && !value)
		{
			View.HandleGamePadReturnButtonInput(subControllerType);
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
		case MoveDirection.Down:
			m_ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Up:
			m_ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Right:
			m_ViewControlRoot.SelectRight();
			break;
		case MoveDirection.Left:
			m_ViewControlRoot.SelectLeft();
			break;
		}
		if (subControllerType == MailSubController.main)
		{
			CommonSelect();
		}
	}

	[GameInputBindingBool("LargeMapView/MapSideInfoLast")]
	public void OnSelectionLeft(bool value)
	{
	}

	[GameInputBindingBool("LargeMapView/MapSideInfoNext")]
	public void OnSelectionRight(bool value)
	{
	}

	[GameInputBindingBool("UI/Back")]
	private void OnGamepadBackClick(bool value)
	{
	}

	[GameInputBindingBool("LargeMapView/Select")]
	private void OnGamepadSelect(bool value)
	{
		if ((View != null) & value)
		{
			View.HandleGamePadSelectButtonInput(subControllerType);
		}
	}

	[GameInputBindingBool("LargeMapView/MapItem")]
	private void OnGamepadReceiveAll(bool value)
	{
		if ((View != null) & value)
		{
			View.GetRewardAllMail();
		}
	}

	[GameInputBindingBool("LargeMapView/Select")]
	private void OnGamepadReceiveOrDelete(bool value)
	{
		if ((View != null && subControllerType == MailSubController.main) & value)
		{
			View.GamePadCommonConfirm();
		}
	}

	[GameInputBindingBool("LargeMapView/MapTemple")]
	private void OnGamepadDeleteAll(bool value)
	{
		if ((View != null) & value)
		{
			View.OpenDeleteAllReadMailPopUp();
		}
	}

	[GameInputBindingBool("UI/LeftStackPress")]
	private void OnGamepadChangeToSelectItem(bool value)
	{
		if ((View != null) & value)
		{
			View.ChangeToGamePadInputState(MailSubController.SelectItem);
		}
	}

	[GameInputBindingBool("UI/CommonSelect")]
	private void OnGamepadOpenMailLink(bool value)
	{
		if (((View != null) & value) && subControllerType == MailSubController.main)
		{
			View.mailLinkButton?.OnClick?.Invoke();
		}
	}

	[GameInputBindingBool("UI/OpenTIps")]
	private void OnGamepadOpenRule(bool value)
	{
		if ((View != null) & value)
		{
			View.OpenMailboxInfoPopUp();
		}
	}

	[GameInputBindingBool("UI/Start")]
	private void OnGamepadCollectMail(bool value)
	{
		if ((View != null) & value)
		{
			View.ChangeMailTag();
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
		_curNavigateData?.Reset();
	}
}
