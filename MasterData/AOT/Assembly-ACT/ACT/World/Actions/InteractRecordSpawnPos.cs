using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Game.Data;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Actions;

public class InteractRecordSpawnPos : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		CompStateObject? compStateObject = stateObjectBase.entity.GetCompStateObject();
		Vector3 spawnPos = compStateObject.StateWorldAssetData.GetSpawnPos();
		int stateWorldAssetUid = compStateObject.StateWorldAssetData.stateWorldAssetUid;
		int chunkIdBySGOID = Singleton<GameManager>.instance.worldManager.GetChunkIdBySGOID(stateWorldAssetUid);
		SceneSpawnInfo spawnInfo = new SceneSpawnInfo
		{
			Pos = spawnPos.ToPB(),
			InteractionObjUID = stateWorldAssetUid,
			ChunkID = chunkIdBySGOID
		};
		Singleton<RespawnManager>.instance.RecordSpawnPos(spawnInfo, "交互动作记录复活点");
		return UniTask.CompletedTask;
	}
}
