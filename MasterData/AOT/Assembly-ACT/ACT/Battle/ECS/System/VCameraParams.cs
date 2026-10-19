using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.ECS.System;

public struct VCameraParams
{
	public YooAssetReference patternAssetID;

	public CameraConfig config;

	public Entity caster;

	public bool canUsePos;

	public Vector3 pos;
}
