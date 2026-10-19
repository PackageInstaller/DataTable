using ACT.Battle;
using ACT.UI.InputController;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class InventoryViewInputController : BaseUIViewInputController<MonoInventoryView>
{
	public InventoryViewControlType ControlType;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnInitView(MonoInventoryView view)
	{
		base.OnInitView(view);
		ControlType = InventoryViewControlType.Main;
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == InventoryViewControlType.Main)
			{
				View.Close();
			}
			else if (ControlType == InventoryViewControlType.Filter)
			{
				View.InventoryFilterView.Close();
				View.ChangeInventoryViewControl(InventoryViewControlType.Menu);
			}
			else if (ControlType == InventoryViewControlType.Sort)
			{
				View.InventorySortView.Close();
				View.ChangeInventoryViewControl(InventoryViewControlType.Menu);
			}
			else if (ControlType == InventoryViewControlType.Resources)
			{
				View.ChangeInventoryViewControl(InventoryViewControlType.Main);
			}
			else if (ControlType == InventoryViewControlType.Menu)
			{
				View.ChangeInventoryViewControl(InventoryViewControlType.Main);
			}
			else if (ControlType == InventoryViewControlType.Recovery)
			{
				View.InventoryRecoveryView.OnClickCloseRecoveryBtnHandle();
				View.ChangeInventoryViewControl(InventoryViewControlType.Main);
			}
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnControllerActivate();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
		View.CommonItemDetail.FocusOut();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void LeftShoulder(bool value)
	{
		if (value && (ControlType == InventoryViewControlType.Main || ControlType == InventoryViewControlType.Recovery))
		{
			View.OnUpInventoryTab();
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void RightShoulder(bool value)
	{
		if (value && (ControlType == InventoryViewControlType.Main || ControlType == InventoryViewControlType.Recovery))
		{
			View.OnDownInventoryTab();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			return;
		}
		if (ControlType == InventoryViewControlType.Recovery)
		{
			ItemUIComponentBase component = EventSystemHelper.CurrentSelected.GetComponent<ItemUIComponentBase>();
			if (component != null)
			{
				if (component.IsChosen)
				{
					component.OnInvertClick();
				}
				else
				{
					EventSystemHelper.Click(component);
				}
				View.GamepadSelectPromtText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, component.IsChosen ? 14 : 774);
				return;
			}
		}
		else if (ControlType == InventoryViewControlType.Main && View.triggerCellBtn.gameObject.activeSelf && View.triggerCellBtn.IsInteractable())
		{
			EventSystemHelper.Click(View.triggerCellBtn);
			return;
		}
		View.HandleConfirm();
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void ButtonWest(bool value)
	{
		if (!value)
		{
			return;
		}
		if (ControlType == InventoryViewControlType.Filter)
		{
			View.InventoryFilterView.OnClickResetButtonHandle();
			View.ChangeInventoryViewControl(InventoryViewControlType.Filter);
		}
		else if (ControlType == InventoryViewControlType.Main)
		{
			if (View.Recovery.gameObject.activeSelf && View.Recovery.IsInteractable())
			{
				View.OnClickRecovreryBtnHandle();
				View.ChangeInventoryViewControl(InventoryViewControlType.Recovery);
			}
		}
		else if (ControlType == InventoryViewControlType.Recovery)
		{
			View.InventoryRecoveryView.OnClickQuickFillBtnHandle();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void ButtonNorth(bool value)
	{
		if (value)
		{
			if (ControlType == InventoryViewControlType.Filter)
			{
				View.InventoryFilterView.OnClickConfirmButtonHandle();
				View.ChangeInventoryViewControl(InventoryViewControlType.Main);
			}
			else if (ControlType == InventoryViewControlType.Recovery)
			{
				View.InventoryRecoveryView.OnClickRecoveryBtnHandle();
			}
			else if (ControlType == InventoryViewControlType.Sort)
			{
				View.InventorySortView.OnClickConfirmBtnHandle();
				View.ChangeInventoryViewControl(InventoryViewControlType.Main);
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void RightStickPress(bool value)
	{
		if (value && ControlType == InventoryViewControlType.Main)
		{
			View.ChangeInventoryViewControl(InventoryViewControlType.Resources);
		}
	}

	[GameInputBindingBool("UI/UISpecial4")]
	public void Start(bool value)
	{
		if (value && ControlType == InventoryViewControlType.Main)
		{
			View.ChangeInventoryViewControl(InventoryViewControlType.Menu);
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void LeftStickPress(bool value)
	{
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void Select(bool value)
	{
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	public void LeftTrigger(bool value)
	{
		if (value && ControlType == InventoryViewControlType.Recovery && View.InventoryRecoveryView.IsMins())
		{
			View.InventoryRecoveryView.Mins();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/LeftTrigger", View.InventoryRecoveryView.Mins, 0.3f, -1, 0.15f);
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	public void RightTrigger(bool value)
	{
		if (value && ControlType == InventoryViewControlType.Recovery && View.InventoryRecoveryView.IsPlus())
		{
			View.InventoryRecoveryView.Plus();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/RightTrigger", View.InventoryRecoveryView.Plus, 0.3f, -1, 0.15f);
		}
	}
}
