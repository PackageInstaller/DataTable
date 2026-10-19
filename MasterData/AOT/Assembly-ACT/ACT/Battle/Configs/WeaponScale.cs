using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public struct WeaponScale
{
	public CharacterWeightType type;

	public Vector3 scale;

	public YooAssetReference overrideWeaponWrapAssetID;
}
