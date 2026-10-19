using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public sealed class HitHealDeviceSection
{
	[SerializeField]
	private int _lightPointCount;

	public int LightPointCount => _lightPointCount;
}
