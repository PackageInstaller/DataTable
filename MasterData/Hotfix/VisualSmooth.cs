using System;
using TrueSync;
using UnityEngine;

public class VisualSmooth : LogicMonoComponent, ILogicComponentVisualUpdate, ILogicComponent
{
	[NonSerialized]
	public static float visualPositionSmoothFactor = 0.05f;

	[NonSerialized]
	public static float visualRotationSmoothFactor = 0.6f;

	private float _visualDampPosVelocityX;

	private float _visualDampPosVelocityY;

	private float _visualDampPosVelocityZ;

	private float _visualDampPosX;

	private float _visualDampPosY;

	private float _visualDampPosZ;

	private TrueSyncTransform _tsTransform;

	private Transform _transform;

	public float pitch;

	public float roll;

	public bool dontSyncRotate;

	public override void OnActive()
	{
		_transform = Entity.transform;
		_tsTransform = Entity.tsTransform;
	}

	public override void OnDeactive()
	{
	}

	public void SetDeterministicTransform(TSVector2 position, FP positionY, FP rotation)
	{
		_tsTransform.Position = position;
		_tsTransform.PositionY = positionY;
		_tsTransform.Rotation = rotation;
		SyncDeterministicTransform();
	}

	public void SyncDeterministicTransform()
	{
		Vector3 position = new Vector3((float)_tsTransform.Position.x, (float)_tsTransform.PositionY, (float)_tsTransform.Position.y);
		Quaternion rotation = Quaternion.Euler(0f, 0f - (float)_tsTransform.Rotation, 0f);
		_visualDampPosVelocityX = 0f;
		_visualDampPosVelocityY = 0f;
		_visualDampPosVelocityZ = 0f;
		_visualDampPosX = position.x;
		_visualDampPosY = position.y;
		_visualDampPosZ = position.z;
		_transform.position = position;
		if (!dontSyncRotate)
		{
			_transform.rotation = rotation;
		}
	}

	public void OnVisualUpdate()
	{
		if (!_tsTransform.transformSyncEnabled)
		{
			SmoothTranslate();
			if (!dontSyncRotate)
			{
				SmoothRotate();
			}
		}
	}

	private void SmoothTranslate()
	{
		TSVector2 position = _tsTransform.Position;
		Vector3 position2 = new Vector3((float)position.x, (float)_tsTransform.PositionY, (float)position.y);
		float deltaTime = Time.deltaTime;
		if (deltaTime > float.Epsilon)
		{
			Vector3 position3 = _transform.position;
			_visualDampPosX = Mathf.SmoothDamp(position3.x, position2.x, ref _visualDampPosVelocityX, visualPositionSmoothFactor, float.PositiveInfinity, deltaTime);
			_visualDampPosY = Mathf.SmoothDamp(position3.y, position2.y, ref _visualDampPosVelocityY, visualPositionSmoothFactor, float.PositiveInfinity, deltaTime);
			_visualDampPosZ = Mathf.SmoothDamp(position3.z, position2.z, ref _visualDampPosVelocityZ, visualPositionSmoothFactor, float.PositiveInfinity, deltaTime);
			_transform.position = new Vector3(_visualDampPosX, _visualDampPosY, _visualDampPosZ);
		}
		else
		{
			_transform.position = position2;
		}
	}

	private void SmoothRotate()
	{
		FP rotation = _tsTransform.Rotation;
		Quaternion b = Quaternion.Euler(0f, 0f - (float)rotation, 0f);
		if (!Mathf.Approximately(pitch, 0f))
		{
			b *= Quaternion.AngleAxis(pitch, new Vector3(1f, 0f, 0f));
		}
		if (!Mathf.Approximately(roll, 0f))
		{
			b *= Quaternion.AngleAxis(roll, new Vector3(0f, 0f, 1f));
		}
		_transform.rotation = Quaternion.Slerp(_transform.rotation, b, visualRotationSmoothFactor);
	}
}
