using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace Com.ForbiddenByte.OSA.Core.Data.Gallery;

[Serializable]
public class GalleryRotation : GalleryAnimation
{
	[FormerlySerializedAs("_ScaleSpace")]
	[Tooltip("From which to which value to interpolate the rotation, per component")]
	[SerializeField]
	private Vector3Space _TransformSpace = new Vector3Space(Vector3.zero, Vector3.zero);

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
}
