using Runtime.World.SceneChunks;
using UnityEngine;

namespace ACT;

internal class PreparePosResult : IPreparePosResult
{
	public static PreparePosResult InvalidResult = new PreparePosResult();

	public ISceneChunkControl ChunkControl { get; private set; }

	public bool Invalid { get; private set; }

	public bool Success { get; private set; }

	public Vector3 FixedPosition { get; private set; }

	public PreparePosResult(bool success, Vector3 fixedPosition, ISceneChunkControl control)
	{
		Invalid = false;
		Success = success;
		FixedPosition = fixedPosition;
		ChunkControl = control;
	}

	public PreparePosResult()
	{
		Invalid = true;
		Success = false;
		FixedPosition = Vector3.zero;
		ChunkControl = null;
	}
}
