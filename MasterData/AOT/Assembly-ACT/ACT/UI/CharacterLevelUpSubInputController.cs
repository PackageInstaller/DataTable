using ACT.Battle;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class CharacterLevelUpSubInputController : SubUIViewInputController<CharacterLevelUpSubView>
{
	private ContinuousNavigateData navData;

	public bool CostLayerFocused { get; private set; }

	public bool SkillLayerFocused { get; private set; }

	public void ShowCostExpDetail()
	{
		if (!CostLayerFocused)
		{
			View.subViewLayer.UnFocus();
			View.costLayer.Focus();
			CostLayerFocused = true;
		}
	}

	public void HideCostExpDetail()
	{
		if (CostLayerFocused)
		{
			View.costLayer.UnFocus();
			View.subViewLayer.ReFocus();
			CostLayerFocused = false;
		}
	}

	public void ShowSkillDetail()
	{
		if (!SkillLayerFocused)
		{
			View.subViewLayer.UnFocus();
			View.skillLayer.Focus();
			SkillLayerFocused = true;
			SetNonSkillLayerPrompts(visible: false);
		}
	}

	public void HideSkillDetail()
	{
		if (SkillLayerFocused)
		{
			View.skillLayer.UnFocus();
			View.subViewLayer.ReFocus();
			SkillLayerFocused = false;
			SetNonSkillLayerPrompts(visible: true);
		}
	}

	protected override void OnActivate()
	{
		if (CostLayerFocused)
		{
			View.costLayer.Focus();
		}
		else if (SkillLayerFocused)
		{
			View.skillLayer.Focus();
		}
		else
		{
			View.subViewLayer.Focus();
		}
	}

	protected override void OnDeactivate()
	{
		navData?.Reset();
	}

	protected void SetNonSkillLayerPrompts(bool visible)
	{
		GameObject[] nonSkillLayerPrompts = View.nonSkillLayerPrompts;
		for (int i = 0; i < nonSkillLayerPrompts.Length; i++)
		{
			nonSkillLayerPrompts[i].gameObject.SetActive(visible);
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	public void DecreaseLevel(bool value)
	{
		if (value)
		{
			View.SelectPrevLevel();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/LeftTrigger", View.SelectPrevLevel, 0.3f, -1, 0.075f);
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	public void IncreaseLevel(bool value)
	{
		if (value)
		{
			View.SelectNextLevel();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/RightTrigger", View.SelectNextLevel, 0.3f, -1, 0.075f);
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void SelectSkill(bool value)
	{
		if (value && !CostLayerFocused)
		{
			ShowSkillDetail();
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.CharacterSelectTalentSkill);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value)
		{
			return;
		}
		if (CostLayerFocused || SkillLayerFocused)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (!(currentSelected == null))
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
		else
		{
			View.TriggerUpgrade();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/Confirm", View.TriggerUpgrade, 0.3f, -1, 0.15f);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void SelectMaxLevel(bool value)
	{
		if (value)
		{
			View.ScrollToMaxLevel();
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void ShowCostExpDetail(bool value)
	{
		if (value && !SkillLayerFocused)
		{
			ShowCostExpDetail();
		}
	}

	[GameInputBindingBool("UI/Back")]
	public void ReturnFromCostCoin(bool value)
	{
		if (value)
		{
			return;
		}
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			if (CostLayerFocused)
			{
				HideCostExpDetail();
			}
			else if (SkillLayerFocused)
			{
				HideSkillDetail();
			}
			else
			{
				View.CharacterView.CloseCurrentCharacterSubView();
			}
		}
		else
		{
			SkillLayerFocused = false;
			CostLayerFocused = false;
			View.CharacterView.CloseCurrentCharacterSubView();
		}
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
			View.costLayer.Root?.SelectUp();
			break;
		case MoveDirection.Down:
			View.costLayer.Root?.SelectDown();
			break;
		case MoveDirection.Left:
			View.costLayer.Root?.SelectLeft();
			break;
		case MoveDirection.Right:
			View.costLayer.Root?.SelectRight();
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
		}
	}
}
