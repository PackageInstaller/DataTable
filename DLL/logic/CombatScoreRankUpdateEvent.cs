public sealed class CombatScoreRankUpdateEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mEntityID;

	public int mValue;

	public int mLastValue;

	public CombatScoreRankUpdateEvent(int entityID, int value, int lastValue)
	{
		mEntityID = entityID;
		mValue = value;
		mLastValue = lastValue;
	}

	public CombatScoreRankUpdateEvent()
	{
	}

	public static CombatScoreRankUpdateEvent Claim(int entityID, int value, int lastValue)
	{
		CombatScoreRankUpdateEvent combatScoreRankUpdateEvent = FrameObjectPool<CombatScoreRankUpdateEvent>.Claim();
		combatScoreRankUpdateEvent.mEntityID = entityID;
		combatScoreRankUpdateEvent.mValue = value;
		combatScoreRankUpdateEvent.mLastValue = lastValue;
		return combatScoreRankUpdateEvent;
	}

	public override void OnEnterPool()
	{
		mEntityID = 0;
		mValue = 0;
		mLastValue = 0;
	}

	public override void Release()
	{
		FrameObjectPool<CombatScoreRankUpdateEvent>.Release(this);
	}
}
