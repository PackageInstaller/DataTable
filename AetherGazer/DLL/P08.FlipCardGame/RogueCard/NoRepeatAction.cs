namespace RogueCard;

public class NoRepeatAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		RogueCardGameMain.GameContext.isDisableType = true;
		RogueCardGameMain.GameContext.disableType.Clear();
	}

	public override void OnDisabled()
	{
		RogueCardGameMain.GameContext.isDisableType = false;
		RogueCardGameMain.GameContext.disableType.Clear();
	}
}
