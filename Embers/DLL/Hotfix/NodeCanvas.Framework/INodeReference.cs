using System;

namespace NodeCanvas.Framework;

public interface INodeReference
{
	Type type { get; }

	Node Get(Graph graph);

	void Set(Node target);
}
