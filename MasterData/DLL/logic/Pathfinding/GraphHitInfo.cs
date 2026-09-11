namespace Pathfinding;

public struct GraphHitInfo
{
	public Int3 origin;

	public Int3 point;

	public GraphNode node;

	public Int3 tangentOrigin;

	public Int3 tangent;

	public float distance => (point - origin).magnitude;

	public GraphHitInfo(Int3 point)
	{
		tangentOrigin = Int3.zero;
		origin = Int3.zero;
		this.point = point;
		node = null;
		tangent = Int3.zero;
	}
}
