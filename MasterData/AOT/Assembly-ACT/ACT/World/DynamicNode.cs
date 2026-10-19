using Bamboo.ECS;
using UnityEngine;

namespace ACT.World;

internal abstract class DynamicNode : IDynamicWorldPartitionNode
{
	public Entity entityReference { get; protected set; }

	public abstract int id { get; }

	public abstract bool active { get; set; }

	public abstract Vector3 position { get; }

	public abstract void OnRemoveActiveNode();

	public abstract void OnReleaseNode();
}
