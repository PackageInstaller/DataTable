using System.Collections.Generic;
using ACT.World;
using EasyCharacterMovement;
using Runtime.World.SceneChunks;
using UnityEngine;

namespace ACT;

public interface IWorld
{
	ISceneChunkControl ActiveChunk { get; }

	Vector3 GetSpawnPosition();

	RoadMaterial GetRoadMaterialByWorldPos(Vector3 pos);

	Dictionary<int, MaterialTrackTransferData> GetTransferRangeByEnemyType(int enemyType);
}
