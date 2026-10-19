using UnityEngine;

namespace ACT.World;

public abstract class RuntimeStaticNode
{
	public LoadState loadState;

	public LoadPolicy loadPolicy;

	public Bounds bounds;

	public virtual LoadType loadType => LoadType.distance;

	public abstract void OnLoad();

	public abstract void OnRelase();
}
