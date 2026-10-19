using System;
using UnityEngine;

namespace ACT.EditorTools;

[ExecuteInEditMode]
[AddComponentMenu("1策划工具/点显示PositionTracing")]
public class PositionTracing : MonoBehaviour
{
	public float radius = 0.1f;

	public Color color = Color.red;

	public float time = 1f;

	public float CD;

	public bool use = true;

	private float curTime;

	private static readonly Vector4[] s_UnitSphere = MakeUnitSphere(16);

	private static readonly Vector4[] s_UnitSquare = new Vector4[4]
	{
		new Vector4(-0.5f, 0.5f, 0f, 1f),
		new Vector4(0.5f, 0.5f, 0f, 1f),
		new Vector4(0.5f, -0.5f, 0f, 1f),
		new Vector4(-0.5f, -0.5f, 0f, 1f)
	};

	private void Start()
	{
		curTime = 0f;
	}

	private void Update()
	{
		if (use)
		{
			curTime += Time.deltaTime;
			if (curTime >= CD)
			{
				curTime = 0f;
				DrawSphere(new Vector4(transform.position.x, transform.position.y, transform.position.z, 0f), radius, Color.red, time);
			}
		}
		else
		{
			curTime = 0f;
		}
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
}
