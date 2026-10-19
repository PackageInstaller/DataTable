using System;
using System.Reflection;
using UnityEngine;

namespace DG.Tweening.Core;

public static class DOTweenUtils
{
	private static Assembly[] _loadedAssemblies;

	private static readonly string[] _defAssembliesToQuery = new string[3] { "DOTween.Modules", "Assembly-CSharp", "Assembly-CSharp-firstpass" };

	internal static Vector3 Vector3FromAngle(float degrees, float magnitude)
	{
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		float num = degrees * ((float)Math.PI / 180f);
		return new Vector3(magnitude * Mathf.Cos(num), magnitude * Mathf.Sin(num), 0f);
	}

	internal static float Angle2D(Vector3 from, Vector3 to)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		Vector2 right = Vector2.right;
		to -= from;
		float num = Vector2.Angle(right, Vector2.op_Implicit(to));
		if (Vector3.Cross(Vector2.op_Implicit(right), to).z > 0f)
		{
			num = 360f - num;
		}
		return num * -1f;
	}

	internal static Vector3 RotateAroundPivot(Vector3 point, Vector3 pivot, Quaternion rotation)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		return rotation * (point - pivot) + pivot;
	}

	public static Vector2 GetPointOnCircle(Vector2 center, float radius, float degrees)
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		degrees = 90f - degrees;
		float num = degrees * ((float)Math.PI / 180f);
		return center + new Vector2(Mathf.Cos(num), Mathf.Sin(num)) * radius;
	}

	internal static bool Vector3AreApproximatelyEqual(Vector3 a, Vector3 b)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		if (Mathf.Approximately(a.x, b.x) && Mathf.Approximately(a.y, b.y))
		{
			return Mathf.Approximately(a.z, b.z);
		}
		return false;
	}

	internal static Type GetLooseScriptType(string typeName)
	{
		for (int i = 0; i < _defAssembliesToQuery.Length; i++)
		{
			Type type = Type.GetType($"{typeName}, {_defAssembliesToQuery[i]}");
			if ((object)type != null)
			{
				return type;
			}
		}
		if (_loadedAssemblies == null)
		{
			_loadedAssemblies = AppDomain.CurrentDomain.GetAssemblies();
		}
		for (int j = 0; j < _loadedAssemblies.Length; j++)
		{
			Type type2 = Type.GetType($"{typeName}, {_loadedAssemblies[j].GetName()}");
			if ((object)type2 != null)
			{
				return type2;
			}
		}
		return null;
	}
}
