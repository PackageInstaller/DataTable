namespace RogueCard;

public class OtherSuitAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		RogueCardGameMain.GameContext.isOtherSuit = true;
	}

	public override void OnDisabled()
	{
		RogueCardGameMain.GameContext.isOtherSuit = false;
	}
}
