using System.Collections.Generic;

namespace RogueCard;

public class ChangeAtPlayAction : BaseAction
{
	public int value;

	public int valueType;

	public ChangeAtPlayAction(int valueType, int value)
	{
		this.value = value;
		this.valueType = valueType;
	}

	public override void Execute(TriggerMoment moment)
	{
		List<RogueCardData> list = ((moment != TriggerMoment.OnCardPlayed && moment != TriggerMoment.OnScore) ? RogueCardGameMain.GameContext.GetSelectDataList() : RogueCardGameMain.GameContext.scoreResult.scoreCardData);
		int count = list.Count;
		if (valueType == 1)
		{
			(effectEntity as RogueCardJokerData).addPoint += count * value;
		}
		else if (valueType == 2)
		{
			(effectEntity as RogueCardJokerData).addMutli += count * value;
		}
	}
}
