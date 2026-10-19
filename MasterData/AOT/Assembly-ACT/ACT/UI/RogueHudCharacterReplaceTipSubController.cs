using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class RogueHudCharacterReplaceTipSubController : SubUIViewInputController<RogueHudCharacterReplaceTip>
{
	private ContinuousNavigateData navData;

	private bool InDetail { get; set; }

	private bool IsShowDetail { get; set; }

	protected override void OnActivate()
	{
		View.ControlLayer?.ReFocus();
		base.OnActivate();
		if (View.BtnFirstReplaceAndBuyGroup.gameObject.activeSelf)
		{
			EventSystemHelper.SetSelectedGameObject(View.BtnFirstReplaceAndBuy.gameObject);
		}
		else
		{
			EventSystemHelper.SetSelectedGameObject(View.BtnReplaceFirst.gameObject);
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void Detail(bool value)
	{
		if (value)
		{
			View.BtnDetails.OnClick?.Invoke();
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void FocusDetail(bool value)
	{
		if (value)
		{
			_ = IsShowDetail;
		}
	}

	[GameInputBindingBool("UI/Back")]
	public void Back(bool value)
	{
		if (value)
		{
			View.DetailLayer?.UnFocus();
			View.ControlLayer?.ReFocus();
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/Navigate", value: true);
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/Back", value: true);
			InDetail = false;
		}
	}

	[GameInputBindingBool("UI/Interact")]
	public void OnConfirm(bool value)
	{
		if (value)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (!(currentSelected == null))
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		navData?.Reset();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigateLeft(Vector2 value)
	{
		if (InDetail)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
			View.BindScrollRect();
			View.RefreshRightStickScrollForbid();
			View.ReBindBtnPrompt();
		}
	}

	[GameInputBindingVector2("UI/ScrollViewRightStickControl")]
	public void OnNavigate(Vector2 value)
	{
		if (InDetail)
		{
			View.Scroll(value);
		}
		else
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Left:
			EventSystemHelper.SetSelectedGameObject(View.BtnFirstReplaceAndBuyGroup.gameObject.activeSelf ? View.BtnFirstReplaceAndBuy.gameObject : View.BtnReplaceFirst.gameObject);
			break;
		case MoveDirection.Right:
			EventSystemHelper.SetSelectedGameObject(View.BtnFirstReplaceAndBuyGroup.gameObject.activeSelf ? View.BtnSecondReplaceAndBuy.gameObject : View.BtnReplaceSecond.gameObject);
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
		}
	}
}
