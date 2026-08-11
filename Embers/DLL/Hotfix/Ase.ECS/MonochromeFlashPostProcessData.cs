using UnityEngine;

namespace Ase.ECS;

public struct MonochromeFlashPostProcessData
{
	public float Delay;

	public float Lifetime;

	public bool UseCustomCurve;

	public AnimationCurve Curve;

	public bool UseCustomColor;

	public Color Color;
}
