using ACT.Battle;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class PlayerSetPosition : ISignalAction
{
	public Vector3 Position;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsValid)
		{
			mainEntity.Teleport(Position);
			mainEntity.GetCompPhysics().SetConstZ(Position.z);
			MonoECS.instance.SyncGameInfos();
		}
		return UniTask.CompletedTask;
	}
}
