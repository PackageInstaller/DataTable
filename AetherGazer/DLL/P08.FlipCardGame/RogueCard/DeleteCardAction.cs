namespace RogueCard;

public class DeleteCardAction : BaseAction
{
	public int num;

	public DeleteCardAction(int num)
	{
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		RogueCardGameMain.Instance.RemoveCard(num);
	}
}
