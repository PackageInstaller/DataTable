using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class CharacterDestinySubInputController : SubUIViewInputController<DestinySubView>
{
	[GameInputBindingBool("UI/Back")]
	public void Back(bool value)
	{
		if (!value)
		{
			(View.ParentUIView as CharacterView)?.CloseSubView();
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			View.RightStickPressed();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnSubmit(bool value)
	{
		if (value)
		{
			View.Confirm();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		View.Navigate(value);
	}
}
