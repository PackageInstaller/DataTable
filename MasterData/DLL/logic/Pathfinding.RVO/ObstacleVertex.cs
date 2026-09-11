namespace Pathfinding.RVO;

public class ObstacleVertex
{
	public bool ignore;

	public Int3 position;

	public Int2 dir;

	public Int height;

	public RVOLayer layer = RVOLayer.DefaultObstacle;

	public ObstacleVertex next;

	public ObstacleVertex prev;
}
