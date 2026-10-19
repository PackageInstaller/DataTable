using System;
using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Utility;

public static class DebugUtility
{
	private static readonly Vector4[] s_UnitSphere = MakeUnitSphere(16);

	private static readonly Vector4[] s_UnitSquare = new Vector4[4]
	{
		new Vector4(-0.5f, 0.5f, 0f, 1f),
		new Vector4(0.5f, 0.5f, 0f, 1f),
		new Vector4(0.5f, -0.5f, 0f, 1f),
		new Vector4(-0.5f, -0.5f, 0f, 1f)
	};

	public static void DrawRect(Rect rect, Color color, float duration)
	{
		Vector2 position = rect.position;
		Vector2 vector = rect.position + Vector2.right * rect.width;
		Vector2 vector2 = rect.position + Vector2.up * rect.height;
		Vector2 vector3 = rect.position + rect.size;
		Debug.DrawLine(position, vector, color, duration);
		Debug.DrawLine(vector, vector3, color, duration);
		Debug.DrawLine(vector3, vector2, color, duration);
		Debug.DrawLine(vector2, position, color, duration);
	}

	public static void DrawArrow(Vector3 from, Vector3 to, float arrowSize)
	{
	}

	private static Vector4[] MakeUnitSphere(int len)
	{
		Vector4[] array = new Vector4[len * 3];
		for (int i = 0; i < len; i++)
		{
			float num = (float)i / (float)len;
			float num2 = Mathf.Cos(num * (MathF.PI * 2f));
			float num3 = Mathf.Sin(num * (MathF.PI * 2f));
			array[i] = new Vector4(num2, num3, 0f, 1f);
			array[len + i] = new Vector4(0f, num2, num3, 1f);
			array[2 * len + i] = new Vector4(num3, 0f, num2, 1f);
		}
		return array;
	}

	public static void DrawSphere(Vector4 pos, float radius, Color color, float duration = 1f)
	{
		Vector4[] array = s_UnitSphere;
		int num = s_UnitSphere.Length / 3;
		for (int i = 0; i < num; i++)
		{
			Vector4 vector = pos + radius * array[i];
			Vector4 vector2 = pos + radius * array[(i + 1) % num];
			Vector4 vector3 = pos + radius * array[num + i];
			Vector4 vector4 = pos + radius * array[num + (i + 1) % num];
			Vector4 vector5 = pos + radius * array[2 * num + i];
			Vector4 vector6 = pos + radius * array[2 * num + (i + 1) % num];
			Debug.DrawLine(vector, vector2, color, duration);
			Debug.DrawLine(vector3, vector4, color, duration);
			Debug.DrawLine(vector5, vector6, color, duration);
		}
	}

	public static string Adjust1AttackTypeTagToString(Adjust1AttackTypeTag tag)
	{
		return tag.ToString();
	}

	public static string Adjust2AttackTypeTagToString(Adjust2AttackTypeTag tag)
	{
		return tag.ToString();
	}

	public static string HitTypeToString(HitType hitType)
	{
		return hitType.ToString();
	}
}
