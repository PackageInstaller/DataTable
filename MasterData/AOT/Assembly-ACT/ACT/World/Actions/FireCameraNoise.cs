using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Actions;

public class FireCameraNoise : InteractAction
{
	[Tooltip("震屏效果预制体")]
	public YooAssetReference noiseReferenceAssetID;

	[Tooltip("震屏效果类型")]
	public CameraNoiseType cameraNoiseType = CameraNoiseType.LevelTrigger;

	[Tooltip("震屏效果相对于播放点的偏移量，一般只有Y轴才有用")]
	public Vector3 velocity;

	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		Singleton<CameraNoiseManager>.instance.TriggerCameraNoise(cameraNoiseType, behave.GetModelTrans().position, noiseReferenceAssetID, velocity, 0f, 0f, changeVelocityXZ: false, overLay: true, unloadAfterPlaying: true);
		return UniTask.CompletedTask;
	}
}
