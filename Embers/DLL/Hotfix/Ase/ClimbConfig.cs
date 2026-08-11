using System;
using UnityEngine;

namespace Ase;

[Serializable]
public class ClimbConfig
{
	public float ClipTime;

	public AnimationCurve climbCurveX;

	public AnimationCurve climbCurveY;

	public AnimationCurve climbCurveZ;
}
