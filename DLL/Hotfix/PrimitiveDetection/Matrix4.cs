using UnityEngine;

namespace PrimitiveDetection;

public struct Matrix4
{
	public Vector3[] _allAxis;

	public static Matrix4 IdentityOffset(Vector3 offset)
	{
		Matrix4 result = NewIdentity();
		result._allAxis[3].x += offset.x;
		result._allAxis[3].y += offset.y;
		result._allAxis[3].z += offset.z;
		return result;
	}

	public Matrix4(float m0, float m1, float m2, float m3, float m4, float m5, float m6, float m7, float m8, float m9, float m10, float m11)
	{
		_allAxis = new Vector3[4]
		{
			new Vector3(m0, m4, m8),
			new Vector3(m1, m5, m9),
			new Vector3(m2, m6, m10),
			new Vector3(m3, m7, m11)
		};
	}

	private Matrix4(int m0, int m1, int m2, int m3, int m4, int m5, int m6, int m7, int m8, int m9, int m10, int m11)
	{
		_allAxis = new Vector3[4]
		{
			new Vector3(m0, m4, m8),
			new Vector3(m1, m5, m9),
			new Vector3(m2, m6, m10),
			new Vector3(m3, m7, m11)
		};
	}

	public static Matrix4 NewIdentity()
	{
		return new Matrix4
		{
			_allAxis = new Vector3[4]
			{
				new Vector3(1f, 0f, 0f),
				new Vector3(0f, 1f, 0f),
				new Vector3(0f, 0f, 1f),
				new Vector3(0f, 0f, 0f)
			}
		};
	}

	public static Matrix4 operator *(Matrix4 m1, Matrix4 m2)
	{
		Matrix4 result = default(Matrix4);
		result._allAxis[0].x = m2._allAxis[0].x * m1._allAxis[0].x + m2._allAxis[0].y * m1._allAxis[1].x + m2._allAxis[0].z * m1._allAxis[2].x;
		result._allAxis[0].y = m2._allAxis[0].x * m1._allAxis[0].y + m2._allAxis[0].y * m1._allAxis[1].y + m2._allAxis[0].z * m1._allAxis[2].y;
		result._allAxis[0].z = m2._allAxis[0].x * m1._allAxis[0].z + m2._allAxis[0].y * m1._allAxis[1].z + m2._allAxis[0].z * m1._allAxis[2].z;
		result._allAxis[1].x = m2._allAxis[1].x * m1._allAxis[0].x + m2._allAxis[1].y * m1._allAxis[1].x + m2._allAxis[1].z * m1._allAxis[2].x;
		result._allAxis[1].y = m2._allAxis[1].x * m1._allAxis[0].y + m2._allAxis[1].y * m1._allAxis[1].y + m2._allAxis[1].z * m1._allAxis[2].y;
		result._allAxis[1].z = m2._allAxis[1].x * m1._allAxis[0].z + m2._allAxis[1].y * m1._allAxis[1].z + m2._allAxis[1].z * m1._allAxis[2].z;
		result._allAxis[2].x = m2._allAxis[2].x * m1._allAxis[0].x + m2._allAxis[2].y * m1._allAxis[1].x + m2._allAxis[2].z * m1._allAxis[2].x;
		result._allAxis[2].y = m2._allAxis[2].x * m1._allAxis[0].y + m2._allAxis[2].y * m1._allAxis[1].y + m2._allAxis[2].z * m1._allAxis[2].y;
		result._allAxis[2].z = m2._allAxis[2].x * m1._allAxis[0].z + m2._allAxis[2].y * m1._allAxis[1].z + m2._allAxis[2].z * m1._allAxis[2].z;
		result._allAxis[3].x = m2._allAxis[3].x * m1._allAxis[0].x + m2._allAxis[3].y * m1._allAxis[1].x + m2._allAxis[3].z * m1._allAxis[2].x + m1._allAxis[3].x;
		result._allAxis[3].y = m2._allAxis[3].x * m1._allAxis[0].y + m2._allAxis[3].y * m1._allAxis[1].y + m2._allAxis[3].z * m1._allAxis[2].y + m1._allAxis[3].y;
		result._allAxis[3].z = m2._allAxis[3].x * m1._allAxis[0].z + m2._allAxis[3].y * m1._allAxis[1].z + m2._allAxis[3].z * m1._allAxis[2].z + m1._allAxis[3].z;
		return result;
	}

	public static Vector3 operator *(Matrix4 m, Vector3 vector)
	{
		return new Vector3(vector.x * m._allAxis[0].x + vector.y * m._allAxis[1].x + vector.z * m._allAxis[2].x + m._allAxis[3].x, vector.x * m._allAxis[0].y + vector.y * m._allAxis[1].y + vector.z * m._allAxis[2].y + m._allAxis[3].y, vector.x * m._allAxis[0].z + vector.y * m._allAxis[1].z + vector.z * m._allAxis[2].z + m._allAxis[3].z);
	}

	public override string ToString()
	{
		return _allAxis[0].x + "," + _allAxis[1].x + "," + _allAxis[2].x + "," + _allAxis[3].x + "\n" + _allAxis[0].y + "," + _allAxis[1].y + "," + _allAxis[2].y + "," + _allAxis[3].y + "\n" + _allAxis[0].z + "," + _allAxis[1].z + "," + _allAxis[2].z + "," + _allAxis[3].z;
	}

	public void SetDiagonal(float a, float b, float c)
	{
		_allAxis[0].x = a;
		_allAxis[1].y = b;
		_allAxis[2].z = c;
	}

	public Vector3 Transform(Vector3 vector)
	{
		return this * vector;
	}

	public float GetDeterminant()
	{
		return (0f - _allAxis[0].z) * (_allAxis[1].y * _allAxis[2].x) + _allAxis[0].y * (_allAxis[1].z * _allAxis[2].x) + _allAxis[0].z * (_allAxis[1].x * _allAxis[2].y) - _allAxis[0].x * (_allAxis[1].z * _allAxis[2].y) - _allAxis[0].y * (_allAxis[1].x * _allAxis[2].z) + _allAxis[0].x * (_allAxis[1].y * _allAxis[2].z);
	}

	public void SetInverse(Matrix4 m)
	{
		float determinant = m.GetDeterminant();
		if (!((double)Mathf.Abs(determinant) <= 1E-06))
		{
			determinant = 1f / determinant;
			_allAxis[0].x = (0f - (_allAxis[1].z * _allAxis[2].y + _allAxis[1].y * _allAxis[2].z)) * determinant;
			_allAxis[0].y = (_allAxis[0].z * _allAxis[2].y - _allAxis[0].y * _allAxis[2].z) * determinant;
			_allAxis[0].z = (0f - (_allAxis[0].z * _allAxis[1].y + _allAxis[0].y * _allAxis[1].z)) * determinant;
			_allAxis[1].x = (_allAxis[1].z * _allAxis[2].x - _allAxis[1].x * _allAxis[2].z) * determinant;
			_allAxis[1].y = (0f - (_allAxis[0].z * _allAxis[2].x + _allAxis[0].x * _allAxis[2].z)) * determinant;
			_allAxis[1].z = (_allAxis[0].z * _allAxis[1].x - _allAxis[0].x * _allAxis[1].z) * determinant;
			_allAxis[2].x = (0f - (_allAxis[1].y * _allAxis[2].x + _allAxis[1].x * _allAxis[2].y)) * determinant;
			_allAxis[2].y = (_allAxis[0].y * _allAxis[2].x - _allAxis[0].x * _allAxis[2].y) * determinant;
			_allAxis[2].z = (0f - (_allAxis[0].y * _allAxis[1].x + _allAxis[0].x * _allAxis[1].y)) * determinant;
			_allAxis[3].x = _allAxis[1].z * (_allAxis[2].y * _allAxis[3].x) - _allAxis[1].y * (_allAxis[2].z * _allAxis[3].x) - _allAxis[1].z * (_allAxis[2].x * _allAxis[3].y) + _allAxis[1].x * (_allAxis[2].z * _allAxis[3].y) + _allAxis[1].y * (_allAxis[2].x * _allAxis[3].z) - _allAxis[1].x * (_allAxis[2].y * _allAxis[3].z) * determinant;
			_allAxis[3].y = 0f - _allAxis[0].z * (_allAxis[2].y * _allAxis[3].x) + _allAxis[0].y * (_allAxis[2].z * _allAxis[3].x) + _allAxis[0].z * (_allAxis[2].x * _allAxis[3].y) - _allAxis[0].x * (_allAxis[2].z * _allAxis[3].y) - _allAxis[0].y * (_allAxis[2].x * _allAxis[3].z) + _allAxis[0].x * (_allAxis[2].y * _allAxis[3].z) * determinant;
			_allAxis[3].z = _allAxis[0].z * (_allAxis[1].y * _allAxis[3].x) - _allAxis[0].y * (_allAxis[1].z * _allAxis[3].x) - _allAxis[0].z * (_allAxis[1].x * _allAxis[3].y) + _allAxis[0].x * (_allAxis[1].z * _allAxis[3].y) + _allAxis[0].y * (_allAxis[1].x * _allAxis[3].z) - _allAxis[0].x * (_allAxis[1].y * _allAxis[3].z) * determinant;
		}
	}

	public Matrix4 Inverse()
	{
		Matrix4 result = NewIdentity();
		result.SetInverse(this);
		return result;
	}

	public void Invert()
	{
		SetInverse(this);
	}

	public Vector3 TransformDirection(Vector3 vector)
	{
		return new Vector3(vector.x * _allAxis[0].x + vector.y * _allAxis[1].x + vector.z * _allAxis[2].x, vector.x * _allAxis[0].y + vector.y * _allAxis[1].y + vector.z * _allAxis[2].y, vector.x * _allAxis[0].z + vector.y * _allAxis[1].z + vector.z * _allAxis[2].z);
	}

	public Vector3 TransformInverseDirection(Vector3 vector)
	{
		return new Vector3(vector.x * _allAxis[0].x + vector.y * _allAxis[0].y + vector.z * _allAxis[0].z, vector.x * _allAxis[1].x + vector.y * _allAxis[1].y + vector.z * _allAxis[1].z, vector.x * _allAxis[2].x + vector.y * _allAxis[2].y + vector.z * _allAxis[2].z);
	}

	public Vector3 TransformInverse(Vector3 vector)
	{
		Vector3 vector2 = vector;
		vector2.x -= _allAxis[3].x;
		vector2.y -= _allAxis[3].y;
		vector2.z -= _allAxis[3].z;
		return new Vector3(vector2.x * _allAxis[0].x + vector2.y * _allAxis[0].y + vector2.z * _allAxis[0].z, vector2.x * _allAxis[1].x + vector2.y * _allAxis[1].y + vector2.z * _allAxis[1].z, vector2.x * _allAxis[2].x + vector2.y * _allAxis[2].y + vector2.z * _allAxis[2].z);
	}

	public Vector3 GetAxisVector(int i)
	{
		return _allAxis[i];
	}

	public void SetOrientationAndPos(Quaternion q, Vector3 pos)
	{
		float num = 1f;
		float num2 = 2f;
		_allAxis[0].x = num - (num2 * (q.y * q.y) + num2 * (q.z * q.z));
		_allAxis[1].x = num2 * (q.x * q.y) - num2 * (q.z * q.w);
		_allAxis[2].x = num2 * (q.x * q.z) + num2 * (q.y * q.w);
		_allAxis[3].x = pos.x;
		_allAxis[0].y = num2 * (q.x * q.y) + num2 * (q.z * q.w);
		_allAxis[1].y = num - (num2 * (q.x * q.x) + num2 * (q.z * q.z));
		_allAxis[2].y = num2 * (q.y * q.z) - num2 * (q.x * q.w);
		_allAxis[3].y = pos.y;
		_allAxis[0].z = num2 * (q.x * q.z) - num2 * (q.y * q.w);
		_allAxis[1].z = num2 * (q.y * q.z) + num2 * (q.x * q.w);
		_allAxis[2].z = num - (num2 * (q.x * q.x) + num2 * (q.y * q.y));
		_allAxis[3].z = pos.z;
	}

	public void SetOrientationScaleAndPos(Quaternion q, Vector3 pos, Vector3 scale)
	{
		float num = 1f;
		float num2 = 2f;
		_allAxis[0].x = num - (num2 * (q.y * q.y) + num2 * (q.z * q.z));
		_allAxis[0].x *= scale.x;
		_allAxis[1].x = num2 * (q.x * q.y) - num2 * (q.z * q.w);
		_allAxis[1].x *= scale.x;
		_allAxis[2].x = num2 * (q.x * q.z) + num2 * (q.y * q.w);
		_allAxis[2].x *= scale.x;
		_allAxis[3].x = pos.x;
		_allAxis[0].y = num2 * (q.x * q.y) + num2 * (q.z * q.w);
		_allAxis[0].y *= scale.y;
		_allAxis[1].y = num - (num2 * (q.x * q.x) + num2 * (q.z * q.z));
		_allAxis[1].y *= scale.y;
		_allAxis[2].y = num2 * (q.y * q.z) - num2 * (q.x * q.w);
		_allAxis[2].y *= scale.y;
		_allAxis[3].y = pos.y;
		_allAxis[0].z = num2 * (q.x * q.z) - num2 * (q.y * q.w);
		_allAxis[0].z *= scale.z;
		_allAxis[1].z = num2 * (q.y * q.z) + num2 * (q.x * q.w);
		_allAxis[1].z *= scale.z;
		_allAxis[2].z = num - (num2 * (q.x * q.x) + num2 * (q.y * q.y));
		_allAxis[2].z *= scale.z;
		_allAxis[3].z = pos.z;
	}

	public void Clear()
	{
		_allAxis[0].x = 1f;
		_allAxis[1].x = 0f;
		_allAxis[2].x = 0f;
		_allAxis[3].x = 0f;
		_allAxis[0].y = 0f;
		_allAxis[1].y = 1f;
		_allAxis[2].y = 0f;
		_allAxis[3].y = 0f;
		_allAxis[0].z = 0f;
		_allAxis[1].z = 0f;
		_allAxis[2].z = 1f;
		_allAxis[3].z = 0f;
	}
}
