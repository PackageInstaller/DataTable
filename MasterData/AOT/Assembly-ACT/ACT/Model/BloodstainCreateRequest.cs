using UnityEngine;

namespace ACT.Model;

public readonly struct BloodstainCreateRequest(int chunkId, Vector3 position, Quaternion rotation)
{
	public readonly int ChunkId = chunkId;

	public readonly Vector3 Position = position;

	public readonly Quaternion Rotation = rotation;
}
