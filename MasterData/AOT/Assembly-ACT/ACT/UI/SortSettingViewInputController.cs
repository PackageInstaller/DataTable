using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class SortSettingViewInputController : BaseUIViewInputController<SortSettingView>
{
	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		View?.OnNavigate(value);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value)
		{
			View?.OnGamePadConfirm();
		}
	}

	[GameInputBindingBool("UI/Back")]
	public void OnBack(bool value)
	{
		if (!value)
		{
			View?.OnGamePadBack();
			StopActionPropagation("UI/Back");
		}
	}
}
