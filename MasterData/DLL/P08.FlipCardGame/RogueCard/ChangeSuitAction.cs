using System.Collections.Generic;

namespace RogueCard;

public class ChangeSuitAction : BaseAction
{
	public Suit suit;

	public ChangeSuitAction(int suit)
	{
		this.suit = (Suit)suit;
	}

	public override void Execute(TriggerMoment moment)
	{
		List<RogueCardData> getWuChangSelect = RogueCardGameMain.GameContext.GetWuChangSelect;
		if (getWuChangSelect.Count > 0)
		{
			for (int i = 0; i < getWuChangSelect.Count; i++)
			{
				getWuChangSelect[i].suit = suit;
			}
		}
		RogueCardGameMain.Instance.RefreshUI();
	}
}
