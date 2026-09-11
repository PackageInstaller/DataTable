namespace RogueCard;

public class IgnoreBossEffectAction : BaseAction
{
	public override void Execute(TriggerMoment moment)
	{
		RogueCardGameMain.GameContext.ignoreWoe = true;
		RogueCardGameMain.GameContext.RefreshWoeEffect();
	}

	public override void OnDisabled()
	{
		RogueCardGameMain.GameContext.ignoreWoe = false;
		RogueCardGameMain.GameContext.RefreshWoeEffect();
	}
}
