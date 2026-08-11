using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
public struct NormalPlatformControlCollider
{
	public float StartTime;

	public float OverTime;

	public List<GameObject> ActiveGameObjects;

	public List<GameObject> InActiveGameObjects;
}
