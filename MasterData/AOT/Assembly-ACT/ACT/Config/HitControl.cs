using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public struct HitControl
{
	public float hitDuration;

	public AnimationCurve hitCurve;
}
