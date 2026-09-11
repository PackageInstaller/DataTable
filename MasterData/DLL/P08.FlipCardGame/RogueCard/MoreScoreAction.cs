namespace RogueCard;

public class MoreScoreAction : BaseAction
{
	private int num;

	public int Percent => num;

	public MoreScoreAction(int num)
	{
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
	}

	public override void OnDisabled()
	{
		base.OnDisabled();
	}
}
