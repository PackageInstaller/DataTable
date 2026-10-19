using ACT.Battle;
using ACT.UI.InputController;

namespace ACT.UI;

public sealed class FullScreenVideoViewInputController : BaseUIViewInputController<FullScreenVideoView>
{
	[GameInputBindingBool("Conversation/ConversationSkip")]
	private void OnSkip(bool value)
	{
		if (value && !(View == null) && !View.isEmpty)
		{
			StopActionPropagation("Conversation/ConversationSkip");
			ActButton skipButton = View.SkipButton;
			if (!(skipButton == null) && skipButton.gameObject.activeInHierarchy && skipButton.IsInteractable() && EventSystemHelper.Available)
			{
				EventSystemHelper.Click(skipButton);
			}
		}
	}

	protected override void OnBackPressed(bool value)
	{
		OnSkip(value);
	}
}
