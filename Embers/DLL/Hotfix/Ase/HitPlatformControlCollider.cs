using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
public struct HitPlatformControlCollider
{
	public SpeedValueCompare SpeedOptional;

	public float Speed;

	public List<GameObject> ActiveGameObjects;

	public List<GameObject> InActiveGameObjects;
}
