namespace RogueCard;

public class OnlyOneAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		RogueCardGameMain.GameContext.isOnlyType = true;
		RogueCardGameMain.GameContext.onlyType = null;
	}

	public override void OnDisabled()
	{
		RogueCardGameMain.GameContext.isOnlyType = false;
		RogueCardGameMain.GameContext.onlyType = null;
	}
}
