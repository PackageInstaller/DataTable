using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class CvSkillSubController : SubUIViewInputController<CvSkill>
{
	private ViewControlRoot m_ViewControlRoot;

	private ContinuousNavigateData navData;

	public SkillSubviewInputState InputState { get; set; }

	protected override void OnActivate()
	{
		base.OnActivate();
		m_ViewControlRoot = View.GetComponentInParent<ViewControlRoot>();
		View.coinGroup.FocusIn();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		navData?.Reset();
		View.coinGroup.FocusOut();
	}

	[GameInputBindingBool("CharacterView/Destiny")]
	public void OpenDestiny(bool value)
	{
		if (value && InputState == SkillSubviewInputState.SkillMain)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
			View.CharacterView.OpenDestiny();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void ToggleSkillDescriptionMode(bool value)
	{
		if (!value && InputState == SkillSubviewInputState.SkillMain)
		{
			View.ToggleDescriptionMode();
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void ShowSelectedCostMaterialDetail(bool value)
	{
		if (!value && InputState == SkillSubviewInputState.SkillMain)
		{
			View.OnLeftStickPress();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void ShowLevelUpView(bool value)
	{
		if (!value)
		{
			if (View.confirmButton.gameObject.activeSelf && InputState == SkillSubviewInputState.SkillMain)
			{
				View.ShowLevelUpView();
			}
			else if (InputState == SkillSubviewInputState.SkillSelectItem)
			{
				CommonSelect();
			}
		}
	}

	[GameInputBindingBool("UI/View")]
	public void ShowLevelUpPreviewView(bool value)
	{
		if (!value && View.previewButton.gameObject.activeSelf && InputState == SkillSubviewInputState.SkillMain)
		{
			View.OnClickView();
		}
	}

	[GameInputBindingBool("UI/Back")]
	public void OnBackPress(bool value)
	{
		if (!value)
		{
			switch (InputState)
			{
			case SkillSubviewInputState.SkillMain:
				View.ParentUIView.Close();
				break;
			case SkillSubviewInputState.SkillSelectItem:
				View.ChangeToGamePadInputState(SkillSubviewInputState.SkillMain, needReFocusLayer: true);
				break;
			}
		}
	}

	[GameInputBindingFloat("UI/RSUpDownSelect")]
	public void OnNavigateRightStick(float value)
	{
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			m_ViewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			m_ViewControlRoot?.SelectDown();
			break;
		case MoveDirection.Left:
			m_ViewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			m_ViewControlRoot?.SelectRight();
			break;
		}
		if (!View.coinGroup.IsOperating && InputState == SkillSubviewInputState.SkillMain)
		{
			CommonSelect();
		}
	}

	public void CommonSelect()
	{
		if ((bool)EventSystemHelper.CurrentSelected)
		{
			EventSystemHelper.ClickCurrent();
		}
	}
}
