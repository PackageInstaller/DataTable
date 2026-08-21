public sealed class CombatScoreValueUpdateEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mEntityID;

	public int mValue;

	public int mLastValue;

	public int mDelta;

	public CombatScoreValueUpdateEvent(int entityID, int value, int lastValue, int delta)
	{
		mEntityID = entityID;
		mValue = value;
		mLastValue = lastValue;
		mDelta = delta;
	}

	public CombatScoreValueUpdateEvent()
	{
	}

	public static CombatScoreValueUpdateEvent Claim(int entityID, int value, int lastValue, int delta)
	{
		CombatScoreValueUpdateEvent combatScoreValueUpdateEvent = FrameObjectPool<CombatScoreValueUpdateEvent>.Claim();
		combatScoreValueUpdateEvent.mEntityID = entityID;
		combatScoreValueUpdateEvent.mValue = value;
		combatScoreValueUpdateEvent.mLastValue = lastValue;
		combatScoreValueUpdateEvent.mDelta = delta;
		return combatScoreValueUpdateEvent;
	}

	public override void OnEnterPool()
	{
		mEntityID = 0;
		mValue = 0;
		mLastValue = 0;
		mDelta = 0;
	}

	public override void Release()
	{
		FrameObjectPool<CombatScoreValueUpdateEvent>.Release(this);
	}
}
