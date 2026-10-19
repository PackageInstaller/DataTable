using Runtime.World.SceneChunks;
using UnityEngine;

namespace ACT;

public interface IPreparePosResult
{
	bool Success { get; }

	Vector3 FixedPosition { get; }

	bool Invalid { get; }

	ISceneChunkControl ChunkControl { get; }
}
