namespace RogueCard;

public class BetterHandAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		RogueCardGameMain.GameContext.handTrigger = true;
	}

	public override void OnDisabled()
	{
		RogueCardGameMain.GameContext.handTrigger = false;
	}
}
