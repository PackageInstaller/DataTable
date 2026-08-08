public sealed class SourceSpaceEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public enum E_SourceSpaceState
	{
		None,
		Prepare,
		Enter,
		Update,
		Leavel,
		Exit
	}

	public E_SourceSpaceState mState;

	public int mKeepTime = -1;

	public int mRaceID = -1;

	public int mTargetEntityID = -1;

	public static SourceSpaceEvent Claim(E_SourceSpaceState state, int keepTime, int raceID, int targetEntityID)
	{
		SourceSpaceEvent sourceSpaceEvent = FrameObjectPool<SourceSpaceEvent>.Claim();
		sourceSpaceEvent.mState = state;
		sourceSpaceEvent.mKeepTime = keepTime;
		sourceSpaceEvent.mRaceID = raceID;
		sourceSpaceEvent.mTargetEntityID = targetEntityID;
		return sourceSpaceEvent;
	}

	public override void OnEnterPool()
	{
		mState = E_SourceSpaceState.None;
		mKeepTime = -1;
		mRaceID = -1;
		mTargetEntityID = -1;
	}

	public override void Release()
	{
		FrameObjectPool<SourceSpaceEvent>.Release(this);
	}
}
