using System.Collections.Generic;

namespace RogueCard;

public class AddRankAction : BaseAction
{
	public int num;

	public AddRankAction(int num)
	{
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		List<RogueCardData> getWuChangSelect = RogueCardGameMain.GameContext.GetWuChangSelect;
		if (getWuChangSelect.Count > 0)
		{
			for (int i = 0; i < getWuChangSelect.Count; i++)
			{
				RogueCardData rogueCardData = getWuChangSelect[i];
				int num = (int)(rogueCardData.rank + this.num);
				if (num > 11)
				{
					num = num - 11 + 1;
				}
				rogueCardData.rank = (Rank)num;
			}
		}
		RogueCardGameMain.Instance.RefreshUI();
	}
}
