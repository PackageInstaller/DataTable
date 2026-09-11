using System;

namespace RogueCard;

public class AddTargetHandTypeLevelAction : BaseAction
{
	public int handType;

	public int num;

	public AddTargetHandTypeLevelAction(int type, int num)
	{
		handType = type;
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		if (RogueCardGameMain.GameContext.isRestoringSave)
		{
			return;
		}
		if (handType == 0)
		{
			foreach (HandType value in Enum.GetValues(typeof(HandType)))
			{
				RogueCardGameMain.GameContext.handTypeLevel[value] += num;
			}
			RogueCardGameMain.Instance.ShowSuitLvUp(0, num);
		}
		else
		{
			RogueCardGameMain.GameContext.handTypeLevel[(HandType)handType] += num;
		}
	}
}
