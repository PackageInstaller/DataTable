using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class CardDrawViewController : BaseUIViewInputController<CardDrawView>
{
	private ContinuousNavigateData _settleNavigateData;

	protected override void OnActivate()
	{
		base.OnActivate();
		_settleNavigateData?.Reset();
		View?.CardDrawSettleComponent?.ReFocusResult();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_settleNavigateData?.Reset();
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void OnSelectSettleResult(bool value)
	{
		if (value && !(View?.CardDrawSettleComponent == null))
		{
			_settleNavigateData?.Reset();
			View.CardDrawSettleComponent.TryFocusResult();
		}
	}

	private void ExecuteSettleNavigate(MoveDirection direction)
	{
		ViewControlLayer viewControlLayer = View?.CardDrawSettleComponent?.ActiveResultViewControlLayer;
		if (!(viewControlLayer == null) && viewControlLayer.IsFocused)
		{
			switch (direction)
			{
			case MoveDirection.Up:
				viewControlLayer.Root?.SelectUp();
				break;
			case MoveDirection.Down:
				viewControlLayer.Root?.SelectDown();
				break;
			case MoveDirection.Left:
				viewControlLayer.Root?.SelectLeft();
				break;
			case MoveDirection.Right:
				viewControlLayer.Root?.SelectRight();
				break;
			}
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (value)
		{
			return;
		}
		if (View.CardDrawSettleRoot.activeSelf && View.CardDrawSettleComponent.TryUnFocusResult())
		{
			_settleNavigateData?.Reset();
		}
		else if (!View.TryExitSubState())
		{
			if (View.CardDrawSettleRoot.activeSelf && View.CardDrawSettleComponent.BtnClose.IsActive())
			{
				EventSystemHelper.Click(View.CardDrawSettleComponent.BtnClose);
			}
			else if (View.GachaViewRoot.activeSelf)
			{
				View.Close();
			}
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value && !View.CardDrawSettleComponent.TrySubmitResult())
		{
			View.OnConfirm();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnTenDraw(bool value)
	{
		if (value)
		{
			return;
		}
		if (View.CharacterShowRoot.activeSelf)
		{
			ActButton actButton = View.AcquireCharacterShowNewComponent?.ShareButton;
			if (actButton != null && actButton.IsActive())
			{
				EventSystemHelper.Click(actButton);
			}
		}
		else if (View.CardDrawSettleRoot.activeSelf)
		{
			ActButton actButton2 = View.CardDrawSettleComponent?.ShareButton;
			if (actButton2 != null && actButton2.IsActive())
			{
				EventSystemHelper.Click(actButton2);
			}
		}
		else
		{
			View.OnTenConfirm();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnOneDraw(bool value)
	{
		if (!value)
		{
			View.OnOneConfirm();
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void OnSelectResource(bool value)
	{
		if (!value)
		{
			View.OnChooseResource();
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void OnSelectFunction(bool value)
	{
		if (!value)
		{
			View.OnChooseFunction();
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void OnSelfChoose(bool value)
	{
		if (!value)
		{
			View.OnSelfChoose();
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void OnSwitchTabUp(bool value)
	{
		if (!value)
		{
			View.SwitchTab(next: false);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void OnSwitchTabDown(bool value)
	{
		if (!value)
		{
			View.SwitchTab(next: true);
		}
	}

	[GameInputBindingBool("UI/UISpecial4")]
	public void OnSpecial4(bool value)
	{
		if (!value)
		{
			View.OnSpecial4();
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void OnMilestoneReward(bool value)
	{
		if (!value && View.GachaViewRoot.activeSelf)
		{
			EventSystemHelper.Click(View.BtnMilestoneReward);
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	public void OnTargetGacha(bool value)
	{
		if (!value)
		{
			ActButton actButton = View?.BtnTargetGacha;
			if (actButton != null && actButton.gameObject.activeInHierarchy && actButton.IsInteractable())
			{
				EventSystemHelper.Click(actButton);
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigateVector2(Vector2 value)
	{
		if (View.CardDrawSettleComponent.IsResultFocused)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _settleNavigateData, ExecuteSettleNavigate);
			return;
		}
		_settleNavigateData?.Reset();
		View.OnNavigate(value);
	}

	[GameInputBindingVector2("UI/GamePadNavigate")]
	public void OnGamePadNavigateVector2(Vector2 value)
	{
	}

	[GameInputBindingFloat("UI/RSUpDownSelect")]
	public void OnRSUpDownSelect(float value)
	{
	}

	[GameInputBindingBool("UI/UISpecial9")]
	public void OnUISpecial9(bool value)
	{
		if (!value)
		{
			View.NormalJumpToCharacter();
		}
	}
}
