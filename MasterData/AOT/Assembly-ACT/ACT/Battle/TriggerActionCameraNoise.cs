using System.Threading;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class TriggerActionCameraNoise : TriggerActionBase
{
	public YooAssetReference noiseAssetID;

	public Vector3 velocity;

	public Transform pos;

	public CameraNoiseType cameraNoiseType = CameraNoiseType.LevelTrigger;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		Singleton<CameraNoiseManager>.instance.TriggerCameraNoise(cameraNoiseType, pos.transform.position, noiseAssetID, velocity, 0f, 0f, changeVelocityXZ: false, overLay: true, unloadAfterPlaying: true);
		return UniTask.CompletedTask;
	}
}
