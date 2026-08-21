public class SimResurrectEvent : NEventBase, IPostToPresentation, IPostToSimulation
{
	public ResurrectEventState state;

	public int entityID;

	public long coinNumber;

	public long coinConsume;

	public int resurrectTimes;

	public override void OnEnterPool()
	{
		entityID = 0;
		coinNumber = 0L;
		coinConsume = 0L;
		resurrectTimes = 0;
		state = ResurrectEventState.death;
	}

	public static SimResurrectEvent Claim(int entityID, long coinNumber, long coinConsume, int resurrectTimes, ResurrectEventState state)
	{
		SimResurrectEvent simResurrectEvent = FrameObjectPool<SimResurrectEvent>.Claim();
		simResurrectEvent.entityID = entityID;
		simResurrectEvent.coinNumber = coinNumber;
		simResurrectEvent.coinConsume = coinConsume;
		simResurrectEvent.resurrectTimes = resurrectTimes;
		simResurrectEvent.state = state;
		return simResurrectEvent;
	}

	public override void Release()
	{
		FrameObjectPool<SimResurrectEvent>.Release(this);
	}
}
