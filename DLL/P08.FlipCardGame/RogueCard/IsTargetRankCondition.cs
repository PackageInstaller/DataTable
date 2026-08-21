namespace RogueCard;

public class IsTargetRankCondition : BaseCondition
{
	public int value;

	public IsTargetRankCondition(int[] param)
	{
		value = param[0];
	}

	public override bool Check(TriggerMoment moment)
	{
		switch (moment)
		{
		case TriggerMoment.OnScore:
			if ((RogueCardScoreSystem.Instance.curScoringCard?.GetFinalRank).Value == value)
			{
				return true;
			}
			break;
		case TriggerMoment.OnHandPlayed:
			if (RogueCardGameMain.GameContext.curEffectData.GetRank != (Rank)value)
			{
				return false;
			}
			return true;
		}
		return false;
	}
}
