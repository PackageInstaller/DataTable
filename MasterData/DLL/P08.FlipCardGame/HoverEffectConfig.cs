using System;
using UnityEngine;

[Serializable]
public struct HoverEffectConfig
{
	public bool disableTween;

	public float scaleMultiple;

	public float enterScaleTime;

	public LeanTweenType tweenType;

	public float exitScaleTime;

	public float clickScaleMultiple;

	public float enterClickScaleTime;

	public LeanTweenType enterClickTweenType;

	public float crossFadeTime;

	public Animator animator;
}
