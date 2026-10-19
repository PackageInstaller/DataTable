using System;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public struct WeakColor
{
	public Color glow;

	public Color arrowColor;

	public ParticleSystem.MinMaxGradient glow1;

	public ParticleSystem.MinMaxGradient glow2;

	public ParticleSystem.MinMaxGradient glow3;

	public static WeakColor Null;
}
