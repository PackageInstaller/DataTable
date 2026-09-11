namespace Pathfinding;

public struct NNInfoInternal
{
	public GraphNode node;

	public GraphNode constrainedNode;

	public Int3 clampedPosition;

	public Int3 constClampedPosition;

	public NNInfoInternal(GraphNode node)
	{
		this.node = node;
		constrainedNode = null;
		clampedPosition = Int3.zero;
		constClampedPosition = Int3.zero;
		UpdateInfo();
	}

	public void UpdateInfo()
	{
		clampedPosition = ((node != null) ? node.position : Int3.zero);
		constClampedPosition = ((constrainedNode != null) ? constrainedNode.position : Int3.zero);
	}
}
