using System;
using UnityEngine;

namespace Com.ForbiddenByte.OSA.Core.Data.Gallery;

[Serializable]
public class GalleryEffectParams
{
	[Tooltip("The amount of the gallery effect itself, independent of the amounts of individual animation types. 0=disabled")]
	[SerializeField]
	[Range(0f, 1f)]
	private float _OverallAmount;

	[SerializeField]
	private GalleryScale _Scale = new GalleryScale();

	[SerializeField]
	private GalleryRotation _Rotation = new GalleryRotation();

	public float OverallAmount
	{
		get
		{
			return _OverallAmount;
		}
		set
		{
			_OverallAmount = value;
		}
	}

	public GalleryScale Scale
	{
		get
		{
			return _Scale;
		}
		set
		{
			_Scale = value;
		}
	}

	public GalleryRotation Rotation
	{
		get
		{
			return _Rotation;
		}
		set
		{
			_Rotation = value;
		}
	}
}
