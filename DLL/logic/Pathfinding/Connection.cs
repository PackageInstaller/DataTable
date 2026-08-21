namespace Pathfinding;

public struct Connection(GraphNode node, uint cost, byte shapeEdge = byte.MaxValue)
{
	public GraphNode node = node;

	public uint cost = cost;

	public byte shapeEdge = shapeEdge;

	public override int GetHashCode()
	{
		return node.GetHashCode() ^ (int)cost;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		Connection connection = (Connection)obj;
		if (connection.node == node && connection.cost == cost)
		{
			return shapeEdge == connection.shapeEdge;
		}
		return false;
	}
}
