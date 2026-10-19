using PathFinding2D.Runtime.Models;

namespace PathFinding2D.Runtime.Common;

public class KdTreeNode
{
	public Waypoint point;

	public KdTreeNode left;

	public KdTreeNode right;

	public KdTreeNode(Waypoint point)
	{
		this.point = point;
	}
}
