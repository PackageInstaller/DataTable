namespace RogueCard;

public class BetterStraightAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		RogueCardGameMain.GameContext.isBetterStraight = true;
	}

	public override void OnDisabled()
	{
		RogueCardGameMain.GameContext.isBetterStraight = false;
	}
}
