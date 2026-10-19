using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class EquipSuitFilterViewInputController : BaseUIViewInputController<EquipSuitFilterView>
{
	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value)
		{
			View?.OnConfirm();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (!(View == null))
		{
			View.OnNavigate(value);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnSpecial1(bool value)
	{
		if (!value)
		{
			View?.OnSpecial1ClearSelected();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnSpecial2(bool value)
	{
		if (!value)
		{
			View?.OnSpecial2Confirm();
		}
	}
}
