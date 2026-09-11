namespace RogueCard;

public abstract class BaseAction
{
	public int effectID;

	public IEffectEntity effectEntity;

	public RogueCardJokerData otherJoker;

	public ActionType Type { get; protected set; }

	protected ScoreBase GetScoreBase()
	{
		if (effectEntity == null)
		{
			return null;
		}
		if (effectEntity is RogueCardData)
		{
			return ScorePool.GetCardScore(effectEntity as RogueCardData);
		}
		if (effectEntity is RogueCardJokerData)
		{
			if (otherJoker != null)
			{
				return ScorePool.GetJokerScore(otherJoker);
			}
			return ScorePool.GetJokerScore(effectEntity as RogueCardJokerData);
		}
		return null;
	}

	public abstract void Execute(TriggerMoment moment);

	public virtual void OnDisabled()
	{
	}
}
