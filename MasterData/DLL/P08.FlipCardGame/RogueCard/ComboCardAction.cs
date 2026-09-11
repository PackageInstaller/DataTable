namespace RogueCard;

public class ComboCardAction : BaseAction
{
	private int type;

	private int num;

	public Rank Rank => RogueCardGameMain.GameContext.randomRank;

	public ComboCardAction(int type, int num)
	{
		this.type = type;
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		if (moment != TriggerMoment.OnCardPlayed)
		{
			return;
		}
		RogueCardData[] array = RogueCardGameMain.GameContext.scoreResult.scoreCardData.ToArray();
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].GetRank == Rank)
			{
				(effectEntity as RogueCardJokerData).addMutli = 0;
				return;
			}
		}
		(effectEntity as RogueCardJokerData).addMutli += num;
	}

	public override void OnDisabled()
	{
		base.OnDisabled();
	}
}
