using ACT.Battle;
using ACT.UI.InputController;
using UnityEngine;

namespace ACT.UI;

public class InventoryEquipSuitFilterViewInputController : BaseUIViewInputController<InventoryEquipSuitFilterView>
{
	private ContinuousNavigateData _curNavigateData;

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void ButtonWest(bool value)
	{
		if (value)
		{
			View.CleanSelectedEquipSuits();
			View.ViewControlLayer.UnFocus();
			View.ViewControlLayer.Focus();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void ButtonNorth(bool value)
	{
		if (value)
		{
			View.OnConfirmButtonHandle();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value && !(EventSystemHelper.CurrentSelected == null))
		{
			EventSystemHelper.ClickCurrent();
		}
	}
}
