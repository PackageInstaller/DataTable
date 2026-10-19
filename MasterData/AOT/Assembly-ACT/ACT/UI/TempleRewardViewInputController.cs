using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class TempleRewardViewInputController : BaseUIViewInputController<TempleRewardView>
{
	private ViewControlRoot m_ViewControlRoot;

	public TempleRewardControlType TempleRewardControlType;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnInitView(TempleRewardView view)
	{
		base.OnInitView(view);
		m_ViewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
		TempleRewardControlType = TempleRewardControlType.main;
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.HandleOnBackPressed(TempleRewardControlType);
		}
	}

	[GameInputBindingBool("UI/LeftSwitchRole")]
	public void LeftShoulder(bool value)
	{
		if (value && TempleRewardControlType == TempleRewardControlType.main)
		{
			View.OnGamePadChangeTab(0);
		}
	}

	[GameInputBindingBool("UI/RightSwitchRole")]
	public void RightShoulder(bool value)
	{
		if (value && TempleRewardControlType == TempleRewardControlType.main)
		{
			View.OnGamePadChangeTab(1);
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			m_ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			m_ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Left:
			m_ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			m_ViewControlRoot.SelectRight();
			break;
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (value)
		{
			View.HandleOnConfirm(TempleRewardControlType);
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value && TempleRewardControlType == TempleRewardControlType.main && EventSystemHelper.CurrentSelected != null)
		{
			TempleRewardCell component = EventSystemHelper.CurrentSelected.GetComponent<TempleRewardCell>();
			View.UnFocus();
			component?.ViewControlLayer?.Focus();
			TempleRewardControlType = TempleRewardControlType.item;
			View.Prompt_A.SetActive(value: true);
		}
	}
}
