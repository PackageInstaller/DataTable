using EasyCharacterMovement;
using UnityEngine;

namespace ACT.Battle;

public sealed class FollowPlatformMotionSource : MonoBehaviour, IMovingPlatformSource
{
	private Vector3 _previousPosition;

	private Quaternion _previousRotation;

	private Vector3 _currentPosition;

	private Quaternion _currentRotation;

	public bool IsReady { get; private set; }

	public void SyncPose(Vector3 position, Quaternion rotation)
	{
		if (!IsReady)
		{
			_previousPosition = position;
			_previousRotation = rotation;
			IsReady = true;
		}
		else
		{
			_previousPosition = _currentPosition;
			_previousRotation = _currentRotation;
		}
		_currentPosition = position;
		_currentRotation = rotation;
	}

	public bool TryGetDeltaPose(Vector3 characterPosition, out Vector3 deltaPosition, out Quaternion deltaRotation)
	{
		deltaPosition = Vector3.zero;
		deltaRotation = Quaternion.identity;
		if (!IsReady)
		{
			return false;
		}
		Vector3 vector = Quaternion.Inverse(_previousRotation) * (characterPosition - _previousPosition);
		Vector3 vector2 = _currentPosition + _currentRotation * vector;
		deltaPosition = vector2 - characterPosition;
		deltaRotation = _currentRotation * Quaternion.Inverse(_previousRotation);
		return true;
	}

	public void ResetPose()
	{
		IsReady = false;
		_previousPosition = Vector3.zero;
		_previousRotation = Quaternion.identity;
		_currentPosition = Vector3.zero;
		_currentRotation = Quaternion.identity;
	}
}
