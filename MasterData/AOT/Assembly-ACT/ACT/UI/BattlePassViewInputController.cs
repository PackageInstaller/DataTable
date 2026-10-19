using ACT.Battle;
using Fundamental;

namespace ACT.UI;

public class BattlePassViewInputController : BaseUIViewInputController<BattlePassView>
{
	[GameInputBindingBool("UI/UISpecial4")]
	private void OnSpecial4(bool value)
	{
		if (value && !(View == null))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPBATTLEPASSBUYLEVEL);
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	private void OnSpecial6(bool value)
	{
		if (value && !(View == null))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
			{
				titleTextId = 2400,
				titleStringType = "Common",
				descTextId = 2427,
				localizedStringType = "Common",
				iconId = 1044
			});
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	private void SwitchPageUp(bool value)
	{
		if (value && !(View == null))
		{
			View.SwitchBattlePassTab(-1);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	private void SwitchPageDown(bool value)
	{
		if (value && !(View == null))
		{
			View.SwitchBattlePassTab(1);
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.HandleBack();
		}
	}
}
