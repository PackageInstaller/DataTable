using System;
using UnityEngine;

namespace Com.ForbiddenByte.OSA.Core.Data.Gallery;

[Serializable]
public abstract class GalleryAnimation
{
	[Serializable]
	public class Vector3Space
	{
		[SerializeField]
		[Tooltip("Value for the furthest items from pivot, per component. In other words, the 'lowest' value")]
		private Vector3 _From = Vector3.zero;

		[SerializeField]
		[Tooltip("Value for the closest items to pivot, per component. In other words, the 'biggest' value")]
		private Vector3 _To = Vector3.zero;

		public Vector3 From
		{
			get
			{
				return _From;
			}
			set
			{
				_From = value;
			}
		}

		public Vector3 To
		{
			get
			{
				return _To;
			}
			set
			{
				_To = value;
			}
		}

		public Vector3Space()
		{
		}

		public Vector3Space(Vector3 from, Vector3 to)
		{
			_From = from;
			_To = to;
		}

		public Vector3 Transform(float amount01)
		{
			return Vector3.Lerp(_From, _To, amount01);
		}
	}

	public const float MAX_EFFECT_EXPONENT = 50f;

	[Range(0f, 1f)]
	[SerializeField]
	[Tooltip("Applies 'biggest' value for the item in the middle and gradually 'lowers' the value of the side items. \n0=no effect, 1=the most sideways items will have the 'lowest' value. \nViewportPivot can be used to set the weight in other place than the middle.")]
	private float _Amount;

	[Range(-1f, 2f)]
	[SerializeField]
	[Tooltip("0=start; 1=end; -1=point situated at <viewportSize> units before start; 2=point situated at <viewportSize> units after end")]
	private float _ViewportPivot = 0.5f;

	[Range(1f, 50f)]
	[Tooltip("1=linear. The bigger the exponent, the faster the value is lowered for the items that are far from pivot (see ViewportPivot)")]
	[SerializeField]
	private float _Exponent = 1f;

	public float Amount
	{
		get
		{
			return _Amount;
		}
		set
		{
			_Amount = value;
		}
	}

	public float ViewportPivot
	{
		get
		{
			return _ViewportPivot;
		}
		set
		{
			_ViewportPivot = value;
		}
	}

	public float Exponent
	{
		get
		{
			return _Exponent;
		}
		set
		{
			_Exponent = value;
		}
	}

	public abstract Vector3Space TransformSpace { get; set; }
}
