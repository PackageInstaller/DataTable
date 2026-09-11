public sealed class PlayerChangeEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mFromEntity;

	public int mToEntity;

	public bool mMorePlayerAgent;

	public override void OnEnterPool()
	{
		mFromEntity = 0;
		mToEntity = 0;
		mMorePlayerAgent = false;
	}

	public static PlayerChangeEvent Claim(int fromEntity, int toEntity, bool morePlayerAgent)
	{
		PlayerChangeEvent playerChangeEvent = FrameObjectPool<PlayerChangeEvent>.Claim();
		playerChangeEvent.mFromEntity = fromEntity;
		playerChangeEvent.mToEntity = toEntity;
		playerChangeEvent.mMorePlayerAgent = morePlayerAgent;
		return playerChangeEvent;
	}

	public override void Release()
	{
		FrameObjectPool<PlayerChangeEvent>.Release(this);
	}
}
