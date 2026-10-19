using ACT.Battle;

namespace ACT.UI;

public class EquipBuildSuccessViewInputController : BaseUIViewInputController<EquipBuildSuccessView>
{
	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.OnGamePadClose();
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void OnOpenEquipFeatureDetail(bool value)
	{
		if (!value)
		{
			View?.OnGamePadOpenBuffDetail();
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void OnToggleEquipLock(bool value)
	{
		if (!value)
		{
			View?.OnGamePadToggleLock();
		}
	}
}
