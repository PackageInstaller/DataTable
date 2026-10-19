using System.Collections.Generic;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行镜头震动", "Action", new string[] { "camera", "noise", "fov", "volume" })]
public class ActionCameraNoise : ConfigAction
{
	public YooAssetReference noiseReferenceAssetID;

	public CameraNoiseType cameraNoiseType;

	public Vector3 velocity;

	public Vector3 offset;

	public float force;

	public bool dontNeedChangeVelocityXZ;

	public float duration;

	public bool canOverlay;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		bool changeVelocityXZ = !dontNeedChangeVelocityXZ && memory.target.entity.IsFaceLeft();
		Transform rootTransform = memory.target.entity.GetRootTransform();
		if ((object)rootTransform != null)
		{
			Singleton<CameraNoiseManager>.instance.TriggerCameraNoise(cameraNoiseType, rootTransform.position + VectorUtility.HorizontalDirection(memory.target.entity.IsFaceLeft(), offset), noiseReferenceAssetID, velocity, duration, force, changeVelocityXZ, overLay: true, unloadAfterPlaying: true);
		}
	}

	public override void Precache(List<YooAssetReference> addlist)
	{
		addlist.Add(noiseReferenceAssetID);
	}
}
