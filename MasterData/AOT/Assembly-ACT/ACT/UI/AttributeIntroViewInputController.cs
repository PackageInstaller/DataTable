using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class AttributeIntroViewInputController : BaseUIViewInputController<AttributeIntroView>
{
	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.OnGamePadClose();
		}
	}

	[GameInputBindingVector2("UI/RightStickNavigate")]
	public void OnRightStickNavigate(Vector2 value)
	{
		View?.OnScrollbarNavigate(value);
	}
}
