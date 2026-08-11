using UnityEngine;

namespace SceneStreamer;

public abstract class BvhObject
{
	public Vector3 position;

	public abstract AABBData GetAABB();
}
