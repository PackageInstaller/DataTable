namespace RogueCard;

public class OddEvenAction : BaseAction
{
	private int even;

	private int odd;

	public OddEvenAction(int type1, int type2)
	{
		even = type1;
		odd = type2;
	}

	public override void Execute(TriggerMoment moment)
	{
		RogueCardGameMain.GameContext.isOddEven = true;
		RogueCardGameMain.GameContext.oddValue = (Rank)odd;
		RogueCardGameMain.GameContext.evenValue = (Rank)even;
	}

	public override void OnDisabled()
	{
		base.OnDisabled();
		RogueCardGameMain.GameContext.isOddEven = false;
	}
}
