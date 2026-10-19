using System.Threading;
using ACT.Battle;
using ACT.Game.Data;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public class SetRebornPointAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		SetRebornPointActionParam setRebornPointActionParam = Param as SetRebornPointActionParam;
		Vector3 me = new Vector3(setRebornPointActionParam.positionX, setRebornPointActionParam.positionY, setRebornPointActionParam.positionZ);
		SceneSpawnInfo spawnInfo = new SceneSpawnInfo
		{
			Pos = me.ToPB(),
			ChunkID = setRebornPointActionParam.chunkId,
			InteractionObjUID = -1
		};
		Singleton<RespawnManager>.instance.RecordSpawnPos(spawnInfo, $"任务设置复活点，任务ID:{Flow.Id}");
		return UniTask.CompletedTask;
	}
}
