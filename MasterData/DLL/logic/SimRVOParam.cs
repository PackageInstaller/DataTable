using Pathfinding.RVO;

public struct SimRVOParam(Int3 pos)
{
	public Int3 mSpawnPos = pos;

	public Int mElevation = 100;

	public Int mRadius = 500;

	public Int mHeight = 200;

	public Int Center = 100;

	public VFactor mAgentTimeHorizon = new VFactor(2L, 1L);

	public VFactor mObstacleTimeHorizon = new VFactor(2L, 1L);

	public bool mLocked = false;

	public bool mlockWhenNotMoving = true;

	public int mMaxNeighbours = 10;

	public RVOLayer mLayer = RVOLayer.DefaultAgent;

	public RVOLayer mColliderWith = RVOLayer.DefaultObstacle;

	public VFactor mPriority = VFactor.half;
}
