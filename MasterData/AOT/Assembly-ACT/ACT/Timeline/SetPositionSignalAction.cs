using ACT.Battle;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class SetPositionSignalAction : ISignalAction
{
	public UniTask Invoke(INotificationReceiver receiver)
	{
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = MonoECS.instance.mainEntity.GetRootTransform().position,
			faceLeft = false,
			forceToFloor = true,
			revive = false
		};
		TeleportUtility.TeleportWithNone(Singleton<GameManager>.instance.worldManager.ActiveChunkId, teleportParams).Forget();
		return UniTask.CompletedTask;
	}
}
