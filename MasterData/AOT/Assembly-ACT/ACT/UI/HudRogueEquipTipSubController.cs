using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class HudRogueEquipTipSubController : SubUIViewInputController<HudRogueEquipTip>
{
	private ContinuousNavigateData navData;

	private bool InDetail { get; set; }

	private bool IsShowDetail { get; set; }

	[GameInputBindingBool("UI/Interact")]
	public void Confirm(bool value)
	{
		if (value)
		{
			if (View.BtnBuy.gameObject.activeInHierarchy)
			{
				EventSystemHelper.Click(View.BtnBuy);
			}
			else if (View.BtnGet.gameObject.activeInHierarchy)
			{
				EventSystemHelper.Click(View.BtnGet);
			}
			else if (View.BtnReplace.gameObject.activeInHierarchy)
			{
				EventSystemHelper.Click(View.BtnReplace);
			}
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void Detail(bool value)
	{
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
		if (value && InDetail)
		{
			View.ControlLayer.UnFocus();
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/Navigate", value: false);
			Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/Back", value: false);
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		navData?.Reset();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (InDetail)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
		}
	}

	[GameInputBindingVector2("UI/ScrollViewRightStickControl")]
	public void OnScroll(Vector2 value)
	{
		if (InDetail)
		{
			View.Scroll(value);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		ViewControlRoot root = View.ControlLayer.Root;
		if ((bool)root)
		{
			switch (dir)
			{
			case MoveDirection.Up:
				root.SelectUp();
				break;
			case MoveDirection.Down:
				root.SelectDown();
				break;
			case MoveDirection.Left:
				root.SelectLeft();
				break;
			case MoveDirection.Right:
				root.SelectRight();
				break;
			}
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (!(currentSelected == null))
			{
				currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
				View.BindScrollRect();
				View.RefreshRightStickScrollForbid();
				View.ReBindBtnPrompt();
			}
		}
	}
}
