using System;
using UnityEngine;

namespace EasyCharacterMovement;

public class SlopeLimitBehavior : MonoBehaviour
{
	[Tooltip("The desired behavior.")]
	[SerializeField]
	private SlopeBehaviour _slopeBehaviour;

	[SerializeField]
	private float _slopeLimit;

	[SerializeField]
	[HideInInspector]
	private float _slopeLimitCos;

	public SlopeBehaviour walkableSlopeBehaviour
	{
		get
		{
			return _slopeBehaviour;
		}
		set
		{
			_slopeBehaviour = value;
		}
	}

	public float slopeLimit
	{
		get
		{
			return _slopeLimit;
		}
		set
		{
			_slopeLimit = Mathf.Clamp(value, 0f, 89f);
			_slopeLimitCos = Mathf.Cos(_slopeLimit * (MathF.PI / 180f));
		}
	}

	public float slopeLimitCos
	{
		get
		{
			return _slopeLimitCos;
		}
		set
		{
			_slopeLimitCos = Mathf.Clamp01(value);
			_slopeLimit = Mathf.Clamp(Mathf.Acos(_slopeLimitCos) * 57.29578f, 0f, 89f);
		}
	}

	private void OnValidate()
	{
		slopeLimit = _slopeLimit;
	}
}
