using ACT.Battle;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class EquipLevelUpViewInputController : BaseUIViewInputController<EquipLevelUpView>
{
	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.OnCancle();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		View?.OnNavigate(value);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnUpgrade(bool value)
	{
		if (value)
		{
			View?.ActionLevelUp();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/Confirm", () =>
			{
				View?.ActionLevelUp();
			}, 0.3f, -1, 0.15f);
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void OnShowCoinDetail(bool value)
	{
		if (!value)
		{
			View?.OnShowCoinDetail();
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void OnSelectMaterialList(bool value)
	{
		if (!value)
		{
			View?.OnGamePadSelectMaterialList();
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	public void OnLevelDown(bool value)
	{
		if (value)
		{
			View?.OnPageDown();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/LeftTrigger", () =>
			{
				View?.OnPageDown();
			}, 0.3f, -1, 0.15f);
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	public void OnLevelUp(bool value)
	{
		if (value)
		{
			View?.OnPageUp();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/RightTrigger", () =>
			{
				View?.OnPageUp();
			}, 0.3f, -1, 0.15f);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnSelectMaxLevel(bool value)
	{
		if (value)
		{
			View?.ScrollToMaxAllowedLevel();
		}
	}
}
