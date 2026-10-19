using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class RogueTalentUnLockViewInputController : BaseUIViewInputController<RogueTalentUnLockView>
{
	protected override void OnActivate()
	{
		base.OnActivate();
		View.viewControlLayer.ReFocus();
	}

	[GameInputBindingVector2("UI/ScrollViewRightStickControl")]
	public void OnScroll(Vector2 value)
	{
		View.Scroll(value);
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void OpenNumber(bool value)
	{
		if (value)
		{
			View.CoinComponent.OnClick?.Invoke();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (View.BtnLevlUp.isActiveAndEnabled && !value)
		{
			View.OnLevelUp();
		}
	}
}
