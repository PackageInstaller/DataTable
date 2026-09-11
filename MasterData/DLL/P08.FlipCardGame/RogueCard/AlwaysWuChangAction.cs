namespace RogueCard;

public class AlwaysWuChangAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		RogueCardGameMain.GameContext.isAlwaysWuChang = true;
	}

	public override void OnDisabled()
	{
		RogueCardGameMain.GameContext.isAlwaysWuChang = false;
	}
}
