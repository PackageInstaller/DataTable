using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigTrajectoryObject : LuminSerializedScriptableObject
{
	public ConfigTrajectory configTrajectory;

	[SerializeField]
	private YooAssetReference _drippingEffectAsset;

	[SerializeField]
	private Vector3 _attackBoundsOffset;

	public YooAssetReference DrippingEffectAsset => _drippingEffectAsset;

	public Vector3 AttackBoundsOffset => _attackBoundsOffset;
}
