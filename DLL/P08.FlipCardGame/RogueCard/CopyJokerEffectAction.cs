namespace RogueCard;

public class CopyJokerEffectAction : BaseAction
{
	public int target;

	public CopyJokerEffectAction(int target)
	{
		this.target = target;
	}

	public override void Execute(TriggerMoment moment)
	{
	}

	public bool CheckCopy()
	{
		RogueCardJokerData leftJoker = RogueCardGameMain.GameContext.jokerData.GetCardDataAtDisplayIndex(0);
		if (leftJoker != null && RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == leftJoker.realID).no_copy)
		{
			return false;
		}
		return true;
	}
}
