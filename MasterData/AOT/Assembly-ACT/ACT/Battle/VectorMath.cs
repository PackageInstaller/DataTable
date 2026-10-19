using UnityEngine;

namespace ACT.Battle;

public static class VectorMath
{
	public static float GetAngle(Vector3 _vector1, Vector3 _vector2, Vector3 _planeNormal)
	{
		float num = Vector3.Angle(_vector1, _vector2);
		float num2 = Mathf.Sign(Vector3.Dot(_planeNormal, Vector3.Cross(_vector1, _vector2)));
		return num * num2;
	}

	public static float GetDotProduct(Vector3 _vector, Vector3 _direction)
	{
		if (_direction.sqrMagnitude != 1f)
		{
			_direction.Normalize();
		}
		return Vector3.Dot(_vector, _direction);
	}

	public static Vector3 RemoveDotVector(Vector3 _vector, Vector3 _direction)
	{
		if (_direction.sqrMagnitude != 1f)
		{
			_direction.Normalize();
		}
		float num = Vector3.Dot(_vector, _direction);
		_vector -= _direction * num;
		return _vector;
	}

	public static Vector3 ExtractDotVector(Vector3 _vector, Vector3 _direction)
	{
		if (_direction.sqrMagnitude != 1f)
		{
			_direction.Normalize();
		}
		float num = Vector3.Dot(_vector, _direction);
		return _direction * num;
	}

	public static Vector3 RotateVectorOntoPlane(Vector3 _vector, Vector3 _planeNormal, Vector3 _upDirection)
	{
		_vector = Quaternion.FromToRotation(_upDirection, _planeNormal) * _vector;
		return _vector;
	}

	public static Vector3 ProjectPointOntoLine(Vector3 _lineStartPosition, Vector3 _lineDirection, Vector3 _point)
	{
		float num = Vector3.Dot(_point - _lineStartPosition, _lineDirection);
		return _lineStartPosition + _lineDirection * num;
	}

	public static Vector3 IncrementVectorTowardTargetVector(Vector3 _currentVector, float _speed, float _deltaTime, Vector3 _targetVector)
	{
		return Vector3.MoveTowards(_currentVector, _targetVector, _speed * _deltaTime);
	}
}
