using System;
using UnityEngine;

[ExecuteInEditMode]
public class FloatingAgent : MonoBehaviour
{
	public Vector2 xAmplitude;

	public float xAmplitudeVariation;

	public float xSpd;

	public Vector2 yAmplitude0;

	public float yAmplitudeVariation0;

	public float ySpd0;

	public Vector2 yAmplitude1;

	public float yAmplitudeVariation1;

	public float ySpd1;

	public Vector2 zAmplitude;

	public float zAmplitudeVariation;

	public float zSpd;

	public RotateType rotateType;

	public Vector3 rotateSpd;

	public Vector2 xRotateAmplitude;

	public float xRotateAmplitudeVariation;

	public Vector2 yRotateAmplitude;

	public float yRotateAmplitudeVariation;

	public Vector2 zRotateAmplitude;

	public float zRotateAmplitudeVariation;

	private Vector3 _originalPosition;

	private Vector3 _originalRotation;

	private void OnEnable()
	{
		_originalPosition = transform.position;
		_originalRotation = transform.rotation.eulerAngles;
	}

	private void Update()
	{
		transform.position = _originalPosition + new Vector3(AmpVariableSin(xAmplitude, xAmplitudeVariation, xSpd), AmpVariableSin(yAmplitude0, yAmplitudeVariation0, ySpd0) + AmpVariableSin(yAmplitude1, yAmplitudeVariation1, ySpd1), AmpVariableSin(zAmplitude, zAmplitudeVariation, zSpd));
		switch (rotateType)
		{
		case RotateType.Loop:
			transform.rotation = Quaternion.Euler(_originalRotation + Time.time * rotateSpd);
			break;
		case RotateType.PingPong:
			transform.rotation = Quaternion.Euler(_originalRotation + new Vector3(AmpVariableSin(xRotateAmplitude, xRotateAmplitudeVariation, rotateSpd.x), AmpVariableSin(yRotateAmplitude, yRotateAmplitudeVariation, rotateSpd.y), AmpVariableSin(zRotateAmplitude, zRotateAmplitudeVariation, rotateSpd.z)));
			break;
		default:
			throw new ArgumentOutOfRangeException();
		case RotateType.Non:
			break;
		}
	}

	private static float AmpVariableSin(Vector2 amplitudeRange, float variationSpd, float sinSpd)
	{
		return Mathf.Lerp(amplitudeRange.x, amplitudeRange.y, Mathf.Sin(Time.time * variationSpd) * 0.5f + 0.5f) * Mathf.Sin(Time.time * sinSpd);
	}
}
