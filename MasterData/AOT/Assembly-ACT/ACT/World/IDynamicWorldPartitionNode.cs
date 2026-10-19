using UnityEngine;

namespace ACT.World;

internal interface IDynamicWorldPartitionNode
{
	int id { get; }

	bool active { get; set; }

	Vector3 position { get; }

	void OnRemoveActiveNode();

	void OnReleaseNode();
}
