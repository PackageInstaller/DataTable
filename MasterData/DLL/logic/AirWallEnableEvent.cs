public class AirWallEnableEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int id;

	public Int3 pos;

	public Int3 forward;

	public Int3 playerPos;

	public bool enable;

	public AirWallEnableEvent(int id, Int3 pos, Int3 forward, Int3 playerPos, bool enable)
	{
		this.id = id;
		this.pos = pos;
		this.forward = forward;
		this.playerPos = playerPos;
		this.enable = enable;
	}

	public AirWallEnableEvent()
	{
	}

	public override void OnEnterPool()
	{
		id = 0;
		pos = Int3.zero;
		forward = Int3.zero;
		playerPos = Int3.zero;
		enable = false;
	}

	public static AirWallEnableEvent Claim()
	{
		return FrameObjectPool<AirWallEnableEvent>.Claim();
	}

	public override void Release()
	{
		FrameObjectPool<AirWallEnableEvent>.Release(this);
	}
}
