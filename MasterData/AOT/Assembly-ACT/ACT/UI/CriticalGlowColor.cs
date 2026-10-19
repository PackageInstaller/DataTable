using System;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public struct CriticalGlowColor
{
	public ParticleSystem.MinMaxGradient ring;

	public ParticleSystem.MinMaxGradient particle;

	public ParticleSystem.MinMaxGradient glow;

	public ParticleSystem.MinMaxGradient ray;

	public ParticleSystem.MinMaxGradient screen;

	public static CriticalGlowColor Null;
}
