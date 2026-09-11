using UnityEngine;

namespace Qworld.Runtime.SceneDither;

public interface IMortonTreeObject
{
	Bounds Bounds { get; }

	IMortonTreeObject preEntity { get; set; }

	IMortonTreeObject nextEntity { get; set; }

	MortonTreeLeafNode getNodes();

	void clearNodes();

	void SetNodeLeaf(uint morton, MortonTreeLeafNode node);

	void SetMortonCode(uint morton);

	uint GetComponentVersion();
}
