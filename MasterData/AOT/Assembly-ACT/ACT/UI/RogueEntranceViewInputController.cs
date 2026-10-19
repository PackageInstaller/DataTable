using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class RogueEntranceViewInputController : BaseUIViewInputController<RogueEntranceView>
{
	private ContinuousNavigateData navData;

	private ViewControlLayer _rewardLayer;

	private bool _rewardLayerHooked;

	private ViewControlLayer RewardLayer
	{
		get
		{
			if (_rewardLayer == null && View != null && View.CommonSubWorldEntranceRewards != null)
			{
				_rewardLayer = View.CommonSubWorldEntranceRewards.GetComponentInChildren<ViewControlLayer>(includeInactive: true);
			}
			return _rewardLayer;
		}
	}

	private bool IsRewardFocused
	{
		get
		{
			if (RewardLayer != null)
			{
				return RewardLayer.IsFocused;
			}
			return false;
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		BindRewardLayer();
		RefreshGamePadTips();
		View.viewControlLayer.ReFocus();
	}

	protected override void OnDeactivate()
	{
		UnbindRewardLayer();
		if (View != null)
		{
			View.SetDescriptionScrollSuspended(suspended: false);
			View.ScrollDescription(Vector2.zero);
		}
		base.OnDeactivate();
		navData?.Reset();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (View == null)
		{
			return;
		}
		if (type != DeviceInputMode.Gamepad)
		{
			if (IsRewardFocused)
			{
				ExitRewardFocus();
			}
			return;
		}
		if (IsRewardFocused)
		{
			RewardLayer.ReFocus();
		}
		else
		{
			View.viewControlLayer.ReFocus();
		}
		RefreshGamePadTips();
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (IsRewardFocused)
			{
				ExitRewardFocus();
			}
			else
			{
				base.OnBackPressed(value: false);
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OpenSkillTree(bool value)
	{
		if (value && !IsRewardFocused)
		{
			View.BtnSkillTree.OnClick?.Invoke();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OpenShop(bool value)
	{
		if (value && !IsRewardFocused)
		{
			View.BtnRogueShop.OnClick?.Invoke();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			if (IsRewardFocused)
			{
				SubmitSelected();
			}
			else if (View.IsContinue)
			{
				View.BtnContinue.OnClick?.Invoke();
			}
			else
			{
				View.BtnStart.OnClick?.Invoke();
			}
		}
	}

	[GameInputBindingBool("UI/Start")]
	private void OnGamepadMenuOver(bool value)
	{
		if (value && !(View == null) && View.IsContinue && !IsRewardFocused)
		{
			ActButton btnOver = View.BtnOver;
			EventSystem current = EventSystem.current;
			if (!(btnOver == null) && !(current == null) && btnOver.gameObject.activeInHierarchy && btnOver.IsInteractable())
			{
				ExecuteEvents.Execute(btnOver.gameObject, new BaseEventData(current), ExecuteEvents.submitHandler);
			}
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void OnSelectReward(bool value)
	{
		if (value && !(View == null) && !IsRewardFocused)
		{
			ViewControlLayer rewardLayer = RewardLayer;
			if (!(rewardLayer == null) && rewardLayer.IsValid() && !(rewardLayer.GetDefault() == null))
			{
				rewardLayer.ReFocus();
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (IsRewardFocused)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteRewardNavigate);
		}
		else if (!View.IsContinue && !View.CoinGroup.IsOperating)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
		}
	}

	[GameInputBindingVector2("UI/ScrollViewRightStickControl")]
	public void OnDescriptionScroll(Vector2 value)
	{
		if (View == null || IsRewardFocused)
		{
			View?.ScrollDescription(Vector2.zero);
		}
		else
		{
			View.ScrollDescription(value);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			View.viewControlLayer.Root?.SelectUp();
			break;
		case MoveDirection.Down:
			View.viewControlLayer.Root?.SelectDown();
			break;
		case MoveDirection.Left:
			View.viewControlLayer.Root?.SelectLeft();
			break;
		case MoveDirection.Right:
			View.viewControlLayer.Root?.SelectRight();
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
			EventSystemHelper.Click(currentSelected);
		}
	}

	private void ExecuteRewardNavigate(MoveDirection dir)
	{
		ViewControlRoot viewControlRoot = ((RewardLayer != null) ? RewardLayer.Root : View.viewControlLayer.Root);
		switch (dir)
		{
		case MoveDirection.Up:
			viewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			viewControlRoot?.SelectDown();
			break;
		case MoveDirection.Left:
			viewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			viewControlRoot?.SelectRight();
			break;
		}
		(EventSystem.current?.currentSelectedGameObject)?.GetComponent<ItemUIComponentBase>()?.SetIsOn(val: true);
	}

	private void SubmitSelected()
	{
		EventSystem current = EventSystem.current;
		GameObject gameObject = current?.currentSelectedGameObject;
		if (!(gameObject == null) && !(current == null))
		{
			ExecuteEvents.Execute(gameObject, new BaseEventData(current), ExecuteEvents.submitHandler);
		}
	}

	private void BindRewardLayer()
	{
		ViewControlLayer rewardLayer = RewardLayer;
		if (!(rewardLayer == null) && !_rewardLayerHooked)
		{
			rewardLayer.OnFocusChanged.AddListener(OnRewardFocusChanged);
			_rewardLayerHooked = true;
		}
	}

	private void UnbindRewardLayer()
	{
		if (_rewardLayer != null && _rewardLayerHooked)
		{
			_rewardLayer.OnFocusChanged.RemoveListener(OnRewardFocusChanged);
		}
		_rewardLayerHooked = false;
		_rewardLayer = null;
	}

	private void OnRewardFocusChanged(bool focused)
	{
		navData?.Reset();
		if (View != null)
		{
			View.SetDescriptionScrollSuspended(focused);
		}
		RefreshGamePadTips(focused);
	}

	private void ExitRewardFocus()
	{
		(EventSystem.current?.currentSelectedGameObject)?.GetComponent<ItemUIComponentBase>()?.SetIsOn(val: false);
		View.viewControlLayer.ReFocus();
	}

	private void RefreshGamePadTips()
	{
		RefreshGamePadTips(IsRewardFocused);
	}

	private void RefreshGamePadTips(bool rewardFocused)
	{
		if (!(View == null) && !(View.gamePadTipsComp == null))
		{
			if (rewardFocused)
			{
				View.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.BackAction);
			}
			else
			{
				View.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.BackAction, GamePadTipHelper.ScrollAction);
			}
		}
	}
}
