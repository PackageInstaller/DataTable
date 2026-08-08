using UnityEngine;

namespace Qworld.Runtime.SceneDither;

public abstract class MortonMono : MonoBehaviour, IMortonTreeObject
{
	public uint MortonCode;

	public MortonTreeLeafNode nodes;

	public Bounds Bounds => GetBounds();

	public IMortonTreeObject preEntity { get; set; }

	public IMortonTreeObject nextEntity { get; set; }

	public abstract Bounds GetBounds();

	public MortonTreeLeafNode getNodes()
	{
		return nodes;
	}

	public void SetNodeLeaf(uint morton, MortonTreeLeafNode node)
	{
		nodes = node;
	}

	public void SetMortonCode(uint morton)
	{
		MortonCode = morton;
	}

	public abstract uint GetComponentVersion();

	public void clearNodes()
	{
		nodes = null;
	}
}
