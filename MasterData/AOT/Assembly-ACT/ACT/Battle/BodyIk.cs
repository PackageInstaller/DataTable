using System;
using RootMotion.FinalIK;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public struct BodyIk
{
	public FullBodyBipedEffector ik;

	public AnimationCurve damp;

	public float ikStrength;
}
