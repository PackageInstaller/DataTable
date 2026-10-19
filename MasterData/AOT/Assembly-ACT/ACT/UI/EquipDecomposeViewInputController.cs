using ACT.Battle;
using ACT.UI.InputController;
using ACT.Utility;
using UnityEngine;

namespace ACT.UI;

public class EquipDecomposeViewInputController : BaseUIViewInputController<EquipDecomposeView>
{
	public EquipDecomposeViewControllerType ControlType;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnInitView(EquipDecomposeView view)
	{
		base.OnInitView(view);
		ControlType = EquipDecomposeViewControllerType.Main;
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == EquipDecomposeViewControllerType.Menu)
			{
				View.ChangeEquipDecomeposeViewControl(EquipDecomposeViewControllerType.Main);
			}
			else if (ControlType == EquipDecomposeViewControllerType.Main)
			{
				View.Close();
			}
			else if (ControlType == EquipDecomposeViewControllerType.Filter)
			{
				View.InventoryFilterView.Close();
				View.ChangeEquipDecomeposeViewControl(EquipDecomposeViewControllerType.Menu);
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
		View.m_EquipDetailComp.FocusOut();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			return;
		}
		if (ControlType == EquipDecomposeViewControllerType.Main)
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
		View.HandleConfirm();
	}

	[GameInputBindingBool("UI/UISpecial4")]
	public void Start(bool value)
	{
		if (value && ControlType == EquipDecomposeViewControllerType.Main)
		{
			View.ChangeEquipDecomeposeViewControl(EquipDecomposeViewControllerType.Menu);
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void ButtonNorth(bool value)
	{
		if (!value)
		{
			return;
		}
		if (ControlType == EquipDecomposeViewControllerType.Main)
		{
			if (View.m_DissolveButton.IsInteractable())
			{
				View.DoDissolve();
			}
		}
		else if (ControlType == EquipDecomposeViewControllerType.Filter)
		{
			View.InventoryFilterView.OnClickConfirmButtonHandle();
			View.ChangeEquipDecomeposeViewControl(EquipDecomposeViewControllerType.Main);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void ButtonWest(bool value)
	{
		if (value)
		{
			if (ControlType == EquipDecomposeViewControllerType.Filter)
			{
				View.InventoryFilterView.OnClickResetButtonHandle();
				View.ChangeEquipDecomeposeViewControl(EquipDecomposeViewControllerType.Filter);
			}
			else if (ControlType == EquipDecomposeViewControllerType.Main && View.m_QuickFill.IsInteractable())
			{
				View.QuickFill();
			}
		}
	}
}
