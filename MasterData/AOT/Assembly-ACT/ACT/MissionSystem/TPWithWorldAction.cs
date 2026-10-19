using System.Threading;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.MissionSystem;

public class TPWithWorldAction : MissionAction
{
	protected override bool IgnoreInMissionWorld => true;

	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		TPWithWorldActionParam tPWithWorldActionParam = Param as TPWithWorldActionParam;
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = new Vector3(tPWithWorldActionParam.positionX, tPWithWorldActionParam.positionY, tPWithWorldActionParam.positionZ)
		};
		await TeleportUtility.SceneChangeTpWithLoader(tPWithWorldActionParam.chunkId, tPWithWorldActionParam.worldId, teleportParams);
	}
}
