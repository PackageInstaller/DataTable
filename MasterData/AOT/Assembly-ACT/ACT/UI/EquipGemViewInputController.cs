using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class EquipGemViewInputController : BaseUIViewInputController<EquipGemView>
{
	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (!(View == null))
		{
			View?.OnNavigate(value);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnEquipGem(bool value)
	{
		if (!value)
		{
			View?.OnGamePadEquipGem();
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void OnChangeLockState(bool value)
	{
		if (!value)
		{
			View?.OnGamePadLockGem();
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void ShowAllFeature(bool value)
	{
		if (!value)
		{
			View?.OnGamePadShowAllFeature();
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void OnPagePre(bool value)
	{
		if (!value)
		{
			View?.OnGamePadPageNext();
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void OnPageNext(bool value)
	{
		if (!value)
		{
			View?.OnGamePadPagePre();
		}
	}

	[GameInputBindingVector2("UI/RightStickNavigate")]
	public void OnRightStickNavigate(Vector2 value)
	{
		View?.OnRightStickNavigate(value);
	}
}
