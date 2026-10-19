using ACT.Battle;
using Fundamental;

namespace ACT.UI;

public class CharacterTutorialEntranceInputController : BaseUIViewInputController<CharacterTutorialEntranceBaseView>
{
	protected override void OnActivate()
	{
		View?.RefreshBottomBtnPrompt();
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnSpecial1(bool value)
	{
		if (value && !(View == null))
		{
			View.HandleGamePadSpecial1();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		base.OnBackPressed(value);
	}
}
