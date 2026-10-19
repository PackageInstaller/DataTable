using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public struct WeaponProperty
{
	[Tooltip("武器ID")]
	public int id;

	[Tooltip("武器模型的配置")]
	public WeaponDetails[] weaponDetails;
}
