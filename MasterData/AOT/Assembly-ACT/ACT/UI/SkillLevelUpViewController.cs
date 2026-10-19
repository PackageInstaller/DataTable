using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SkillLevelUpViewController : BaseUIViewInputController<MonoSkillLevelUpView>
{
	private ContinuousNavigateData _curNavigateData;

	private ViewControlRoot m_ViewControlRoot;

	public SkillSubviewInputState InputState { get; set; }

	protected override void OnEnable()
	{
		base.OnEnable();
		View.coinGroup.FocusIn();
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		View.coinGroup.FocusOut();
	}

	protected override void OnInitView(MonoSkillLevelUpView view)
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

	[GameInputBindingBool("UI/LeftStackPress")]
	public void OnLeftStickPress(bool value)
	{
		if (InputState == SkillSubviewInputState.SkillMain)
		{
			View.ChangeToGamePadInputState(SkillSubviewInputState.SkillSelectItem);
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
