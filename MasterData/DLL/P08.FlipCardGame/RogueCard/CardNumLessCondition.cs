using System.Collections.Generic;

namespace RogueCard;

public class CardNumLessCondition : BaseCondition
{
	public int value;

	public CardNumLessCondition(int[] param)
	{
		value = param[0];
	}

	public override bool Check(TriggerMoment moment)
	{
		List<RogueCardData> list = null;
		list = RogueCardGameMain.GameContext.scoreResult.scoreCardData;
		if (list == null || list.Count == 0)
		{
			list = RogueCardGameMain.GameContext.GetSelectDataList();
		}
		if (list == null || list.Count > value)
		{
			return false;
		}
		return true;
	}
}
