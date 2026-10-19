using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class DefaultWeaponScaleInfo
{
	public CharacterWeightType type;

	public Vector3 scale = Vector3.one;
}
