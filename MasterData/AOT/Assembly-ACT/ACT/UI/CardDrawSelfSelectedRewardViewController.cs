using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class CardDrawSelfSelectedRewardViewController : BaseUIViewInputController<CardDrawSelfSelectedRewardView>
{
	protected override void OnBackPressed(bool value)
	{
		if (!View.isEmpty && !value)
		{
			View.CloseFromGamepad();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		View.OnNavigateCharacterCard(value);
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnTrial(bool value)
	{
		if (!value)
		{
			View.OnTrialFromGamepad();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnExchange(bool value)
	{
		if (!value)
		{
			View.OnExchangeFromGamepad();
		}
	}
}
