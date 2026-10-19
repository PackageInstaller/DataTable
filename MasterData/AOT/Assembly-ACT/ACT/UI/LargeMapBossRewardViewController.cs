using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class LargeMapBossRewardViewController : BaseUIViewInputController<LargeMapBossRewardView>
{
	private ContinuousNavigateData _curNavigateData;

	private ViewControlRoot m_ViewControlRoot;

	public SubControllerType InputState { get; set; }

	protected override void OnInitView(LargeMapBossRewardView view)
	{
		base.OnInitView(view);
		m_ViewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
	}

	protected override void OnBackPressed(bool value)
	{
		if (View != null && !value)
		{
			View.HandleCommonBackInput(InputState);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnCommonConfirm(bool value)
	{
		if (View != null && !value)
		{
			View.HandleCommonSelectInput(InputState);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Left:
			m_ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			m_ViewControlRoot.SelectRight();
			break;
		case MoveDirection.Up:
			m_ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			m_ViewControlRoot.SelectDown();
			break;
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
	}

	[GameInputBindingFloat("UI/RSUpDownSelect")]
	public void OnUpDown(float value)
	{
	}

	[GameInputBindingFloat("UI/RSUpDownSelect")]
	public void OnRightStickPress(float value)
	{
	}

	[GameInputBindingBool("UI/LeftStackPress")]
	public void OnLeftStickPress(bool value)
	{
		if (InputState == SubControllerType.main)
		{
			View.ChangeToGamePadInputState(SubControllerType.sideBarSelectItem);
		}
	}

	public void CommonSelect()
	{
		if ((bool)EventSystemHelper.CurrentSelected)
		{
			EventSystemHelper.ClickCurrent();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}
}
