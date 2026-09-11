using Entitas;
using Pathfinding.RVO;
using Pathfinding.RVO.Sampled;

[Sim]
public class EntityRVO : IComponent
{
	public Agent agent;

	public Agent bugPrevAvoided;

	public int bugDirection;

	public int bugTimer;

	public VFactor mAgentTimeHorizon = new VFactor(2L, 1L);

	public VFactor mObstacleTimeHorizon = new VFactor(2L, 1L);

	public bool mlockWhenNotMoving = true;

	public int mMaxNeighbours = 10;

	public RVOLayer mLayer = RVOLayer.DefaultAgent;

	public RVOLayer mColliderWith = RVOLayer.DefaultObstacle;

	public VFactor mPriority = VFactor.half;

	public void Reset(IEntity entity)
	{
		agent = null;
		bugPrevAvoided = null;
		bugDirection = 0;
	}
}
