using System;
using TrueSync;
using UnityEngine;

public class ActorScaleInfo : LogicComponent
{
	[HideInInspector]
	public Action onModelScaleChagned;

	[HideInInspector]
	public Action onColliderScalerChanged;

	protected FP _modelScale = 1f;

	protected FP _colliderScale = 1f;

	protected float _overrideEffectScale;

	protected float _overrideTagEffectScale;

	public FP originModelScale { get; set; }

	public FP modelScale
	{
		get
		{
			return _modelScale;
		}
		set
		{
			_modelScale = value;
			onModelScaleChagned?.Invoke();
		}
	}

	public FP originColliderScale { get; set; }

	public FP colliderScale
	{
		get
		{
			return _colliderScale;
		}
		set
		{
			_colliderScale = value;
			onColliderScalerChanged?.Invoke();
		}
	}

	public float overrideEffectScale
	{
		get
		{
			return _overrideEffectScale;
		}
		set
		{
			_overrideEffectScale = value;
		}
	}

	public float overrideTagEffectScale
	{
		get
		{
			return _overrideTagEffectScale;
		}
		set
		{
			_overrideTagEffectScale = value;
		}
	}
}
