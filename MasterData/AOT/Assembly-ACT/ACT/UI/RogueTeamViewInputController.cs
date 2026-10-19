using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class RogueTeamViewInputController : BaseUIViewInputController<RogueTeamView>
{
	private ContinuousNavigateData navData;

	protected override void OnActivate()
	{
		base.OnActivate();
		GetFocusedLayer()?.ReFocus();
		View.RefreshGamePadPrompt();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		navData?.Reset();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value || View.IsTalentNodeTipsActive)
		{
			return;
		}
		if (View.rightPanelControlLayer != null && View.rightPanelControlLayer.IsFocused)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (currentSelected == null)
			{
				View.rightPanelControlLayer.ReFocus();
			}
			else
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
		else
		{
			View.OnNext();
		}
	}

	[GameInputBindingBool("UI/View")]
	public void FocusRightPanel(bool value)
	{
		if (value && !View.IsTalentNodeTipsActive && !(View.rightPanelControlLayer == null) && !View.rightPanelControlLayer.IsFocused)
		{
			View.rightPanelControlLayer.ReFocus();
			navData?.Reset();
			View.RefreshGamePadPrompt();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void ToggleTalentNodeTips(bool value)
	{
		if (value && !(View.BtnTalenNode == null) && View.BtnTalenNode.gameObject.activeInHierarchy && View.BtnTalenNode.interactable)
		{
			View.BtnTalenNode.OnClick?.Invoke();
			if (View.IsTalentNodeTipsActive)
			{
				navData?.Reset();
			}
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!((View == null || View.isEmpty) | value))
		{
			if (View.IsTalentNodeTipsActive)
			{
				View.HideTalentNodeTips();
				StopActionPropagation("UI/Back");
			}
			else if (View.rightPanelControlLayer != null && View.rightPanelControlLayer.IsFocused)
			{
				View.viewControlLayer.ReFocus();
				navData?.Reset();
				View.RefreshGamePadPrompt();
			}
			else
			{
				View.Close();
			}
		}
	}

	[GameInputBindingVector2("UI/ScrollViewRightStickControl")]
	public void OnScroll(Vector2 value)
	{
		if (!View.IsTalentNodeTipsActive)
		{
			View.Scroll(value);
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (View.IsTalentNodeTipsActive)
		{
			navData?.Reset();
		}
		else
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		if (View.IsTalentNodeTipsActive)
		{
			navData?.Reset();
			return;
		}
		ViewControlLayer focusedLayer = GetFocusedLayer();
		switch (dir)
		{
		case MoveDirection.Up:
			focusedLayer?.Root?.SelectUp();
			break;
		case MoveDirection.Down:
			focusedLayer?.Root?.SelectDown();
			break;
		case MoveDirection.Left:
			focusedLayer?.Root?.SelectLeft();
			break;
		case MoveDirection.Right:
			focusedLayer?.Root?.SelectRight();
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			if (focusedLayer == View.viewControlLayer)
			{
				EventSystemHelper.Click(currentSelected);
			}
			currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
		}
	}

	private ViewControlLayer GetFocusedLayer()
	{
		if (View.rightPanelControlLayer != null && View.rightPanelControlLayer.IsFocused)
		{
			return View.rightPanelControlLayer;
		}
		return View.viewControlLayer;
	}
}
