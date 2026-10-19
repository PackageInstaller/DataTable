using System;
using UnityEngine;

namespace EasyCharacterMovement;

public static class Extensions
{
	private const int InsertionSortThreshold = 16;

	public static int square(this int value)
	{
		return value * value;
	}

	public static float square(this float value)
	{
		return value * value;
	}

	public static bool isZero(this float value)
	{
		return Mathf.Abs(value) < 1E-10f;
	}

	public static Vector3 onlyX(this Vector3 vector3)
	{
		vector3.y = 0f;
		vector3.z = 0f;
		return vector3;
	}

	public static Vector3 onlyY(this Vector3 vector3)
	{
		vector3.x = 0f;
		vector3.z = 0f;
		return vector3;
	}

	public static Vector3 onlyZ(this Vector3 vector3)
	{
		vector3.x = 0f;
		vector3.y = 0f;
		return vector3;
	}

	public static Vector3 onlyXZ(this Vector3 vector3)
	{
		vector3.y = 0f;
		return vector3;
	}

	public static bool isZero(this Vector2 vector2)
	{
		return (double)vector2.sqrMagnitude < 9.99999943962493E-11;
	}

	public static bool isZero(this Vector3 vector3)
	{
		return (double)vector3.sqrMagnitude < 9.99999943962493E-11;
	}

	public static bool isExceeding(this Vector3 vector3, float magnitude)
	{
		return vector3.sqrMagnitude > magnitude * magnitude * 1.01f;
	}

	public static Vector3 normalized(this Vector3 vector3, out float magnitude)
	{
		magnitude = vector3.magnitude;
		if ((double)magnitude > 9.99999974737875E-06)
		{
			return vector3 / magnitude;
		}
		magnitude = 0f;
		return Vector3.zero;
	}

	public static float dot(this Vector3 vector3, Vector3 otherVector3)
	{
		return Vector3.Dot(vector3, otherVector3);
	}

	public static Vector3 projectedOn(this Vector3 thisVector, Vector3 normal)
	{
		return Vector3.Project(thisVector, normal);
	}

	public static Vector3 projectedOnPlane(this Vector3 thisVector, Vector3 planeNormal)
	{
		return Vector3.ProjectOnPlane(thisVector, planeNormal);
	}

	public static Vector3 clampedTo(this Vector3 vector3, float maxLength)
	{
		return Vector3.ClampMagnitude(vector3, maxLength);
	}

	public static Vector3 perpendicularTo(this Vector3 thisVector, Vector3 otherVector)
	{
		return Vector3.Cross(thisVector, otherVector).normalized;
	}

	public static Vector3 tangentTo(this Vector3 thisVector, Vector3 normal, Vector3 up)
	{
		Vector3 otherVector = thisVector.perpendicularTo(up);
		return normal.perpendicularTo(otherVector) * thisVector.magnitude;
	}

	public static Vector3 relativeTo(this Vector3 vector3, Transform relativeToThis, bool isPlanar = true)
	{
		Vector3 vector4 = relativeToThis.forward;
		if (isPlanar)
		{
			Vector3 up = Vector3.up;
			vector4 = vector4.projectedOnPlane(up);
			if (vector4.isZero())
			{
				vector4 = Vector3.ProjectOnPlane(relativeToThis.up, up);
			}
		}
		return Quaternion.LookRotation(vector4) * vector3;
	}

	public static Vector3 relativeTo(this Vector3 vector3, Transform relativeToThis, Vector3 upAxis, bool isPlanar = true)
	{
		Vector3 vector4 = relativeToThis.forward;
		if (isPlanar)
		{
			vector4 = Vector3.ProjectOnPlane(vector4, upAxis);
			if (vector4.isZero())
			{
				vector4 = Vector3.ProjectOnPlane(relativeToThis.up, upAxis);
			}
		}
		return Quaternion.LookRotation(vector4, upAxis) * vector3;
	}

	public static Quaternion clampPitch(this Quaternion quaternion, float minPitchAngle, float maxPitchAngle)
	{
		quaternion.x /= quaternion.w;
		quaternion.y /= quaternion.w;
		quaternion.z /= quaternion.w;
		quaternion.w = 1f;
		float num = Mathf.Clamp(114.59156f * Mathf.Atan(quaternion.x), minPitchAngle, maxPitchAngle);
		quaternion.x = Mathf.Tan(num * 0.5f * (MathF.PI / 180f));
		return quaternion;
	}

	public static void Sort<T>(this T[] array, int index, int length, Comparison<T> comparison)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (comparison == null)
		{
			throw new ArgumentNullException("comparison");
		}
		if (index < 0 || length < 0 || index + length > array.Length)
		{
			throw new ArgumentOutOfRangeException();
		}
		if (length > 1)
		{
			QuickSort(array, index, index + length - 1, comparison);
		}
	}

	private static void QuickSort<T>(T[] array, int low, int high, Comparison<T> comparison)
	{
		while (low < high)
		{
			if (high - low < 16)
			{
				InsertionSort(array, low, high, comparison);
				break;
			}
			int num = Partition(array, low, high, comparison);
			if (num - low < high - num)
			{
				QuickSort(array, low, num - 1, comparison);
				low = num + 1;
			}
			else
			{
				QuickSort(array, num + 1, high, comparison);
				high = num - 1;
			}
		}
	}

	private static void InsertionSort<T>(T[] array, int low, int high, Comparison<T> comparison)
	{
		for (int i = low + 1; i <= high; i++)
		{
			T val = array[i];
			int num = i - 1;
			while (num >= low && comparison(array[num], val) > 0)
			{
				array[num + 1] = array[num];
				num--;
			}
			array[num + 1] = val;
		}
	}

	private static int Partition<T>(T[] array, int low, int high, Comparison<T> comparison)
	{
		T y = array[high];
		int num = low - 1;
		for (int i = low; i < high; i++)
		{
			if (comparison(array[i], y) <= 0)
			{
				num++;
				Swap(array, num, i);
			}
		}
		Swap(array, num + 1, high);
		return num + 1;
	}

	private static void Swap<T>(T[] array, int i, int j)
	{
		T val = array[j];
		T val2 = array[i];
		array[i] = val;
		array[j] = val2;
	}
}
