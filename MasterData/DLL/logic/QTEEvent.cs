public sealed class QTEEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int ID;

	public int entityID;

	public int curTime;

	public int maxTime;

	public QTEStatusType mStatus;

	public static QTEEvent Claim(int ID, int entityID, int curTime, int maxTime, QTEStatusType mStatus)
	{
		QTEEvent qTEEvent = FrameObjectPool<QTEEvent>.Claim();
		qTEEvent.ID = ID;
		qTEEvent.entityID = entityID;
		qTEEvent.curTime = curTime;
		qTEEvent.maxTime = maxTime;
		qTEEvent.mStatus = mStatus;
		return qTEEvent;
	}

	public override void OnEnterPool()
	{
		ID = 0;
		entityID = 0;
		curTime = 0;
		maxTime = 0;
		mStatus = QTEStatusType.Running;
	}

	public override void Release()
	{
		FrameObjectPool<QTEEvent>.Release(this);
	}
}
