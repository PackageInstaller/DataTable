using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using Unity.IL2CPP.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[Il2CppEagerStaticClassConstruction]
[NativeType(Header = "Runtime/Math/Matrix4x4.h")]
[RequiredByNativeCode(Optional = true, GenerateProxy = true)]
[NativeClass("Matrix4x4f")]
[NativeHeader("Runtime/Math/MathScripting.h")]
public struct Matrix4x4(Vector4 column0, Vector4 column1, Vector4 column2, Vector4 column3) : IEquatable<Matrix4x4>, IFormattable
{
	[NativeName("m_Data[0]")]
	public float m00 = column0.x;

	[NativeName("m_Data[1]")]
	public float m10 = column0.y;

	[NativeName("m_Data[2]")]
	public float m20 = column0.z;

	[NativeName("m_Data[3]")]
	public float m30 = column0.w;

	[NativeName("m_Data[4]")]
	public float m01 = column1.x;

	[NativeName("m_Data[5]")]
	public float m11 = column1.y;

	[NativeName("m_Data[6]")]
	public float m21 = column1.z;

	[NativeName("m_Data[7]")]
	public float m31 = column1.w;

	[NativeName("m_Data[8]")]
	public float m02 = column2.x;

	[NativeName("m_Data[9]")]
	public float m12 = column2.y;

	[NativeName("m_Data[10]")]
	public float m22 = column2.z;

	[NativeName("m_Data[11]")]
	public float m32 = column2.w;

	[NativeName("m_Data[12]")]
	public float m03 = column3.x;

	[NativeName("m_Data[13]")]
	public float m13 = column3.y;

	[NativeName("m_Data[14]")]
	public float m23 = column3.z;

	[NativeName("m_Data[15]")]
	public float m33 = column3.w;

	private static readonly Matrix4x4 zeroMatrix = new Matrix4x4(new Vector4(0f, 0f, 0f, 0f), new Vector4(0f, 0f, 0f, 0f), new Vector4(0f, 0f, 0f, 0f), new Vector4(0f, 0f, 0f, 0f));

	private static readonly Matrix4x4 identityMatrix = new Matrix4x4(new Vector4(1f, 0f, 0f, 0f), new Vector4(0f, 1f, 0f, 0f), new Vector4(0f, 0f, 1f, 0f), new Vector4(0f, 0f, 0f, 1f));

	public float this[int row, int column]
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return this[row + column * 4];
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			this[row + column * 4] = value;
		}
	}

	public float this[int index]
	{
		get
		{
			return index switch
			{
				0 => m00, 
				1 => m10, 
				2 => m20, 
				3 => m30, 
				4 => m01, 
				5 => m11, 
				6 => m21, 
				7 => m31, 
				8 => m02, 
				9 => m12, 
				10 => m22, 
				11 => m32, 
				12 => m03, 
				13 => m13, 
				14 => m23, 
				15 => m33, 
				_ => throw new IndexOutOfRangeException("Invalid matrix index!"), 
			};
		}
		set
		{
			switch (index)
			{
			case 0:
				m00 = value;
				break;
			case 1:
				m10 = value;
				break;
			case 2:
				m20 = value;
				break;
			case 3:
				m30 = value;
				break;
			case 4:
				m01 = value;
				break;
			case 5:
				m11 = value;
				break;
			case 6:
				m21 = value;
				break;
			case 7:
				m31 = value;
				break;
			case 8:
				m02 = value;
				break;
			case 9:
				m12 = value;
				break;
			case 10:
				m22 = value;
				break;
			case 11:
				m32 = value;
				break;
			case 12:
				m03 = value;
				break;
			case 13:
				m13 = value;
				break;
			case 14:
				m23 = value;
				break;
			case 15:
				m33 = value;
				break;
			default:
				throw new IndexOutOfRangeException("Invalid matrix index!");
			}
		}
	}

	public static Matrix4x4 zero => zeroMatrix;

	public static Matrix4x4 identity
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return identityMatrix;
		}
	}

	public Quaternion rotation => GetRotation();

	public Vector3 lossyScale => GetLossyScale();

	public bool isIdentity => IsIdentity();

	public float determinant => GetDeterminant();

	public FrustumPlanes decomposeProjection => DecomposeProjection();

	public Matrix4x4 inverse => Inverse(this);

	public Matrix4x4 transpose => Transpose(this);

	[MethodImpl((MethodImplOptions)256)]
	public override int GetHashCode()
	{
		return GetColumn(0).GetHashCode() ^ (GetColumn(1).GetHashCode() << 2) ^ (GetColumn(2).GetHashCode() >> 2) ^ (GetColumn(3).GetHashCode() >> 1);
	}

	[MethodImpl((MethodImplOptions)256)]
	public override bool Equals(object other)
	{
		if (!(other is Matrix4x4))
		{
			return false;
		}
		return Equals((Matrix4x4)other);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(Matrix4x4 other)
	{
		return GetColumn(0).Equals(other.GetColumn(0)) && GetColumn(1).Equals(other.GetColumn(1)) && GetColumn(2).Equals(other.GetColumn(2)) && GetColumn(3).Equals(other.GetColumn(3));
	}

	public static Matrix4x4 operator *(Matrix4x4 lhs, Matrix4x4 rhs)
	{
		Matrix4x4 result = default(Matrix4x4);
		result.m00 = lhs.m00 * rhs.m00 + lhs.m01 * rhs.m10 + lhs.m02 * rhs.m20 + lhs.m03 * rhs.m30;
		result.m01 = lhs.m00 * rhs.m01 + lhs.m01 * rhs.m11 + lhs.m02 * rhs.m21 + lhs.m03 * rhs.m31;
		result.m02 = lhs.m00 * rhs.m02 + lhs.m01 * rhs.m12 + lhs.m02 * rhs.m22 + lhs.m03 * rhs.m32;
		result.m03 = lhs.m00 * rhs.m03 + lhs.m01 * rhs.m13 + lhs.m02 * rhs.m23 + lhs.m03 * rhs.m33;
		result.m10 = lhs.m10 * rhs.m00 + lhs.m11 * rhs.m10 + lhs.m12 * rhs.m20 + lhs.m13 * rhs.m30;
		result.m11 = lhs.m10 * rhs.m01 + lhs.m11 * rhs.m11 + lhs.m12 * rhs.m21 + lhs.m13 * rhs.m31;
		result.m12 = lhs.m10 * rhs.m02 + lhs.m11 * rhs.m12 + lhs.m12 * rhs.m22 + lhs.m13 * rhs.m32;
		result.m13 = lhs.m10 * rhs.m03 + lhs.m11 * rhs.m13 + lhs.m12 * rhs.m23 + lhs.m13 * rhs.m33;
		result.m20 = lhs.m20 * rhs.m00 + lhs.m21 * rhs.m10 + lhs.m22 * rhs.m20 + lhs.m23 * rhs.m30;
		result.m21 = lhs.m20 * rhs.m01 + lhs.m21 * rhs.m11 + lhs.m22 * rhs.m21 + lhs.m23 * rhs.m31;
		result.m22 = lhs.m20 * rhs.m02 + lhs.m21 * rhs.m12 + lhs.m22 * rhs.m22 + lhs.m23 * rhs.m32;
		result.m23 = lhs.m20 * rhs.m03 + lhs.m21 * rhs.m13 + lhs.m22 * rhs.m23 + lhs.m23 * rhs.m33;
		result.m30 = lhs.m30 * rhs.m00 + lhs.m31 * rhs.m10 + lhs.m32 * rhs.m20 + lhs.m33 * rhs.m30;
		result.m31 = lhs.m30 * rhs.m01 + lhs.m31 * rhs.m11 + lhs.m32 * rhs.m21 + lhs.m33 * rhs.m31;
		result.m32 = lhs.m30 * rhs.m02 + lhs.m31 * rhs.m12 + lhs.m32 * rhs.m22 + lhs.m33 * rhs.m32;
		result.m33 = lhs.m30 * rhs.m03 + lhs.m31 * rhs.m13 + lhs.m32 * rhs.m23 + lhs.m33 * rhs.m33;
		return result;
	}

	public static Vector4 operator *(Matrix4x4 lhs, Vector4 vector)
	{
		Vector4 result = default(Vector4);
		result.x = lhs.m00 * vector.x + lhs.m01 * vector.y + lhs.m02 * vector.z + lhs.m03 * vector.w;
		result.y = lhs.m10 * vector.x + lhs.m11 * vector.y + lhs.m12 * vector.z + lhs.m13 * vector.w;
		result.z = lhs.m20 * vector.x + lhs.m21 * vector.y + lhs.m22 * vector.z + lhs.m23 * vector.w;
		result.w = lhs.m30 * vector.x + lhs.m31 * vector.y + lhs.m32 * vector.z + lhs.m33 * vector.w;
		return result;
	}

	public static bool operator ==(Matrix4x4 lhs, Matrix4x4 rhs)
	{
		return lhs.GetColumn(0) == rhs.GetColumn(0) && lhs.GetColumn(1) == rhs.GetColumn(1) && lhs.GetColumn(2) == rhs.GetColumn(2) && lhs.GetColumn(3) == rhs.GetColumn(3);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator !=(Matrix4x4 lhs, Matrix4x4 rhs)
	{
		return !(lhs == rhs);
	}

	public Vector4 GetColumn(int index)
	{
		return index switch
		{
			0 => new Vector4(m00, m10, m20, m30), 
			1 => new Vector4(m01, m11, m21, m31), 
			2 => new Vector4(m02, m12, m22, m32), 
			3 => new Vector4(m03, m13, m23, m33), 
			_ => throw new IndexOutOfRangeException("Invalid column index!"), 
		};
	}

	public Vector4 GetRow(int index)
	{
		return index switch
		{
			0 => new Vector4(m00, m01, m02, m03), 
			1 => new Vector4(m10, m11, m12, m13), 
			2 => new Vector4(m20, m21, m22, m23), 
			3 => new Vector4(m30, m31, m32, m33), 
			_ => throw new IndexOutOfRangeException("Invalid row index!"), 
		};
	}

	public Vector3 GetPosition()
	{
		return new Vector3(m03, m13, m23);
	}

	public void SetColumn(int index, Vector4 column)
	{
		this[0, index] = column.x;
		this[1, index] = column.y;
		this[2, index] = column.z;
		this[3, index] = column.w;
	}

	public void SetRow(int index, Vector4 row)
	{
		this[index, 0] = row.x;
		this[index, 1] = row.y;
		this[index, 2] = row.z;
		this[index, 3] = row.w;
	}

	public Vector3 MultiplyPoint(Vector3 point)
	{
		Vector3 result = default(Vector3);
		result.x = m00 * point.x + m01 * point.y + m02 * point.z + m03;
		result.y = m10 * point.x + m11 * point.y + m12 * point.z + m13;
		result.z = m20 * point.x + m21 * point.y + m22 * point.z + m23;
		float num = m30 * point.x + m31 * point.y + m32 * point.z + m33;
		num = 1f / num;
		result.x *= num;
		result.y *= num;
		result.z *= num;
		return result;
	}

	public Vector3 MultiplyPoint3x4(Vector3 point)
	{
		Vector3 result = default(Vector3);
		result.x = m00 * point.x + m01 * point.y + m02 * point.z + m03;
		result.y = m10 * point.x + m11 * point.y + m12 * point.z + m13;
		result.z = m20 * point.x + m21 * point.y + m22 * point.z + m23;
		return result;
	}

	public Vector3 MultiplyVector(Vector3 vector)
	{
		Vector3 result = default(Vector3);
		result.x = m00 * vector.x + m01 * vector.y + m02 * vector.z;
		result.y = m10 * vector.x + m11 * vector.y + m12 * vector.z;
		result.z = m20 * vector.x + m21 * vector.y + m22 * vector.z;
		return result;
	}

	public Plane TransformPlane(Plane plane)
	{
		Matrix4x4 matrix4x = inverse;
		float x = plane.normal.x;
		float y = plane.normal.y;
		float z = plane.normal.z;
		float distance = plane.distance;
		float x2 = matrix4x.m00 * x + matrix4x.m10 * y + matrix4x.m20 * z + matrix4x.m30 * distance;
		float y2 = matrix4x.m01 * x + matrix4x.m11 * y + matrix4x.m21 * z + matrix4x.m31 * distance;
		float z2 = matrix4x.m02 * x + matrix4x.m12 * y + matrix4x.m22 * z + matrix4x.m32 * distance;
		float d = matrix4x.m03 * x + matrix4x.m13 * y + matrix4x.m23 * z + matrix4x.m33 * distance;
		return new Plane(new Vector3(x2, y2, z2), d);
	}

	public static Matrix4x4 Scale(Vector3 vector)
	{
		Matrix4x4 result = default(Matrix4x4);
		result.m00 = vector.x;
		result.m01 = 0f;
		result.m02 = 0f;
		result.m03 = 0f;
		result.m10 = 0f;
		result.m11 = vector.y;
		result.m12 = 0f;
		result.m13 = 0f;
		result.m20 = 0f;
		result.m21 = 0f;
		result.m22 = vector.z;
		result.m23 = 0f;
		result.m30 = 0f;
		result.m31 = 0f;
		result.m32 = 0f;
		result.m33 = 1f;
		return result;
	}

	public static Matrix4x4 Translate(Vector3 vector)
	{
		Matrix4x4 result = default(Matrix4x4);
		result.m00 = 1f;
		result.m01 = 0f;
		result.m02 = 0f;
		result.m03 = vector.x;
		result.m10 = 0f;
		result.m11 = 1f;
		result.m12 = 0f;
		result.m13 = vector.y;
		result.m20 = 0f;
		result.m21 = 0f;
		result.m22 = 1f;
		result.m23 = vector.z;
		result.m30 = 0f;
		result.m31 = 0f;
		result.m32 = 0f;
		result.m33 = 1f;
		return result;
	}

	public static Matrix4x4 Rotate(Quaternion q)
	{
		float num = q.x * 2f;
		float num2 = q.y * 2f;
		float num3 = q.z * 2f;
		float num4 = q.x * num;
		float num5 = q.y * num2;
		float num6 = q.z * num3;
		float num7 = q.x * num2;
		float num8 = q.x * num3;
		float num9 = q.y * num3;
		float num10 = q.w * num;
		float num11 = q.w * num2;
		float num12 = q.w * num3;
		Matrix4x4 result = default(Matrix4x4);
		result.m00 = 1f - (num5 + num6);
		result.m10 = num7 + num12;
		result.m20 = num8 - num11;
		result.m30 = 0f;
		result.m01 = num7 - num12;
		result.m11 = 1f - (num4 + num6);
		result.m21 = num9 + num10;
		result.m31 = 0f;
		result.m02 = num8 + num11;
		result.m12 = num9 - num10;
		result.m22 = 1f - (num4 + num5);
		result.m32 = 0f;
		result.m03 = 0f;
		result.m13 = 0f;
		result.m23 = 0f;
		result.m33 = 1f;
		return result;
	}

	public override string ToString()
	{
		return ToString(null, null);
	}

	public string ToString(string format)
	{
		return ToString(format, null);
	}

	public string ToString(string format, IFormatProvider formatProvider)
	{
		if (string.IsNullOrEmpty(format))
		{
			format = "F5";
		}
		if (formatProvider == null)
		{
			formatProvider = CultureInfo.InvariantCulture.NumberFormat;
		}
		return UnityString.Format("{0}\t{1}\t{2}\t{3}\n{4}\t{5}\t{6}\t{7}\n{8}\t{9}\t{10}\t{11}\n{12}\t{13}\t{14}\t{15}\n", new object[16]
		{
			m00.ToString(format, formatProvider),
			m01.ToString(format, formatProvider),
			m02.ToString(format, formatProvider),
			m03.ToString(format, formatProvider),
			m10.ToString(format, formatProvider),
			m11.ToString(format, formatProvider),
			m12.ToString(format, formatProvider),
			m13.ToString(format, formatProvider),
			m20.ToString(format, formatProvider),
			m21.ToString(format, formatProvider),
			m22.ToString(format, formatProvider),
			m23.ToString(format, formatProvider),
			m30.ToString(format, formatProvider),
			m31.ToString(format, formatProvider),
			m32.ToString(format, formatProvider),
			m33.ToString(format, formatProvider)
		});
	}

	[ThreadSafe]
	private Quaternion GetRotation()
	{
		GetRotation_Injected(ref this, out var ret);
		return ret;
	}

	[ThreadSafe]
	private Vector3 GetLossyScale()
	{
		GetLossyScale_Injected(ref this, out var ret);
		return ret;
	}

	[ThreadSafe]
	private bool IsIdentity()
	{
		return IsIdentity_Injected(ref this);
	}

	[ThreadSafe]
	private float GetDeterminant()
	{
		return GetDeterminant_Injected(ref this);
	}

	[ThreadSafe]
	private FrustumPlanes DecomposeProjection()
	{
		DecomposeProjection_Injected(ref this, out var ret);
		return ret;
	}

	[ThreadSafe]
	public bool ValidTRS()
	{
		return ValidTRS_Injected(ref this);
	}

	public static float Determinant(Matrix4x4 m)
	{
		return m.determinant;
	}

	[FreeFunction("MatrixScripting::TRS", IsThreadSafe = true)]
	public static Matrix4x4 TRS(Vector3 pos, Quaternion q, Vector3 s)
	{
		TRS_Injected(ref pos, ref q, ref s, out var ret);
		return ret;
	}

	public void SetTRS(Vector3 pos, Quaternion q, Vector3 s)
	{
		this = TRS(pos, q, s);
	}

	[FreeFunction("MatrixScripting::Inverse3DAffine", IsThreadSafe = true)]
	public static bool Inverse3DAffine(Matrix4x4 input, ref Matrix4x4 result)
	{
		return Inverse3DAffine_Injected(ref input, ref result);
	}

	[FreeFunction("MatrixScripting::Inverse", IsThreadSafe = true)]
	public static Matrix4x4 Inverse(Matrix4x4 m)
	{
		Inverse_Injected(ref m, out var ret);
		return ret;
	}

	[FreeFunction("MatrixScripting::Transpose", IsThreadSafe = true)]
	public static Matrix4x4 Transpose(Matrix4x4 m)
	{
		Transpose_Injected(ref m, out var ret);
		return ret;
	}

	[FreeFunction("MatrixScripting::Ortho", IsThreadSafe = true)]
	public static Matrix4x4 Ortho(float left, float right, float bottom, float top, float zNear, float zFar)
	{
		Ortho_Injected(left, right, bottom, top, zNear, zFar, out var ret);
		return ret;
	}

	[FreeFunction("MatrixScripting::Perspective", IsThreadSafe = true)]
	public static Matrix4x4 Perspective(float fov, float aspect, float zNear, float zFar)
	{
		Perspective_Injected(fov, aspect, zNear, zFar, out var ret);
		return ret;
	}

	[FreeFunction("MatrixScripting::LookAt", IsThreadSafe = true)]
	public static Matrix4x4 LookAt(Vector3 from, Vector3 to, Vector3 up)
	{
		LookAt_Injected(ref from, ref to, ref up, out var ret);
		return ret;
	}

	[FreeFunction("MatrixScripting::Frustum", IsThreadSafe = true)]
	public static Matrix4x4 Frustum(float left, float right, float bottom, float top, float zNear, float zFar)
	{
		Frustum_Injected(left, right, bottom, top, zNear, zFar, out var ret);
		return ret;
	}

	public static Matrix4x4 Frustum(FrustumPlanes fp)
	{
		return Frustum(fp.left, fp.right, fp.bottom, fp.top, fp.zNear, fp.zFar);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetRotation_Injected(ref Matrix4x4 _unity_self, out Quaternion ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetLossyScale_Injected(ref Matrix4x4 _unity_self, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsIdentity_Injected(ref Matrix4x4 _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern float GetDeterminant_Injected(ref Matrix4x4 _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DecomposeProjection_Injected(ref Matrix4x4 _unity_self, out FrustumPlanes ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool ValidTRS_Injected(ref Matrix4x4 _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void TRS_Injected(ref Vector3 pos, ref Quaternion q, ref Vector3 s, out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool Inverse3DAffine_Injected(ref Matrix4x4 input, ref Matrix4x4 result);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Inverse_Injected(ref Matrix4x4 m, out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Transpose_Injected(ref Matrix4x4 m, out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Ortho_Injected(float left, float right, float bottom, float top, float zNear, float zFar, out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Perspective_Injected(float fov, float aspect, float zNear, float zFar, out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void LookAt_Injected(ref Vector3 from, ref Vector3 to, ref Vector3 up, out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Frustum_Injected(float left, float right, float bottom, float top, float zNear, float zFar, out Matrix4x4 ret);
}
