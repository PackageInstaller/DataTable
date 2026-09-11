using System;

namespace Pathfinding;

public interface INavmesh
{
	void GetNodes(Action<GraphNode> del);
}
