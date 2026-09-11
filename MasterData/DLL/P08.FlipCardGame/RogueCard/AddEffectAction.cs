namespace RogueCard;

public class AddEffectAction : BaseAction
{
	private EntityType entityType;

	private int buffID;

	public AddEffectAction(int entity, int buff)
	{
		buffID = buff;
	}

	public override void Execute(TriggerMoment moment)
	{
		RogueCardEffectManager.Instance.RegistEffect(buffID, EntityType.Player);
		if ((effectEntity is RogueCardJokerData && (effectEntity as RogueCardJokerData).id == 122) || (effectEntity as RogueCardJokerData).realID == 306 || effectID == 1221)
		{
			JokerScore jokerScore = GetScoreBase() as JokerScore;
			jokerScore.jokerData = effectEntity as RogueCardJokerData;
			jokerScore.addDiscard = 1;
			RogueCardGameMain.Instance.DelayDiscardNumDisplay(jokerScore.addDiscard);
			RogueCardGameMain.Instance.gameContext.scoreResult.AddScoreData(jokerScore);
		}
	}
}
