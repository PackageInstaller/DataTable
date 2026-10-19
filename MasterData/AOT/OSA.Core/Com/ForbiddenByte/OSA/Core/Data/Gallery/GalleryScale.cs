using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace Com.ForbiddenByte.OSA.Core.Data.Gallery;

[Serializable]
public class GalleryScale : GalleryAnimation
{
	[Tooltip("No item will have its scale smaller than this")]
	[Range(0f, 1f)]
	[SerializeField]
	[FormerlySerializedAs("_MinScale")]
	private float _MinValue;

	[FormerlySerializedAs("_ScaleSpace")]
	[SerializeField]
	[Tooltip("From which to which value to interpolate the scale, per component")]
	private Vector3Space _TransformSpace = new Vector3Space(Vector3.zero, Vector3.one);

	public float MinValue
	{
		get
		{
			return _MinValue;
		}
		set
		{
			_MinValue = value;
		}
	}

	public override Vector3Space TransformSpace
	{
		get
		{
			return _TransformSpace;
		}
		set
		{
			_TransformSpace = value;
		}
	}

	public GalleryScale()
	{
		Amount = 1f;
	}
}
