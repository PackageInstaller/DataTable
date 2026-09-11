namespace RogueCard;

public class ChangeValueByJokerSlotAction : BaseAction
{
	private int type;

	private int num;

	public int Num => num;

	public ChangeValueByJokerSlotAction(int type, int num)
	{
		this.type = type;
		this.num = num;
	}

	public override void Execute(TriggerMoment moment)
	{
		if (moment == TriggerMoment.OnJokerPlayed)
		{
			int num = RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerMaxNum] - RogueCardGameMain.GameContext.jokerData.HandCount;
			if (num >= 1)
			{
				JokerScore jokerScore = GetScoreBase() as JokerScore;
				jokerScore.multi += this.num * num;
				RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(jokerScore);
			}
		}
	}
}
