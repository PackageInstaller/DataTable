using System.Collections.Generic;

namespace Pathfinding;

public interface IRaycastableGraph
{
	bool Linecast(Int3 start, Int3 end);

	bool Linecast(Int3 start, Int3 end, GraphNode hint);

	bool Linecast(Int3 start, Int3 end, GraphNode hint, out GraphHitInfo hit);

	bool Linecast(Int3 start, Int3 end, GraphNode hint, out GraphHitInfo hit, List<GraphNode> trace);
}
