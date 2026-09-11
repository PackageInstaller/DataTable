using System.Collections.Generic;

namespace RogueCard;

public class ChangeRankAction : BaseAction
{
	public int num;

	public ChangeRankAction(int num)
	{
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		int rank = num;
		if (num == 0)
		{
			rank = RogueCardGameMain.Random.Range(2, 12);
		}
		List<RogueCardData> getWuChangSelect = RogueCardGameMain.GameContext.GetWuChangSelect;
		if (getWuChangSelect.Count > 0)
		{
			for (int i = 0; i < getWuChangSelect.Count; i++)
			{
				getWuChangSelect[i].rank = (Rank)rank;
			}
		}
		RogueCardGameMain.Instance.RefreshUI();
	}
}
