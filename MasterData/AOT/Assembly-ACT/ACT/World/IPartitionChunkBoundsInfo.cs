using UnityEngine;

namespace ACT.World;

public interface IPartitionChunkBoundsInfo
{
	bool TryGetChunkBounds(int chunkId, out Bounds bounds);
}
